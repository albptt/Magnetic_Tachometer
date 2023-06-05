<h1 align="center"> Magnetic Tachometer </h1>

![alt-text](https://github.com/albptt/Magnetic_Tachometer/blob/main/tach_gif.gif)

## Project Goal
The project focuses on the development of a magnetic tachometer from the linear Hall-effect sensor 811JF-55A4.

To achieve this aim, the sensor was used in combination with the following hardware:
- Arduino Micro;
- Powerbank Solar charger 5.5V output, 300-600mA;
- Booster DC-DC Step-up 2/24V to 5/12/28V Micro USB;
- ON/OFF switch;
- LM358AN OpAmp;
- CA9-MT-V10-10K Potentiometer;
- HC-05 Bluetooth module;
- Neodymium Magnet (N35);

## Files
Folders are organized as follows:

- __Arduino Code__ hosts the `.ino` file containing the algorithm for RPM measurements;
- __Calibration__ hosts the MATLAB code used to display the measures performed to characterize the sensor;
- __Case Design__ contains the `.SLDPRT` files for the 3D printed case; 
- __Circuit__ hosts the circuit diagrams made using Fritzing software;
- __Processing Code__ contains the GUI interface made via Processing, implementable both on Laptop and on Android smartphone.


***

__Authors:__

- alberto.pettenella@mail.polimi.it
- letizia.santini@mail.polimi.it
- giorgia.monzio@mail.polimi.it
- lorenzo6.locatelli@mail.polimi.it
- matteo2.mentasti@mail.polimi.it
