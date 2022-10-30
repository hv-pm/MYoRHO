//-----------------------------------------------------------------------------CABEÇALHO-----------------------------------------------------------------------------
// Autor: Hygor Vinícius Pereira Martins (2022)
//        ESP32_SRA (https://github.com/hv-pm/MYoRHO/tree/main/SRA_ESP32)
//
// Arduino IDE v1.8.1
//
// Bibliotecas utilizadas: 
//                        BLEDevice (https://github.com/espressif/arduino-esp32/blob/master/libraries/BLE/src/BLEDevice.h)
//                        EEPROM (https://github.com/espressif/arduino-esp32/blob/master/libraries/EEPROM/src/EEPROM.h)
// Adaptado de:
//             BLE client (https://github.com/nkolban/esp32-snippets/blob/master/cpp_utils/tests/BLETests/SampleClient.cpp)

//----------------------------------------------------------------------------BIBLIOTECAS----------------------------------------------------------------------------
#include <EEPROM.h> // Permite alocar os dados de posição dos motores DC na memória EEPROM do ESP32.
#include "BLEDevice.h" // Permite uso dos comandos do bluetooth de baixa energia da plataforma ESP32.

//---------------------------------ENCODERS---------------------------------
volatile const byte Encoder_Pa1 = 22; // Pino de fase A do encoder do Motor 1 (PA1).
volatile const byte Encoder_Pb1 = 21; // Pino de fase B do encoder do Motor 1 (PB1).
volatile const byte Encoder_Pa2 = 27; // Pino de fase A do encoder do Motor 2 (PA2).
volatile const byte Encoder_Pb2 = 14; // Pino de fase B do encoder do Motor 2 (PB2).

//--------------------------------PIN MOTOR--------------------------------
int IN1 = 26; // Pino M1- <-> Bout1 <-> DRV8833 <-> Bin1 do Motor 1.
int IN2 = 25; // Pino M1+ <-> Bout2 <-> DRV8833 <-> Bin2 do Motor 1.
int IN3 = 18; // Pino M2- <-> Aout1 <-> DRV8833 <-> Ain1 do Motor 2.
int IN4 = 19; // Pino M2+ <-> Aout2 <-> DRV8833 <-> Ain2 do Motor 2.

//------------------------------VAR. GLOBAIS-------------------------------
#define ONBOARD_LED  2 // LED embutido no ESP32.
volatile byte Encoder_Pa1_Last; // Estado anterior do Encoder_Pa1, usado para comparação de fase do encoder.
volatile byte Encoder_Pb2_Last; // Estado anterior do Encoder_Pb2, usado para comparação de fase do encoder.
volatile int posicao_enc1; // Armazena o número de voltas dadas no eixo do motor 1, contadas pelo encoder (posição do motor 1).
volatile boolean Direcao; // Compara o sentido de giro, a depender do sentido, incrementa ou decrementa da posição as voltas dadas no eixo do motor 1.
volatile int posicao_enc2; // Armazena o número de voltas dadas no eixo do motor 2, contadas pelo encoder (posição do motor 2).
volatile boolean Direcao2; // Compara o sentido de giro, a depender do sentido, incrementa ou decrementa da posição as voltas dadas no eixo do motor 2.

// Máquina de Estados Finitos.
// Estados possíveis.
// eMR = estado mão em repouso.
// ePP = estado preensão pinça.
// ePC = estado preensão cilíndrica.

// Estado inicial da Máquina de Estados Finitos.
String estado_atual = "eMR"; // Estado atual definida como mão em repouso no início da máquina de estados finitos.
String cl_an = "MR"; // Classe anterior definida como mão em repouso no início da máquina de estados finitos.
bool primeira_trans = true; // Ativa flag para receber a primeira transmissão do STI ao início do SRA.

