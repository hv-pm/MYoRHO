close all
clc
clear

%% IMPORTANDO OS CONJUNTOS DE SMEs
% São extraídas as características 
% [MAV, WL, RMS, MFL, MSR, IAV, DASDV, VAR, WAMP, ZC] 
% de cada classe, através da função:
%   extcara(coluna_canal,coluna_rótulo,MR,PP,PC); 
% onde,
% No conjunto de SMEs o rótulo de MR é adotado como 0;
% No conjunto de SMEs o rótulo de PP é adotado como 1;
% No conjunto de SMEs o rótulo de PC é adotado como 2.

% Conjunto 1 (CONJ1)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R1.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ1_PP, CONJ1_PC, CONJ1_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 2 (CONJ2)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R3.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ2_PP, CONJ2_PC, CONJ2_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 3 (CONJ3)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R5.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ3_PP, CONJ3_PC, CONJ3_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 4 (CONJ4)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R7.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ4_PP, CONJ4_PC, CONJ4_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 5 (CONJ5)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R9.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ5_PP, CONJ5_PC, CONJ5_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 6 (CONJ6)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R11.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ6_PP, CONJ6_PC, CONJ6_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 7 (CONJ7)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R13.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ7_PP, CONJ7_PC, CONJ7_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 8 (CONJ8)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R15.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ8_PP, CONJ8_PC, CONJ8_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 9 (CONJ9)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R17.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ9_PP, CONJ9_PC, CONJ9_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 10 (CONJ10)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R19.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ10_PP, CONJ10_PC, CONJ10_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 1 para teste (CONJ_1t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R2.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ1t_PP, CONJ1t_PC, CONJ1t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 2 para teste (CONJ_2t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R4.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ2t_PP, CONJ2t_PC, CONJ2t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 3 para teste (CONJ_3t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R6.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ3t_PP, CONJ3t_PC, CONJ3t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 4 para teste (CONJ_4t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R8.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ4t_PP, CONJ4t_PC, CONJ4t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 5 para teste (CONJ_5t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R10.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ5t_PP, CONJ5t_PC, CONJ5t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 6 para teste (CONJ_6t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R12.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ6t_PP, CONJ6t_PC, CONJ6t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 7 para teste (CONJ_7t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R14.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ7t_PP, CONJ7t_PC, CONJ7t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 8 para teste (CONJ8t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R16.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ8t_PP, CONJ8t_PC, CONJ8t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 9 para teste (CONJ9t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R18.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ9t_PP, CONJ9t_PC, CONJ9t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 10 para teste (CONJ10t)
readtable('C:\Users\hv-pm\Desktop\db\new\retif\V1_R20.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ10t_PP, CONJ10t_PC, CONJ10t_MR] = extcara(canal0,rotulo,1,2,0);

%% REUNINDO AS CARACTERÍSTICAS EXTRAÍDAS DOS 10 CONJUNTOS DE APRENDIZAGEM EM UMA MATRIZ

% Matriz de características da classe PP
PPconj_MAV = [CONJ1_PP(:,1); CONJ2_PP(:,1); CONJ3_PP(:,1); CONJ4_PP(:,1); CONJ5_PP(:,1); CONJ6_PP(:,1); CONJ7_PP(:,1); CONJ8_PP(:,1); CONJ9_PP(:,1); CONJ10_PP(:,1)];
PPconj_WL = [CONJ1_PP(:,2); CONJ2_PP(:,2); CONJ3_PP(:,2); CONJ4_PP(:,2); CONJ5_PP(:,2); CONJ6_PP(:,2); CONJ7_PP(:,2); CONJ8_PP(:,2); CONJ9_PP(:,2); CONJ10_PP(:,2)]; 
PPconj_RMS = [CONJ1_PP(:,3); CONJ2_PP(:,3); CONJ3_PP(:,3); CONJ4_PP(:,3); CONJ5_PP(:,3); CONJ6_PP(:,3); CONJ7_PP(:,3); CONJ8_PP(:,3); CONJ9_PP(:,3); CONJ10_PP(:,3)]; 
PPconj_MFL = [CONJ1_PP(:,4); CONJ2_PP(:,4); CONJ3_PP(:,4); CONJ4_PP(:,4); CONJ5_PP(:,4); CONJ6_PP(:,4); CONJ7_PP(:,4); CONJ8_PP(:,4); CONJ9_PP(:,4); CONJ10_PP(:,4)]; 
PPconj_MSR = [CONJ1_PP(:,5); CONJ2_PP(:,5); CONJ3_PP(:,5); CONJ4_PP(:,5); CONJ5_PP(:,5); CONJ6_PP(:,5); CONJ7_PP(:,5); CONJ8_PP(:,5); CONJ9_PP(:,5); CONJ10_PP(:,5)]; 
PPconj_IAV = [CONJ1_PP(:,6); CONJ2_PP(:,6); CONJ3_PP(:,6); CONJ4_PP(:,6); CONJ5_PP(:,6); CONJ6_PP(:,6); CONJ7_PP(:,6); CONJ8_PP(:,6); CONJ9_PP(:,6); CONJ10_PP(:,6)]; 
PPconj_DASDV = [CONJ1_PP(:,7); CONJ2_PP(:,7); CONJ3_PP(:,7); CONJ4_PP(:,7); CONJ5_PP(:,7); CONJ6_PP(:,7); CONJ7_PP(:,7); CONJ8_PP(:,7); CONJ9_PP(:,7); CONJ10_PP(:,7)]; 
PPconj_VAR = [CONJ1_PP(:,8); CONJ2_PP(:,8); CONJ3_PP(:,8); CONJ4_PP(:,8); CONJ5_PP(:,8); CONJ6_PP(:,8); CONJ7_PP(:,8); CONJ8_PP(:,8);CONJ9_PP(:,8); CONJ10_PP(:,8)]; 
PPconj_WAMP = [CONJ1_PP(:,9); CONJ2_PP(:,9); CONJ3_PP(:,9); CONJ4_PP(:,9); CONJ5_PP(:,9); CONJ6_PP(:,9); CONJ7_PP(:,9); CONJ8_PP(:,9); CONJ9_PP(:,9); CONJ10_PP(:,9)]; 
PPconj_ZC = [CONJ1_PP(:,10); CONJ2_PP(:,10); CONJ3_PP(:,10); CONJ4_PP(:,10); CONJ5_PP(:,10); CONJ6_PP(:,10); CONJ7_PP(:,10); CONJ8_PP(:,10); CONJ9_PP(:,10); CONJ10_PP(:,10)]; 

PP_matriz = double([PPconj_MAV PPconj_WL PPconj_RMS PPconj_MFL PPconj_MSR PPconj_IAV PPconj_DASDV PPconj_VAR PPconj_WAMP PPconj_ZC]);

% Matriz de características da classe PC
PCconj_MAV = [CONJ1_PC(:,1); CONJ2_PC(:,1); CONJ3_PC(:,1); CONJ4_PC(:,1); CONJ5_PC(:,1); CONJ6_PC(:,1); CONJ7_PC(:,1); CONJ8_PC(:,1); CONJ9_PC(:,1); CONJ10_PC(:,1)];
PCconj_WL = [CONJ1_PC(:,2); CONJ2_PC(:,2); CONJ3_PC(:,2); CONJ4_PC(:,2); CONJ5_PC(:,2); CONJ6_PC(:,2); CONJ7_PC(:,2); CONJ8_PC(:,2); CONJ9_PC(:,2); CONJ10_PC(:,2)]; 
PCconj_RMS = [CONJ1_PC(:,3); CONJ2_PC(:,3); CONJ3_PC(:,3); CONJ4_PC(:,3); CONJ5_PC(:,3); CONJ6_PC(:,3); CONJ7_PC(:,3); CONJ8_PC(:,3); CONJ9_PC(:,3); CONJ10_PC(:,3)]; 
PCconj_MFL = [CONJ1_PC(:,4); CONJ2_PC(:,4); CONJ3_PC(:,4); CONJ4_PC(:,4); CONJ5_PC(:,4); CONJ6_PC(:,4); CONJ7_PC(:,4); CONJ8_PC(:,4); CONJ9_PC(:,4); CONJ10_PC(:,4)]; 
PCconj_MSR = [CONJ1_PC(:,5); CONJ2_PC(:,5); CONJ3_PC(:,5); CONJ4_PC(:,5); CONJ5_PC(:,5); CONJ6_PC(:,5); CONJ7_PC(:,5); CONJ8_PC(:,5); CONJ9_PC(:,5); CONJ10_PC(:,5)]; 
PCconj_IAV = [CONJ1_PC(:,6); CONJ2_PC(:,6); CONJ3_PC(:,6); CONJ4_PC(:,6); CONJ5_PC(:,6); CONJ6_PC(:,6); CONJ7_PC(:,6); CONJ8_PC(:,6); CONJ9_PC(:,6); CONJ10_PC(:,6)]; 
PCconj_DASDV = [CONJ1_PC(:,7); CONJ2_PC(:,7); CONJ3_PC(:,7); CONJ4_PC(:,7); CONJ5_PC(:,7); CONJ6_PC(:,7); CONJ7_PC(:,7); CONJ8_PC(:,7); CONJ9_PC(:,7); CONJ10_PC(:,7)]; 
PCconj_VAR = [CONJ1_PC(:,8); CONJ2_PC(:,8); CONJ3_PC(:,8); CONJ4_PC(:,8); CONJ5_PC(:,8); CONJ6_PC(:,8); CONJ7_PC(:,8); CONJ8_PC(:,8);CONJ9_PC(:,8); CONJ10_PC(:,8)]; 
PCconj_WAMP = [CONJ1_PC(:,9); CONJ2_PC(:,9); CONJ3_PC(:,9); CONJ4_PC(:,9); CONJ5_PC(:,9); CONJ6_PC(:,9); CONJ7_PC(:,9); CONJ8_PC(:,9); CONJ9_PC(:,9); CONJ10_PC(:,9)]; 
PCconj_ZC = [CONJ1_PC(:,10); CONJ2_PC(:,10); CONJ3_PC(:,10); CONJ4_PC(:,10); CONJ5_PC(:,10); CONJ6_PC(:,10); CONJ7_PC(:,10); CONJ8_PC(:,10); CONJ9_PC(:,10); CONJ10_PC(:,10)]; 

PC_matriz = double([PCconj_MAV PCconj_WL PCconj_RMS PCconj_MFL PCconj_MSR PCconj_IAV PCconj_DASDV PCconj_VAR PCconj_WAMP PCconj_ZC]);

% Matriz de características da classe MR
MRconj_MAV = [CONJ1_MR(:,1); CONJ2_MR(:,1); CONJ3_MR(:,1); CONJ4_MR(:,1); CONJ5_MR(:,1); CONJ6_MR(:,1); CONJ7_MR(:,1); CONJ8_MR(:,1); CONJ9_MR(:,1); CONJ10_MR(:,1)];
MRconj_WL = [CONJ1_MR(:,2); CONJ2_MR(:,2); CONJ3_MR(:,2); CONJ4_MR(:,2); CONJ5_MR(:,2); CONJ6_MR(:,2); CONJ7_MR(:,2); CONJ8_MR(:,2); CONJ9_MR(:,2); CONJ10_MR(:,2)]; 
MRconj_RMS = [CONJ1_MR(:,3); CONJ2_MR(:,3); CONJ3_MR(:,3); CONJ4_MR(:,3); CONJ5_MR(:,3); CONJ6_MR(:,3); CONJ7_MR(:,3); CONJ8_MR(:,3); CONJ9_MR(:,3); CONJ10_MR(:,3)]; 
MRconj_MFL = [CONJ1_MR(:,4); CONJ2_MR(:,4); CONJ3_MR(:,4); CONJ4_MR(:,4); CONJ5_MR(:,4); CONJ6_MR(:,4); CONJ7_MR(:,4); CONJ8_MR(:,4); CONJ9_MR(:,4); CONJ10_MR(:,4)]; 
MRconj_MSR = [CONJ1_MR(:,5); CONJ2_MR(:,5); CONJ3_MR(:,5); CONJ4_MR(:,5); CONJ5_MR(:,5); CONJ6_MR(:,5); CONJ7_MR(:,5); CONJ8_MR(:,5); CONJ9_MR(:,5); CONJ10_MR(:,5)]; 
MRconj_IAV = [CONJ1_MR(:,6); CONJ2_MR(:,6); CONJ3_MR(:,6); CONJ4_MR(:,6); CONJ5_MR(:,6); CONJ6_MR(:,6); CONJ7_MR(:,6); CONJ8_MR(:,6); CONJ9_MR(:,6); CONJ10_MR(:,6)]; 
MRconj_DASDV = [CONJ1_MR(:,7); CONJ2_MR(:,7); CONJ3_MR(:,7); CONJ4_MR(:,7); CONJ5_MR(:,7); CONJ6_MR(:,7); CONJ7_MR(:,7); CONJ8_MR(:,7); CONJ9_MR(:,7); CONJ10_MR(:,7)]; 
MRconj_VAR = [CONJ1_MR(:,8); CONJ2_MR(:,8); CONJ3_MR(:,8); CONJ4_MR(:,8); CONJ5_MR(:,8); CONJ6_MR(:,8); CONJ7_MR(:,8); CONJ8_MR(:,8);CONJ9_MR(:,8); CONJ10_MR(:,8)]; 
MRconj_WAMP = [CONJ1_MR(:,9); CONJ2_MR(:,9); CONJ3_MR(:,9); CONJ4_MR(:,9); CONJ5_MR(:,9); CONJ6_MR(:,9); CONJ7_MR(:,9); CONJ8_MR(:,9); CONJ9_MR(:,9); CONJ10_MR(:,9)]; 
MRconj_ZC = [CONJ1_MR(:,10); CONJ2_MR(:,10); CONJ3_MR(:,10); CONJ4_MR(:,10); CONJ5_MR(:,10); CONJ6_MR(:,10); CONJ7_MR(:,10); CONJ8_MR(:,10); CONJ9_MR(:,10); CONJ10_MR(:,10)];  

MR_matriz = double([MRconj_MAV MRconj_WL MRconj_RMS MRconj_MFL MRconj_MSR MRconj_IAV MRconj_DASDV MRconj_VAR MRconj_WAMP MRconj_ZC]);

% Reunindo as matrizes de características no conjunto de aprendizagem (Y)
Y = [PP_matriz;PC_matriz;MR_matriz];

% O conjunto de aprendizagem é utilizado no código "SFS_DB.py" para a seleção 
%sequencial de características progressiva (sequential feature selection: forward)

%% FUNÇÕES
% Função do filtro
function [ CH_S ] = filtrarEMG(sinal,opt)
% Filtro padrão para EMG
% Seleciona banda de frequência e filtra ruídos da rede
%   
%   ------  Parâmetros  ------
%
%   -> sinal: vetor de dados
%   -> opt.fs: frequência de amostragem
%   -> opt.fL: frequência inferior da banda
%   -> opt.fH: frequência superior da banda
%   -> opt.Q: fator de qualidade do fitro notch (rejeita faixa 60 Hz)
%   -> opt.H: número de harmônicas a serem filtradas (se apenas 60 Hz, H=1)

fs = 1000;
fL = 20;
fH = 200;
Q = 100;
H = 1;

PA=fL*2/fs; 
PB=fH*2/fs;

Wo=60*2/fs;
BW=Wo/Q;

CH_S=sinal;
 
%Definição dos parâmetros das funções dos filtros, ver a documentação da 
%função de cada filtro:
%help butter
%help iirnotch

 [Ba,Aa] = butter(4,PA,'high');  %Filtro Butterworth de 4ª ordem passa-alta
 CH_S=filter(Ba,Aa,CH_S); %Aplica o filtro
 
 
 [Bb,Ab] = butter(4,PB,'low');  %Filtro Butterworth de 4ª ordem passa-baixa
 CH_S=filter(Bb,Ab,CH_S); %Aplica o filtro

% Filtro "Notch" rejeita-faixa em 60 Hz;
% Pode aplicar nas harmônicas (H), ou seja, múltiplos de 60 Hz
% exemplo: se H = 3, aplica filtro em 60, 120 e 180 Hz

 for i = 1:H
     [Bn,An] = iirnotch(H*Wo,BW); 
     CH_S=filter(Bn,An,CH_S); %Aplica o filtro
 end

 
%  if opt.TK == true
%      CH_S = TKEO(CH_S);
%  end
 
end

% Função para extração de características dos conjuntos SMEs,
% atualmente extrai três poses de mão: MR (mão em repouso), PP (preensão
% pinça) e PC (preensão cilíndrica).
function [CARAC_PP,CARAC_PC,CARAC_MR] = extcara(signal,label,PP,PC,MR)
%% NORMALIZAÇÃO
a = length(signal); % Tamanho do vetor que contém os SMEs.
normalization = signal(150:a,1); % Retira as primeiras 150 amostras para cortar interferências.
[M,I] = max(normalization); % Encontra a contração voluntária máxima (CVM).
emg = signal./M; % Normaliza o sinal ao dividir cada amostra pela CVM.
stimulus=label;
%% EXTRAINDO AS CARACTERÍSTICAS
% Essa parte da função irá separar as amostras relacionadas à repetição de
% uma classe, realizar uma extração de 10 características em cada repetição.
% São 6 repetições para cada uma das 3 classes, assim,
% 6 PP[MAV, WL, RMS, MFL, MSR, IAV, DASDV, VAR, WAMP, ZC] 
% 6 PC[MAV, WL, RMS, MFL, MSR, IAV, DASDV, VAR, WAMP, ZC] 
% 6 MR[MAV, WL, RMS, MFL, MSR, IAV, DASDV, VAR, WAMP, ZC] 
% Cada conjunto de SMEs gera 18 vetores com 10 características.
% Como utilizamos 4 conjuntos para treino:
% o conjunto de aprendizagem é uma matriz de 72 linhas e 10 colunas.

%% Separando as amostras da repetição (r) da classe PP
r = 1; % Número da repetição
k = 1; % Índice do rótulo
S = 0; % Contador auxiliar para alinhar o índice k na comparação com PP+1.
while S < PP+1 % Enquanto os dados SMEs forem rotulados como 1, i.e., PP.
while stimulus(k) < PP  % Enquanto os dados SMEs forem rotulados como 0, i.e., MR.
k=k+1; % Acrescenta um no índice para verificar na próxima iteração se ainda estamos trabalhando com SMEs da classe MR.
end
% k foi incrementado até que a condição acima não fosse satisfeita, i.e., o rótulo para os SMEs é 1, então eles pertencem à classe PP.
Ti = k; % Começo do segmento com os SMEs da repetição PP

while stimulus(k) > 0 % Enquanto o rótulo for igual à 1 (k>0), pula o índice, porque os SMEs ainda são da classe PP
k=k+1;
S = stimulus(k-1); % Garante que na próxima iteração, o rótulo correto seja comparado com PP+1
end

Tf = k-1; % Final do segmento com os SMEs da repetição PP
% Portanto, obtemos o índice k onde começam os SMEs da repetição r de PP, e
% também o índice k onde a repetição r acaba. Ou seja, conhecemos o início
% e o fim dos SMEs de uma repetição da classe PP, e podemos extrair as
% características dele.

% Extração das características para a repetição r atual 
F = [MAV(emg(Ti:Tf,1)),WL(emg(Ti:Tf,1)),RMS(emg(Ti:Tf,1)),MFL(emg(Ti:Tf,1)),MSR(emg(Ti:Tf,1)),IAV(emg(Ti:Tf,1)),DASDV(emg(Ti:Tf,1)),VAR(emg(Ti:Tf,1)),WAMP(0.01,emg(Ti:Tf,1)),ZC(0.01,emg(Ti:Tf,1))];
C_PP(r,:)=F;% Guarda o vetor das 2 características na linha r, cada repetição r gera uma linha com 2 colunas.
r=r+1; % Fim da extração da repetição, acrescenta 1 no contador para a próxima repetição.
end

CARAC_PP = C_PP(1:6,:); % Monta a matriz final com 6 linhas de 2 colunas.
% Apenas os comentários relevantes serão adicionados nas rotinas para as
% outras classes.
%% Separando as amostras da repetição (r) da classe PC
r = 1;
k = 1;
S = 0;
while S < PC+1

while stimulus(k) < PC 
k=k+1;
end

Ti = k; 

while stimulus(k) > 0
k=k+1;
S = stimulus(k-1);
end

Tf = k-1;

F = [MAV(emg(Ti:Tf,1)),WL(emg(Ti:Tf,1)),RMS(emg(Ti:Tf,1)),MFL(emg(Ti:Tf,1)),MSR(emg(Ti:Tf,1)),IAV(emg(Ti:Tf,1)),DASDV(emg(Ti:Tf,1)),VAR(emg(Ti:Tf,1)),WAMP(0.01,emg(Ti:Tf,1)),ZC(0.01,emg(Ti:Tf,1))];
C_PC(r,:)=F;
r=r+1;
if r>6
    S=3;
end
end

CARAC_PC = C_PC(1:6,:);

%% Separando as amostras da repetição (r) da classe MR
r = 1; 
k = 1; 
while stimulus(k) < 1 
    k=k+1; 
end

while r <7 % Enquanto as caracterítidas de todas as repetições de MR não foram extraída

while stimulus(k) > MR % Enquanto o rótulo for maior que 0 (MR), pula o índice, porque os SMEs são da classe MR
k=k+1;
end

Ti = k; 

while stimulus(k) < MR+1 
k=k+1;
end

Tf = k-1; 

F = [MAV(emg(Ti:Tf,1)),WL(emg(Ti:Tf,1)),RMS(emg(Ti:Tf,1)),MFL(emg(Ti:Tf,1)),MSR(emg(Ti:Tf,1)),IAV(emg(Ti:Tf,1)),DASDV(emg(Ti:Tf,1)),VAR(emg(Ti:Tf,1)),WAMP(0.01,emg(Ti:Tf,1)),ZC(0.01,emg(Ti:Tf,1))];
C_MR(r,:)=F; 
r=r+1; 
end

CARAC_MR = C_MR(1:6,:); 

end 

% Funções das características
function [ dasdv ] = DASDV(sample)
% DASDV


N=length(sample);
somaD=0;
for k=1:N-1
    
  somaD = somaD + (sample(k+1)-sample(k))^2 ;
        
end
        dasdv = sqrt(somaD/(N-1));
        
end

function [ iav ] = IAV(sample)
% MAV(sample)
% Esse atributo é utilizado para medir o valor absoluto médio.
% sample: É o vetor da amostra. 

N=length(sample);
iav=0;
for k=1:N
    
   iav = iav + abs(sample(k)); 
        
end
        
        
end

function [ mav ] = MAV(sample)
% MAV(sample)
% Esse atributo é utilizado para medir o valor absoluto médio.
% sample: É o vetor da amostra. 

N=length(sample);
mav=0;
for k=1:N
    
   mav = mav + abs(sample(k))/N; 
        
end
        
        
end

function [mfl] = MFL(x)
%maximum fractal length 

N = length(x);
soma = 0;

for i = 1:N-1
    soma = soma + (x(i+1)-x(i))^2;
end

mfl = log10(sqrt(soma));


end

function [msr] = MSR(x)
%Mean value of the Square Root

N = length(x);
soma = 0;

for i = 1:N
    soma = soma + sqrt(abs(x(i)));
    
end
msr = soma/N;

end

function [ rms ] = RMS(sample)
% RMS(sample)
% Esse atributo é utilizado para medir o valor RMS do sinal.
% sample: É o vetor da amostra.

N=length(sample);
rms=0;
ssum=0;

for k=1:N
   
    ssum = ssum + sample(k)^2;
    
        if k==N
          
        rms=sqrt(ssum/N);    
            
        end
        
        
end
end

function [ var ] = VAR(sample)
% RMS(sample)
% Esse atributo é utilizado para medir o valor RMS do sinal.
% sample: É o vetor da amostra.

N=length(sample);

sum=0;

for k=1:N
   
    sum = sum + sample(k)^2;
   
        
end
          
        var=sum/(N-1);    
           

end

function [ wamp ] = WAMP(wamp_th,sample)
% WAMP(wamp_th,sample)
% Esse atributo é utilizado para medir a amplitude Willison.
% Está relacionado com a mudança brusca de valores.
% wamp_th: É o critério de amplitude.
% sample: É o vetor da amostra.

N=length(sample)-1;
wamp=0;

for k=2:N
    
   if abs(sample(k)-sample(k-1)) > wamp_th
    
         wamp = wamp + 1;
    end
        
        
end
end

function [ wl ] = WL(sample)
% WL(sample)
% author: Daniel P Campos - UTFPR
% Esse atributo é utilizado para medir o comprimento da curva:
% sample: É o vetor da amostra. 

N=length(sample)-1;
wl=0;


for k=2:N
    
  wl = wl + abs(sample(k)-sample(k-1)) ;
        
end
        
        
end

function [ zc ] = ZC(amp_th,sample)
% ZC(amp_th,sample)
% Esse atributo é utilizado para detectar a passagem por zero:
% amp_th: É o critério para discrminar o ruído.
% sample: É o vetor da amostra. 
N=length(sample)-1;
zc=0;

for k=2:N
    
     Di=sample(k-1)-sample(k);
     Fi=sample(k-1)*sample(k);
     S=-sign(Fi);
     
     if (Di > amp_th) && (S>0)
         
         zc = zc + 1;
     
     end
        
end
        
        
end
