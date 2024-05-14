<div align="center">

# FPGA-Basics

##### Repository of code snippets and projects from my FPGA class, including VHDL, C#, Arduino, Gumnut Assembly and others. 

![Static Badge](https://img.shields.io/badge/VHDL-%20%23000080?style=for-the-badge&logo=VHDL)
![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white)
![C#](https://img.shields.io/badge/c%23-%23239120.svg?style=for-the-badge&logo=csharp&logoColor=white)
![Arduino](https://img.shields.io/badge/-Arduino-00979D?style=for-the-badge&logo=Arduino&logoColor=white)
![Static Badge](https://img.shields.io/badge/Assembly-gray?style=for-the-badge)
![Unity](https://img.shields.io/badge/unity-%23000000.svg?style=for-the-badge&logo=unity&logoColor=white)
</div>

## Overview
This repository contains a collection of codes developed for the FPGA (Field-Programmable Gate Array) class. The codes are written in various languages including VHDL, C#, Arduino, C++, and Gumnut Assembly.

## Repository Contents
The repository is organized into the following folders:
- `ArduinoAsFTDI`: Contains code to use an Arduino module as an FTDI, enabling its RX and TX ports.
- `BaseExercises`: Contains a series of simple and introductory codes in VHDL.
- `GumnutCounter`: Contains VHDL and Assembly code to program a Gumnut softcore processor that creates a counter going from 0 to 9 and increments the count with a button, displaying the result on a seven-segment display.
- `Testbenches`: Contains testbenches for entities such as MUXes, buttons, and state machines.
- `UARTBinaryASCII`: Uses UART protocol to transmit binary from the FPGA and display ASCII characters in a serial terminal.
- `VGA`: Contains code to draw Finn the Human from Adventure Time on a monitor using VGA.
- `Unity-Node`: Contains codes in C# and Arduino to enable serial communication between a Unity project and a NodeMCU module.

Each folder may contain subfolders that include all the needed files for a specific application.

## Prerequisites
Before using the codes in this repository, ensure you have the following prerequisites:
- [DE10-Lite module](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=1021)
- [FTDI module](https://www.amazon.com/HiLetgo-FT232RL-Converter-Adapter-Breakout/dp/B00IJXZQ7C/ref=sr_1_8?crid=8GBTH7BE9XIG&dib=eyJ2IjoiMSJ9._leohITZkTn4lLg5Q8MOtb-1VaksjOt_KecjEeIGWgc-Oiv4QvARH-rlnJF5NPZXjb-R--HauWrX97mZ0Wf_n-y89S7tIhQuPR8WQezLH7f4kY1kf4HECLQEuo2H0hGhze8hvFQI-iqKRr4bxnob5iqX_c2bgkavRYN98pZ4H0WWEbO9_rVEJlypdVBr8P9EAe-FCQoahkzQP1zIgEKxwDCIQqzDT56sLYwBdueIbFM.yn2TsdrxuZD2T74MOu2fr6WFSsNxi6yqIg1_YFxeXH4&dib_tag=se&keywords=ftdi+usb+to+serial&qid=1714191887&sprefix=ftdi%2Caps%2C101&sr=8-8)
- [Arduino UNO](https://store-usa.arduino.cc/products/arduino-uno-rev3)
- [NodeMCU module](https://en.wikipedia.org/wiki/NodeMCU)
- [Unity](https://unity.com/)
- [Arduino IDE](https://www.arduino.cc/en/software)
- [Quartus Prime](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/quartus-prime.html)

## Usage
1. Clone the repository:

```bash
git clone https://github.com/HumbertoBM2/FPGA-Basics.git
```
2. Navigate to the desired folder depending on the language or type of code you want to use.

3. Compile and run the code according to its extension and usage instructions provided within each file.