//-------------------------------ENDEREÇO_BLE-------------------------------
// Endereço do STI.
static BLEUUID serviceUUID("f57b1135-8c51-4e7b-be18-07b9cfa1507a");
// O endereço do dado que iremos receber.
static BLEUUID    charUUID("ad87f04a-5075-4109-8b84-f0b1b8ed173f");

static boolean doConnect = false;
static boolean connected = false;
static boolean doScan = false;
static BLERemoteCharacteristic* pRemoteCharacteristic;
static BLEAdvertisedDevice* myDevice;
std::string cl_rec;

//------------------------------CONFIGURANDO BLE----------------------------
static void notifyCallback(
  BLERemoteCharacteristic* pBLERemoteCharacteristic,
  uint8_t* pData,
  size_t length,
  bool isNotify) {
  Serial.print("Notifica callback para o endereço ");
  Serial.print(pBLERemoteCharacteristic->getUUID().toString().c_str());
  Serial.print(" de tamanho ");
  Serial.println(length);
  Serial.print("dado: ");
  Serial.println((char*)pData);
}

class MyClientCallback : public BLEClientCallbacks {
    void onConnect(BLEClient* pclient) {
      digitalWrite(ONBOARD_LED, HIGH); // Ao conectar com o STI, acende o LED imbutido no ESP32.
    }

    void onDisconnect(BLEClient* pclient) {
      connected = false;
      Serial.println("onDisconnect");
      digitalWrite(ONBOARD_LED, LOW); // Ao desconectar com o STI, apaga o LED imbutido no ESP32.
    }
};

bool connectToServer() {
  Serial.print("Se conectando a ");
  Serial.println(myDevice->getAddress().toString().c_str());

  BLEClient*  pClient  = BLEDevice::createClient();
  Serial.println(" - Criando cliente SRA");

  pClient->setClientCallbacks(new MyClientCallback());

  pClient->connect(myDevice); // Executa a rotina onResult da classe MyAdvertisedDeviceCallbacks, ao fim desta seção.
  Serial.println(" - Conectado a STI");

  BLERemoteService* pRemoteService = pClient->getService(serviceUUID);
  if (pRemoteService == nullptr) {
    Serial.print("Não foi possível encontrar o endereço do STI, UUID: ");
    Serial.println(serviceUUID.toString().c_str());
    pClient->disconnect();
    return false;
  }
  Serial.println(" - STI encontrado");


  pRemoteCharacteristic = pRemoteService->getCharacteristic(charUUID);
  if (pRemoteCharacteristic == nullptr) {
    Serial.print("Não foi possível encontrar o endereço do dado, UUID: ");
    Serial.println(charUUID.toString().c_str());
    pClient->disconnect();
    return false;
  }
  Serial.println(" - Dado encontrado");

  // Testa a conexão para verificar se está recebendo dados, lê o dado do STI e guarda na variável cl_rec.
  if (pRemoteCharacteristic->canRead()) {
    cl_rec = pRemoteCharacteristic->readValue();
    Serial.print("Teste - A primeira classe recebida de STI é: ");
    Serial.println(cl_rec.c_str());
  }

  if (pRemoteCharacteristic->canNotify())
    pRemoteCharacteristic->registerForNotify(notifyCallback);

  connected = true; //
  return true;
}
/**
   Rotina para escanear os servidoers BLE disponíveis e encontrar STI.
*/
class MyAdvertisedDeviceCallbacks: public BLEAdvertisedDeviceCallbacks {
    /**
        Rotina chamada para cada servidor BLE escaneado, verifica se o servidor é o STI.
    */
    void onResult(BLEAdvertisedDevice advertisedDevice) {
      Serial.print("Servidores BLE encontrados: ");
      Serial.println(advertisedDevice.toString().c_str());

      // Verificando qual deles é tem o endereço do STI.
      if (advertisedDevice.haveServiceUUID() && advertisedDevice.isAdvertisingService(serviceUUID)) {
        BLEDevice::getScan()->stop();
        myDevice = new BLEAdvertisedDevice(advertisedDevice);
        doConnect = true;
        doScan = true;
      } // STI encontrado.
    }
};

