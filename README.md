# MYoRHO (Myoelectric Robotic Hand Orthosis)
MYoRHO is a Non-invasive Muscle-Machine Interface Open Source Project: Wearable Robotic Hand Orthosis. It has a user-tuned approach to develop a custom robotic hand orthosis for a user by having their metrics (ergonomics and surface myoelectric signals) added in the design cycle.

The project is currently being developed in collaboration with the Laboratory of Neural Engineering and Rehabilitation (<a href="https://sites.google.com/view/leneruel/projetos/proj-b">LENER</a>) at the State University of Londrina.

### Ergonomics
The finger splints is composed of two elements: the (i) ring and the (ii) base.<br>
(i) The ring dimensions are based on the dimensions of the user, this component is responsible for the comfortable fitting of the splint in the finger.
(ii) the base lenght is decided together with the user and it hinders the range of motion, altogether, it defines the curvature of the grasp.<br>
A chamfer connects both elements and allows for the splint to undergo the necessary pressure applied by the grasp without breaking.

The wrist splint is a remixed version of a <a href="https://www.thingiverse.com/thing:706654">public available orthosis</a> for download. This splint size is also modified to fit the user comfortably.

### Surface myoelectric signals (sMES)
The system allows for the developer to train more than the 3 hand poses proposed in this version, although, It should be noted that the current motors disposition only allows 2 hand poses to be reproduced. Thus, system is designed to identify 2 hand poses plus a resting hand state.

An acquisition protocol is estabilished according to the desired number of hand poses, for this prototype, the protocol is designed to acquire the sMES regarding the (i) pulp pinch, (ii) transverse volar grip and a (iii) resting hand pose. By the end of the protocol a sMES dataset is created.<br>
<img height="200" width="600" src="https://raw.githubusercontent.com/hv-pm/MYoRHO/main/docs/img/protocol.svg"></img><br>

A sequential forward selection (SFS) is performed with a 10-fold cross-validation method to choose the feature subset used to train the linear discriminant analysis (LDA) classifier of the control system. This subset is chosen based on the best trade-off between the computational power required for processing and accuracy. Twenty datasets are recorded from the user, ten datasets (e.g., even numbered) are reserved to train the LDA classifier, while the other ten datasets (e.g., odd numbered) are used to test the LDA accuracy.

## sMES acquisition platform
<img height="400" width="750" src="https://raw.githubusercontent.com/hv-pm/MYoRHO/main/docs/img/Acquisition_platform_assembly.svg"></img><br>
`mSD: microSD module`; `ESP32: DEVKIT V1`; `MyoWare: wearable surface electromyograph`.

This acquisition platform stores real-time recording (datasets) of sMES on a micro SD card. ESP32 was chosen due to its 12-bit analog-to-digital converter (ADC) resolution and compact dimensions. However, given ESP32's problem of non-linearity in ADC readings a <a href="https://github.com/e-tinkers/esp32-adc-calibrate">lookup table calibration</a> is mandatory before recording the datasets. Additionally, a 100 nF ceramic decoupling capacitor is added to attenuate characteristic noises of the ESP32's ADC readings.

The programming interface used for the acquisition platform was the Arduino IDE (v.1.8.1). The code was adapted from the datalogger <a href="https://github.com/greiman/SdFat">example</a> of the SdFat v2.0.6 library, and the chosen baud rate for the serial was 115200 bits/s. Finally, the data were recorded with a sampling rate of 1 kHz.

The sMES signals for each chosen upper limb muscle of the user are analyzed while the user is requested to perform a maximum voluntary contraction (MVC) of a pulp pinch. The muscle with the most significant amplitude is used to record the datasets and activate the system thereafter.

