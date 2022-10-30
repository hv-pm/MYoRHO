close all
clc
clear

%% IMPORTANDO OS CONJUNTOS DE SMEs
% São extraídas as características 
% [RMS, DASDV] 
% de cada classe, através da função:
%   extcara(coluna_canal,coluna_rótulo,MR,PP,PC); 
% onde,
% No conjunto de SMEs o rótulo de MR é adotado como 0;
% No conjunto de SMEs o rótulo de PP é adotado como 1;
% No conjunto de SMEs o rótulo de PC é adotado como 2.

% Conjunto 1 (CONJ1)
readtable('C:\Users\...\V1_R1.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ1_PP, CONJ1_PC, CONJ1_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 2 (CONJ2)
readtable('C:\Users\...\V1_R3.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ2_PP, CONJ2_PC, CONJ2_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 3 (CONJ3)
readtable('C:\Users\...\V1_R5.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ3_PP, CONJ3_PC, CONJ3_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 4 (CONJ4)
readtable('C:\Users\...\V1_R7.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ4_PP, CONJ4_PC, CONJ4_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 5 (CONJ5)
readtable('C:\Users\...\V1_R9.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ5_PP, CONJ5_PC, CONJ5_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 6 (CONJ6)
readtable('C:\Users\...\V1_R11.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ6_PP, CONJ6_PC, CONJ6_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 7 (CONJ7)
readtable('C:\Users\...\V1_R13.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ7_PP, CONJ7_PC, CONJ7_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 8 (CONJ8)
readtable('C:\Users\...\V1_R15.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ8_PP, CONJ8_PC, CONJ8_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 9 (CONJ9)
readtable('C:\Users\...\V1_R17.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ9_PP, CONJ9_PC, CONJ9_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 10 (CONJ10)
readtable('C:\Users\...\V1_R19.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ10_PP, CONJ10_PC, CONJ10_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 1 para teste (CONJ_1t)
readtable('C:\Users\...\V1_R2.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ1t_PP, CONJ1t_PC, CONJ1t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 2 para teste (CONJ_2t)
readtable('C:\Users\...\V1_R4.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ2t_PP, CONJ2t_PC, CONJ2t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 3 para teste (CONJ_3t)
readtable('C:\Users\...\V1_R6.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ3t_PP, CONJ3t_PC, CONJ3t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 4 para teste (CONJ_4t)
readtable('C:\Users\...\V1_R8.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ4t_PP, CONJ4t_PC, CONJ4t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 5 para teste (CONJ_5t)
readtable('C:\Users\...\V1_R10.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ5t_PP, CONJ5t_PC, CONJ5t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 6 para teste (CONJ_6t)
readtable('C:\Users\...\V1_R12.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ6t_PP, CONJ6t_PC, CONJ6t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 7 para teste (CONJ_7t)
readtable('C:\Users\...\V1_R14.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ7t_PP, CONJ7t_PC, CONJ7t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 8 para teste (CONJ8t)
readtable('C:\Users\...\V1_R16.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ8t_PP, CONJ8t_PC, CONJ8t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 9 para teste (CONJ9t)
readtable('C:\Users\...\V1_R18.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ9t_PP, CONJ9t_PC, CONJ9t_MR] = extcara(canal0,rotulo,1,2,0);

% Conjunto 10 para teste (CONJ10t)
readtable('C:\Users\...\V1_R20.csv');
rotulo=table2array(ans(:,2));
canal0=table2array(ans(:,3));
[canal0] = filtrarEMG(canal0);
[CONJ10t_PP, CONJ10t_PC, CONJ10t_MR] = extcara(canal0,rotulo,1,2,0);

%% REUNINDO AS CARACTERÍSTICAS EXTRAÍDAS DOS 10 CONJUNTOS EM UMA MATRIZ

% Matriz de características da classe PP
PPconj_RMS = [CONJ1_PP(:,1); CONJ2_PP(:,1); CONJ3_PP(:,1); CONJ4_PP(:,1); CONJ5_PP(:,1); CONJ6_PP(:,1); CONJ7_PP(:,1); CONJ8_PP(:,1); CONJ9_PP(:,1); CONJ10_PP(:,1)];
PPconj_DASDV = [CONJ1_PP(:,2); CONJ2_PP(:,2); CONJ3_PP(:,2); CONJ4_PP(:,2); CONJ5_PP(:,2); CONJ6_PP(:,2); CONJ7_PP(:,2); CONJ8_PP(:,2); CONJ9_PP(:,2); CONJ10_PP(:,2)];

PP_matriz = double([PPconj_RMS PPconj_DASDV]);

% Matriz de características da classe PC
PCconj_RMS = [CONJ1_PC(:,1); CONJ2_PC(:,1); CONJ3_PC(:,1); CONJ4_PC(:,1); CONJ5_PC(:,1); CONJ6_PC(:,1); CONJ7_PC(:,1); CONJ8_PC(:,1); CONJ9_PC(:,1); CONJ10_PC(:,1)];
PCconj_DASDV = [CONJ1_PC(:,2); CONJ2_PC(:,2); CONJ3_PC(:,2); CONJ4_PC(:,2); CONJ5_PC(:,2); CONJ6_PC(:,2); CONJ7_PC(:,2); CONJ8_PC(:,2); CONJ9_PC(:,2); CONJ10_PC(:,2)];

PC_matriz = double([PCconj_RMS PCconj_DASDV]);

% Matriz de características da classe MR
MRconj_RMS = [CONJ1_MR(:,1); CONJ2_MR(:,1); CONJ3_MR(:,1); CONJ4_MR(:,1); CONJ5_MR(:,1); CONJ6_MR(:,1); CONJ7_MR(:,1); CONJ8_MR(:,1); CONJ9_MR(:,1); CONJ10_MR(:,1)];
MRconj_DASDV = [CONJ1_MR(:,2); CONJ2_MR(:,2); CONJ3_MR(:,2); CONJ4_MR(:,2); CONJ5_MR(:,2); CONJ6_MR(:,2); CONJ7_MR(:,2); CONJ8_MR(:,2); CONJ9_MR(:,2); CONJ10_MR(:,2)];

MR_matriz = double([MRconj_RMS MRconj_DASDV]);

% Reunindo as matrizes de características no conjunto de aprendizagem (Y)
Y = [PP_matriz;PC_matriz;MR_matriz];

%% MONTANDO A MATRIZ COM OS 10 CONJUNTOS DE TREINO
% Matriz de características da classe PP
PPconjt_RMS = [CONJ1t_PP(:,1); CONJ2t_PP(:,1); CONJ3t_PP(:,1); CONJ4t_PP(:,1); CONJ5t_PP(:,1); CONJ6t_PP(:,1); CONJ7t_PP(:,1); CONJ8t_PP(:,1); CONJ9t_PP(:,1); CONJ10t_PP(:,1)];
PPconjt_DASDV = [CONJ1t_PP(:,2); CONJ2t_PP(:,2); CONJ3t_PP(:,2); CONJ4t_PP(:,2); CONJ5t_PP(:,2); CONJ6t_PP(:,2); CONJ7t_PP(:,2); CONJ8t_PP(:,2); CONJ9t_PP(:,2); CONJ10t_PP(:,2)];

PPt_matriz = double([PPconjt_RMS PPconjt_DASDV]);

% Matriz de características da classe PC
PCconjt_RMS = [CONJ1t_PC(:,1); CONJ2t_PC(:,1); CONJ3t_PC(:,1); CONJ4t_PC(:,1); CONJ5t_PC(:,1); CONJ6t_PC(:,1); CONJ7t_PC(:,1); CONJ8t_PC(:,1); CONJ9t_PC(:,1); CONJ10t_PC(:,1)];
PCconjt_DASDV = [CONJ1t_PC(:,2); CONJ2t_PC(:,2); CONJ3t_PC(:,2); CONJ4t_PC(:,2); CONJ5t_PC(:,2); CONJ6t_PC(:,2); CONJ7t_PC(:,2); CONJ8t_PC(:,2); CONJ9t_PC(:,2); CONJ10t_PC(:,2)];

PCt_matriz = double([PCconjt_RMS PCconjt_DASDV]);

% Matriz de características da classe MR
MRconjt_RMS = [CONJ1t_MR(:,1); CONJ2t_MR(:,1); CONJ3t_MR(:,1); CONJ4t_MR(:,1); CONJ5t_MR(:,1); CONJ6t_MR(:,1); CONJ7t_MR(:,1); CONJ8t_MR(:,1); CONJ9t_MR(:,1); CONJ10t_MR(:,1)];
MRconjt_DASDV = [CONJ1t_MR(:,2); CONJ2t_MR(:,2); CONJ3t_MR(:,2); CONJ4t_MR(:,2); CONJ5t_MR(:,2); CONJ6t_MR(:,2); CONJ7t_MR(:,2); CONJ8t_MR(:,2); CONJ9t_MR(:,2); CONJ10t_MR(:,2)];

MRt_matriz = double([MRconjt_RMS MRconjt_DASDV]);

% Reunindo as matrizes de características no conjunto de teste (Yt)
Yt = [PPt_matriz;PCt_matriz;MRt_matriz];

% Treina o modelo com 10-fold
labtrain = {'1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '2' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0'};
Mdl = fitcdiscr(Y,labtrain);

% Plotando a matriz de confusão
labpredict = predict(Mdl,Yt)';
cc = confusionchart(labtrain,labpredict);
m1 = cc.NormalizedValues(1,1)+cc.NormalizedValues(1,2)+cc.NormalizedValues(1,3);
m2 = cc.NormalizedValues(2,1)+cc.NormalizedValues(2,2)+cc.NormalizedValues(2,3);
m3 = cc.NormalizedValues(3,1)+cc.NormalizedValues(3,2)+cc.NormalizedValues(3,3);
score = ((cc.NormalizedValues(1,1)*100/m1)+(cc.NormalizedValues(2,2)*100/m2)+(cc.NormalizedValues(3,3)*100/m3))/3;

labpredict = predict(Mdl,Yt)';
confusionchart(labtrain,labpredict);

%% Scatter plot de RMS e DASDV
figure
subplot(1,2,1);
hold all
scatter(PPconj_RMS,PPconj_DASDV,'r','d');
scatter(PCconj_RMS,PCconj_DASDV,'g','s');
scatter(MRconj_RMS,MRconj_DASDV,'b');
xlabel('RMS');
ylabel('DASDV');
% legend({'PP','PC','MR'});
grid on;

K = Mdl.Coeffs(1,2).Const;
L = Mdl.Coeffs(1,2).Linear;

f = @(x1,x2) K + L(1)*x1 + L(2)*x2; % Equação da reta limiar que discrimina MR e PP
h = fimplicit(f,[min(Y(:,1)) max(Y(:,1)) min(Y(:,2)) max(Y(:,2))]);
h.Color = 'm';
h.LineWidth = 1;

J = Mdl.Coeffs(2,3).Const; 
O = Mdl.Coeffs(2,3).Linear;

f = @(x1,x2) J + O(1)*x1 + O(2)*x2; % Equação da reta limiar que discrimina PP e PC
h = fimplicit(f,[min(Y(:,1)) max(Y(:,1)) min(Y(:,2)) max(Y(:,2))]);
h.Color = 'k';
h.LineWidth = 1;

%% Scatter plot das classificações erradas
subplot(1,2,2);
hold all
xlabel('RMS');
ylabel('DASDV');
grid on;

% PP classificado como MR
scatter(0.0837096219181313,0.0484509289514538,'r','c');

% PP classificado como PC
scatter(0.162114931522587,0.0867961194639287,'r','s');
scatter(0.198549522218107,0.108630968006218,'r','s');
scatter(0.233349502885902,0.127423779341908,'r','s');
scatter(0.181336316211476,0.0983531411933999,'r','s');

% PC classificado como PP
scatter(0.187509732246175,0.103917013522442,'g','d');
scatter(0.213709802450977,0.120763819597465,'g','d');
scatter(0.145847152709700,0.0800666687914797,'g','d');
scatter(0.166741351774333,0.0916794046040419,'g','d');
scatter(0.187328770003243,0.103333251897246,'g','d');
scatter(0.172266436149892,0.0968663805349089,'g','d');
scatter(0.189011904306877,0.104236609205610,'g','d');
scatter(0.167325798319131,0.0957244659094984,'g','d');

K = Mdl.Coeffs(1,2).Const;
L = Mdl.Coeffs(1,2).Linear;

f = @(x1,x2) K + L(1)*x1 + L(2)*x2; % Equação da reta limiar que discrimina MR e PP
h = fimplicit(f,[min(Y(:,1)) max(Y(:,1)) min(Y(:,2)) max(Y(:,2))]);
h.Color = 'm';
h.LineWidth = 1;

J = Mdl.Coeffs(2,3).Const; 
O = Mdl.Coeffs(2,3).Linear;

f = @(x1,x2) J + O(1)*x1 + O(2)*x2; % Equação da reta limiar que discrimina PP e PC
h = fimplicit(f,[min(Y(:,1)) max(Y(:,1)) min(Y(:,2)) max(Y(:,2))]);
h.Color = 'k';
h.LineWidth = 1;

%% VARIÁVEIS DA EQUAÇÃO DE MAHALANOBIS A SEREM IMPLEMENTADAS NO ESP32

% Matriz de média das classes
m=Mdl.Mu

% Matriz inversa de covariância entre classes
Sinv=inv(Mdl.Sigma)

% Vetores descritivos dos filtros Butterworth 4ª ordem passa-banda
% (passa-alta + passa-baixa) e Notch
fs = 1000; % Frequência de amostragem
fL = 20; % Frequência inferior da banda
fH = 200; % Frequência superior da banda
Q = 100; % Fator de qualidade do fitro notch
H = 1; % Número de harmônicas a serem filtradas

PA=fL*2/fs; 
PB=fH*2/fs;

Wo=60*2/fs;
BW=Wo/Q;

% Vetor descritivo do filtro Butterworth 4ª ordem passa-alta
[Ba,Aa] = butter(4,PA,'high')

% Vetor descritivo do filtro Butterworth 4ª ordem passa-baixa
[Bb,Ab] = butter(4,PB,'low')

% Vetor descritivo do filtro Notch (60 Hz)
[Bn,An] = iirnotch(H*Wo,BW)

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
% uma classe, realizar uma extração de 2 características em cada repetição.
% São 6 repetições para cada uma das 3 classes, assim,
% 6 PP[RMS, DASDV] 
% 6 PC[RMS, DASDV] 
% 6 MR[RMS, DASDV] 
% Cada conjunto de SMEs gera 18 vetores com 2 características.
% Como utilizamos 10 conjuntos para treino:
% o conjunto de aprendizagem é uma matriz de 180 linhas e 2 colunas.

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
F = [RMS(emg(Ti:Tf,1)), DASDV(emg(Ti:Tf,1))]; 
C_PP(r,:)=F; % Guarda o vetor das 2 características na linha r, cada repetição r gera uma linha com 2 colunas.
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

F = [RMS(emg(Ti:Tf,1)), DASDV(emg(Ti:Tf,1))]; 
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

F = [RMS(emg(Ti:Tf,1)), DASDV(emg(Ti:Tf,1))]; 
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