//---------------------------------------------------------------------------------------------------SETUP---------------------------------------------------------------------------------------------------
void setup() {
  //---------------------------------EEPROM---------------------------------
  EEPROM.begin(4); // Inicia a EEPROM com o tamanho de 4 bytes.
  Serial.begin(115200); // Taxa de Baud.

  //---------------------ENCONTRANDO SERVIDOR BLE (STI)---------------------
  pinMode(ONBOARD_LED, OUTPUT); // Define o pino 2 (LED imbutido) como saída.
  Serial.println("Iniciando SRA como um cliente BLE...");
  BLEDevice::init("");

  BLEScan* pBLEScan = BLEDevice::getScan(); // Escaneia as servidores BLE.
  pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks()); // Define o método de busca pelo STI como o descrito na classe MyAdvertisedDeviceCallbacks, da seção CONFIGURANDO BLE.
  pBLEScan->setInterval(1349); // O intervalo entre cada scan realizado pelo cliente.
  pBLEScan->setWindow(449); // A quantidade de tempo que o scan fica ativo, deve ser menor que o intervalo.
  pBLEScan->setActiveScan(true); // Ativa o escaneamento ativo, utiliza mais energia mas encontra os servidores mais rapidamente.
  pBLEScan->start(5, false); // Inicia o escaneamento por 5 s utilizando as rotinas da seção CONFIGURANDO BLE, durante este tempo o escaneamento irá respeitar o intervalo e o tempo de atividade cada scanner.

  //-------------------------------Motor 1--------------------------------
  pinMode(IN1, OUTPUT); // Define o pino conectado à M1- como saída.
  pinMode(IN2, OUTPUT); // Define o pino conectado à M1+ como saída.
  // Inicializa Motor 1 em LOW (desligado).
  digitalWrite(IN1, LOW); // Inicia M1- no nível lógico baixo.
  digitalWrite(IN2, LOW); // Inicia M1+ no nível lógico baixo.
  //-------------------------------Motor 2--------------------------------
  pinMode(IN3, OUTPUT); // Define o pino conectado à M2- como saída.
  pinMode(IN4, OUTPUT); // Define o pino conectado à M2+ como saída.
  // Inicializa Motor 2 em LOW (desligado).
  digitalWrite(IN3, LOW); // Inicia M2- no nível lógico baixo.
  digitalWrite(IN4, LOW); // Inicia M2+ no nível lógico baixo.

  //---------------------------INICIAR ENCODER----------------------------
  delay(5000); // Aguarda 5 s para iniciar resgate da posição atual dos Motores 1 e 2.
  Serial.println("Inicializando");
  EncoderInit(); // Executa as rotinas de leitura e interpretação das mudanças de níveis lógicos do encoder.

  Serial.print("Posição M1: ");
  Serial.println(posicao_enc1);
  Serial.print("Posição M2: ");
  Serial.println(posicao_enc2);
  Serial.print(" ");
}

//---------------------------------------------------------------------------------------------------IRAM---------------------------------------------------------------------------------------------------
//----------------------------------------------ENC 1----------------------------------------------
void IRAM_ATTR calculapos1() // IRAM_ATTR força as interrupções na memória RAM, garantindo uma maior velocidade na contagem dos pulsos dos encoders e também evitando que haja overflow do código, já que a ISR é capaz apenas de realizar curtas instruções sem parâmetros ou retorno de variáveis.
{
  int volatile Enc1_atual = digitalRead(Encoder_Pa1);
  if ((Encoder_Pa1_Last == LOW) && Enc1_atual == HIGH) // Se o estado anterior do Encoder 1 for baixo e o atual alto: o motor realizou uma rotação.
  {
    int volatile val = digitalRead(Encoder_Pb1);
    if (val == LOW && Direcao) // Verifica qual a direção da rotação.
    {
      Direcao = false; // Sentido anti-horário.
    }
    else if (val == HIGH && !Direcao)
    {
      Direcao = true;  // Sentido horário.
    }
  }
  Encoder_Pa1_Last = Enc1_atual;
  if (!Direcao) {
    posicao_enc1++; // Incrementa encoder se M1 estiver rodando no sentido horário.
  }
  else  {
    posicao_enc1--; // Decrementa encoder se M1 estiver rodando no sentido anti-horário.
  }
}