## Transmitter-interpreter system (TIS)
<img height="650" width="400" src="https://raw.githubusercontent.com/hv-pm/MYoRHO/main/docs/img/TIS_flowchart.svg"></img><br>
The TIS module initializes and makes the BLE connection to the RAS module. sMES windows are captured in real-time from MyoWare and converted to millivolts. Next, there is a fourth-order Butterworth (20 to 500 Hz) and notch (60 Hz) digital filtering of the sMES window in which the feature subset is extracted. A linear discriminant analysis (LDA) classifier discriminates the feature subset by comparing the shortest Mahalanobis distance between the feature subset and the center of each class cluster. The closest class to this feature subset (i.e., an unknown sample to the classifier) is chosen and stored in an array of classes. If three classes are added to the array of classes a majority vote (MV) is applied, if not, the class is added to the array, and one more real-time window is filtered, extracted and discriminated. The MV checks which of the three classes stored in the vector occurred with the most frequency and transmits it via BLE to the receiver-actuator system (RAS) module, where its finite state machine will control the orthosis actuators.

## Receiver-actuator system (RAS)
<img height="600" width="550" src="https://raw.githubusercontent.com/hv-pm/MYoRHO/main/docs/img/RAS_flowchart.svg"></img><br>
Auxiliary to the LDA classifier at TIS, a finite-state machine was implemented at RAS to limit the movements that could be performed while the system was in specific states, reducing system failures. It has three main variables: `current state` keeps track of which grip is being performed at the moment; `received class` holds the current class received from TIS; `previously received` saves the value of `received class` before a new transmission overwrites it. As stated earlier, TIS can transmit three different classes: pinch grip (PG), cylindrical grip (CG), and resting hand (RH).

RAS initializes and establishes the BLE connection with TIS. The motors rotate the tendons until the fingers position when shutting down (saved in ESP32's EEPROM) reaches the resting hand (RH) position, and the `current state` becomes RH. This prompted behavior is necessary to ensure that system will always start at the RH pose. Also, if an unusual malfunction in the finite-state machine occurs, causing the motors' position to behave differently from the programmed in the finite-state machine, simply turning off and turning on the device will correct the motors' positions.

When TIS transmits a new class, RAS checks in the variable `current state` which hand pose is being reproduced and decides which pose will be performed based on the analysis of `current state`, `received class` and `previously received`. Any grip (PG or CG) can only be performed if `current state` is RH. Similarly, a grip can only be released if `previously received` is RH and `received class` is its respective grip.

For instance, the motors will only perform PG if `current state` is RH (i.e., the user’s hand is at rest) and the received class is PG. Under these conditions, the motors perform the pinch grip, and `current state` changes to PG. In other words, the user was relaxed and voluntarily performed a pinch grip to activate the orthosis. However, the orthosis will only release the pinch grip when three conditions are met: `current state` is PG, `previously received` is RH, and `received class` is PG. That is, the orthosis is performing a pinch grip, but the muscle is relaxed. Then, the user voluntarily performs another pinch grip to activate the orthosis' release and make the motors rotate to relieve the tension of the tendons.

## Current relase assembly
### TIS module
<img height="500" width="450" src="https://raw.githubusercontent.com/hv-pm/MYoRHO/main/docs/img/TIS_assembly.svg"></img><br>
`Bat: battery`; `TP4056: USB recharge module for the battery`; `SD: on/off sliding switch`; `Step-up: 3 V to 5 V`; `ESP32: DEVKIT V1`; `D. Cap. 100nf: decoupling capacitor`; `MyoWare: wearable surface electromyograph`.

### RAS module
<img height="700" width="750" src="https://raw.githubusercontent.com/hv-pm/MYoRHO/main/docs/img/RAS_assembly.svg"></img><br>
`DRV8833: dual h-bridge driver`; `Motors 1 & 2: N20 DC gearbox - 100 RPM rated 6 V`; `ESP32: DEVKIT V1`; `Motors 1 & 2: N20 DC gearbox - 100 RPM rated 6 V`.

## License
<div>
  <div>
    <span>3D files licensed under</span><br>
    <a href="https://creativecommons.org/licenses/by-sa/4.0/legalcode" title="CC-BY-SA-4.0"><img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by-sa.svg"></img></a>
  </div>
  <div>
    <span>Codes licensed under</span><br>
    <a href="https://www.gnu.org/licenses/gpl-3.0.pt-br.html" title="GNU GPLv3"><img src="https://www.gnu.org/graphics/gplv3-with-text-84x42.png"></img></a>
  </div>
</div>