//----------------------------------------------ENC 2----------------------------------------------
void IRAM_ATTR calculapos2()
{
  int Enc2_atual = digitalRead(Encoder_Pb2);
  if ((Encoder_Pb2_Last == LOW) && Enc2_atual == HIGH)
  {
    int val2 = digitalRead(Encoder_Pa2);
    if (val2 == LOW && Direcao2)
    {
      Direcao2 = false; // Sentido anti-horário.
    }
    else if (val2 == HIGH && !Direcao2)
    {
      Direcao2 = true;  // Sentido horário.
    }
  }
  Encoder_Pb2_Last = Enc2_atual;
  if (!Direcao2) {
    posicao_enc2++; // Incrementa encoder se M2 estiver rodando no sentido horário.
  }
  else  {
    posicao_enc2--; // Decrementa encoder se M2 estiver rodando no sentido anti-horário.
  }
}

//---------------------------------------------------------------------------------------------------LOOP---------------------------------------------------------------------------------------------------
void loop() {
  //----------------------------------------INICIANDO CONEXÃO STI-SRA----------------------------------------
  Serial.println("Tentando Conexão...");
  if (doConnect == true) { // doConnect é true quando o scanner encontrou o STI e se conectou.
    if (connectToServer()) {
      Serial.println("Conexão STI-SRA estabelecida");
    } else {
      Serial.println("Não foi possível se conectar com STI, reinicie");
    }
    doConnect = false;
  }

  //------------------------------------------RECEBE CLASSE DE STI-------------------------------------------
  if (connected) {
    String newValue = "Time since boot: " + String(millis() / 1000);
    Serial.println("Setting new characteristic value to \"" + newValue + "\"");
    cl_rec = pRemoteCharacteristic->readValue(); // Lê o valor recebido do STI.
    if (primeira_trans == true) { // Se for a primeira leitura realizada após o início, resgate da posição atual dos Motores, gravado na EEPROM:
      InitCheck1(); // Roda o Motor 1 para MR da posição resgatada de EEPROM, essa posição de M1 é relativa ao momento em que o SRA foi desligado.
      InitCheck2(); // Roda o Motor 2 para MR da posição resgatada de EEPROM, essa posição de M2 é relativa ao momento em que o SRA foi desligado.
      primeira_trans = false;
    }
    Serial.print("A classe recebida é: ");
    Serial.println(cl_rec.c_str());

    Serial.print("Pulso1: ");
    Serial.println(posicao_enc1);
    Serial.print("Pulso2: ");
    Serial.println(posicao_enc2);
    Serial.print(" ");

    //-------------------------------------------------------MÁQUINA DE ESTADOS FINITOS-------------------------------------------------------
    // Sobre a posição (encoder) dos motores:
    // 5000 = Mão em repouso;
    // 26000 = Flexão total da amplitude de movimento dos dedos, i.e, eles se tocam;
    // 18000 = Flexão quase total da amplitude de movimento dos dedos. Os dedos não se tocam, a mão fica em formato de C;
    // Esses valores foram definidos com o usuário de forma empírica.
    // M1 (anti-horário) e M2 (horário) realizam flexão;
    // M1 (horário) e M2 (anti-horário) realizam extensão;
    //------------------------------PP FLEXÃO--------------------------------
    if (cl_an == "MR" & cl_rec == "PP" & estado_atual == "eMR" ) { // Classe anterior MR, Classe recebida PP e Estado atual MR = mão em repouso,
      estado_atual = "ePP";                                        // voluntário fez preensão pinça voluntariamente para prender um objeto.
      Serial.print("Preensão Pinça faz flexão, prendendo o objeto");
      while (posicao_enc1 <= 26000) { // Gira os motores 1 e 2 até alcançarem a posição de PP fechada. Este valor é definido em testes com o usuário.
        //------M1 Anti-Horário (flexão)-------
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, LOW);
        Serial.print("Pulso1: ");
        Serial.println(posicao_enc1);
        writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
      }
      //------M1 trava o eixo-------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
    }
    //-----------------------------PP EXTENSÃO-------------------------------
    else if (cl_an == "MR" & cl_rec == "PP" & estado_atual == "ePP") { // Classe anterior MR, Classe recebida PP e Estado atual PP = preensão pinça segurando objeto,
      estado_atual = "eMR";                                            // voluntário fez preensão pinça voluntariamente para voltar à mão em repouso, os tendões tem a tensão aliviada.
      Serial.print("Preensão Pinça faz extensão, liberando o objeto");
      while (posicao_enc1 > 5000) { // Gira o motor 1 até alcançar a posição de MR. Este valor é definido em testes com o usuário.
        //------M1 Horário (extensão)-------
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, HIGH);
        writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM
        Serial.print("Pulso1: ");
        Serial.println(posicao_enc1);
      }
      //------M1 trava o eixo-------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM
    }
    //-------------------------------PC FLEXÃO---------------------------------
    else if (cl_an == "MR" & cl_rec == "PC" & estado_atual == "eMR") { // Classe anterior MR, Classe recebida PC e Estado atual MR = mão em repouso,
      estado_atual = "ePC";                                            // voluntário fez preensão cilíndrica voluntariamente para prender um objeto.
      Serial.print("Preensão cilíndrica faz flexão, prendendo o objeto");
      while (posicao_enc1 <= 18000) { // Gira o motor 1 e motor 2 até alcançar a posição de PC. Este valor é definido em testes com o usuário. O encoder 1 e 2 são atualizados simultaneamente, por isso só enc1 é utilizado na estrutura while.
        //------M1 Anti-Horário (flexão)-------
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, LOW);
        writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
        //--------M2 Horário (flexão)----------
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
        writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
        Serial.print("Pulso1: ");
        Serial.println(posicao_enc1);
        Serial.print("Pulso2: ");
        Serial.println(posicao_enc2);
      }
      //--------M1 e M2 travam os eixos--------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      digitalWrite(IN3, HIGH);
      digitalWrite(IN4, HIGH);
      writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
      writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.

      while (posicao_enc2 <= 18000) {
        //--------M2 Horário (flexão)---------- // Rotina introduzida apenas para garantir que a posição do enconder 2 esteja na posição de PC.
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
        writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
        Serial.print("Pulso2: ");
        Serial.println(posicao_enc2);
      }
      //--------M1 e M2 travam os eixos--------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      digitalWrite(IN3, HIGH);
      digitalWrite(IN4, HIGH);
      writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.

      while (posicao_enc2 > 18000) {
        //------M2 Anti-Horário (extensão)------- // Ajuste de posição para garantir que a flexão realizada na rotina acima não foi muito brusca.
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        Serial.print("Pulso2: ");
        Serial.println(posicao_enc2);
      }
      //--------M1 e M2 travam os eixos--------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      digitalWrite(IN3, HIGH);
      digitalWrite(IN4, HIGH);
      writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
    }
    //-----------------------------PC EXTENSÃO-------------------------------
    else if (cl_an == "MR" & cl_rec == "PC" & estado_atual == "ePC") { // Classe anterior MR, Classe recebida PC e Estado atual PC = preensão cilíndrica segurando objeto,
      estado_atual = "eMR";                                            // voluntário fez preensão cilíndrica voluntariamente para voltar à mão em repouso, os tendões tem a tensão aliviada.
      Serial.print("Preensão cilíndrica faz extensão, liberando o objeto");
      while (posicao_enc1 > 5000) { // Gira o motor 1 e motor 2 até alcançar a posição de MR. Este valor é definido em testes com o usuário. O encoder 1 e 2 são atualizados simultaneamente, por isso só enc1 é utilizado na estrutura while.
        //--------M1 Horário (extensão)----------
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, HIGH);
        //------M2 Anti-Horário (extensão)-------
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        Serial.print("Pulso1: ");
        Serial.println(posicao_enc1);
        Serial.print("Pulso2: ");
        Serial.println(posicao_enc2);
        delay(150);
        writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
        delay(100);
        writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
      }
      //--------M1 e M2 travam os eixos--------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      digitalWrite(IN3, HIGH);
      digitalWrite(IN4, HIGH);
      writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
      writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.

      while (posicao_enc2 > 5000) {
        //------M2 Anti-Horário (extensão)------- // Rotina introduzida apenas para garantir que a posição do enconder 2 esteja na posição de MR.
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
      }
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      digitalWrite(IN3, HIGH);
      digitalWrite(IN4, HIGH);
      writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.

      while (posicao_enc2 <= 4970) {
        //--------M2 Horário (flexão)---------- // Ajuste de posição para garantir que a exntesão realizada na rotina acima não foi muito brusca.
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
      }
      //--------M1 e M2 travam os eixos--------
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, HIGH);
      digitalWrite(IN3, HIGH);
      digitalWrite(IN4, HIGH);
      writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
    }
  }

  //------------------------------------------RECONEXÃO BLE-----------------------------------------
  else if (doScan) {
    BLEDevice::getScan()->start(0);  // Tenta reconectar após uma desconexão.
  }
  cl_an = cl_rec.c_str(); // Se a reconexão for sucedida, recebe a classe enviada de STI.
}

//-----------------------------------------------------------------------------------------------SUB-ROTINAS------------------------------------------------------------------------------------------------
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void EncoderInit()
{
  pinMode(Encoder_Pb1, INPUT); // Define o pino PB1 como entrada.
  attachInterrupt(Encoder_Pb1, calculapos1, CHANGE); // Verifica se houve troca de nível lógico no pinos PA1 e PB1, se sim, calcula a posição do encoder 1. Isso é realizado como uma interrupção no ESP32.
  pinMode(Encoder_Pa2, INPUT); // Define o pino PA2 como entrada.
  attachInterrupt(Encoder_Pa2, calculapos2, CHANGE); // Verifica se houve troca de nível lógico no pinos PA2 e PB2, se sim, calcula a posição do encoder 2. Isso é realizado como uma interrupção no ESP32.
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void InitCheck1() // Roda o Motor 1 para MR da posição resgatada de EEPROM, essa posição de M1 é relativa ao momento em que o SRA foi desligado.
{
  //---------------------------------ENC 1---------------------------------
  posicao_enc1 = readIntFromEEPROM(0); // Lê a posição do encoder 1 registrada na EEPROM.
  Serial.print("Check M1: ");
  Serial.println(posicao_enc1);
  // Auxílio visual para indicar que o motor 1 irá retornar à posição MR antes de iniciar o SRA.
  digitalWrite(ONBOARD_LED, LOW);
  delay(1000);
  digitalWrite(ONBOARD_LED, HIGH);
  delay(4000);

  while (posicao_enc1 >= 5000) { // Gira o Motor 1 para a posição MR.
    //--------M1 Horário (extensão)----------
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);
    Serial.print("Pos1_Check: ");
    Serial.println(posicao_enc1);
    writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
  }
  if (posicao_enc1 <= 5014 && posicao_enc1 >= 5000) { // Se estiver entre o intervalo 5000 e 5014, é considerado posição MR. O Motor 1 é parado.
    //--------M1 trava o eixo--------
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, HIGH);
    Serial.print("Pos1 Check");
    Serial.println(posicao_enc1);
    writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
  }
  while (posicao_enc1 <= 4990) { // Caso o Motor 1 tenha ultrapassado na extensão o valor de MR, uma flexão leve é realizada para ajuste fino de MR.
    //------M1 Anti-Horário (flexão)-------
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);
    Serial.print("Pos1 Check: ");
    Serial.println(posicao_enc1);
    Serial.print("Salvando...");
  }
  writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
  if (posicao_enc1 >= 4900 && posicao_enc1 <= 5000) { //  Verifica se o ajuste fino foi realizado, e considera o Motor 1 pronto para uso do SRA.
    //--------M1 trava o eixo--------
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, HIGH);
    Serial.print("Pos1 End");
    Serial.println(posicao_enc1);
    writeIntIntoEEPROM(0, posicao_enc1); // Salva a posição do encoder de M1 na EEPROM.
  }
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void InitCheck2() // Roda o Motor 2 para MR da posição resgatada de EEPROM, essa posição de M2 é relativa ao momento em que o SRA foi desligado.
{
  //---------------------------------ENC 2---------------------------------
  posicao_enc2 = readIntFromEEPROM(2);
  Serial.print("Check M2: ");
  Serial.println(posicao_enc2);
  // Auxílio visual para indicar que o motor 2 irá retornar à posição MR antes de iniciar o SRA.
  digitalWrite(ONBOARD_LED, LOW);
  delay(1000);
  digitalWrite(ONBOARD_LED, HIGH);
  delay(1000);
  digitalWrite(ONBOARD_LED, LOW);
  delay(1000);
  digitalWrite(ONBOARD_LED, HIGH);
  delay(3000);

  while (posicao_enc2 >= 5010) { // Gira o Motor 2 para a posição MR.
    //------M2 Anti-Horário (extensão)-------
    digitalWrite(IN3, LOW);
    digitalWrite(IN4, HIGH);
    Serial.print("Pos2 Check: ");
    Serial.println(posicao_enc2);
    writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
  }
  if (posicao_enc2 <= 5014 && posicao_enc2 >= 5000) { // Se estiver entre o intervalo 5000 e 5014, é considerado posição MR. O Motor 2 é parado.
    //--------M2 trava o eixo--------
    digitalWrite(IN3, HIGH);
    digitalWrite(IN4, HIGH);
    Serial.print("Pos2 Check");
    Serial.println(posicao_enc2);
    writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
  }
  while (posicao_enc2 <= 4990) { // Caso o Motor 2 tenha ultrapassado na extensão o valor de MR, uma flexão leve é realizada para ajuste fino de MR.
    //--------M2 Horário (flexão)----------
    digitalWrite(IN3, HIGH);
    digitalWrite(IN4, LOW);
    Serial.print("Pulso2 Check: ");
    Serial.println(posicao_enc2);
  }
  writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
  if (posicao_enc2 >= 4900 && posicao_enc2 <= 5000) { //  Verifica se o ajuste fino foi realizado, e considera o Motor 2 pronto para uso do SRA.
    //--------M2 trava o eixo--------
    digitalWrite(IN3, HIGH);
    digitalWrite(IN4, HIGH);
    Serial.print("Pos2 End");
    Serial.println(posicao_enc2);
    writeIntIntoEEPROM(2, posicao_enc2); // Salva a posição do encoder de M2 na EEPROM.
  }
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void writeIntIntoEEPROM(int address, int number) // Rotina de escrita na memória EEPROM do ESP32.
{
  EEPROM.write(address, number >> 8);
  EEPROM.write(address + 1, number & 0xFF);
  EEPROM.commit();
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int readIntFromEEPROM(int address) // Rotina de leitura na memória EEPROM do ESP32.
{
  return (EEPROM.read(address) << 8) + EEPROM.read(address + 1);
}
