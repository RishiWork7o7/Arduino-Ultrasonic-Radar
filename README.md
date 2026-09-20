# 📡 Arduino Ultrasonic Radar System

A real-time ultrasonic radar system built using an **Arduino UNO R4 WiFi**, **HC-SR04 ultrasonic sensor**, and **SG90 servo motor**.

The ultrasonic sensor is mounted on a servo and continuously scans its surroundings while measuring the distance of nearby objects. The Arduino sends the angle and distance data to a laptop, where it will be used to create a live radar-style visualization.

---

<img width="1600" height="1200" alt="WhatsApp Image 2026-09-20 at 15 40 03" src="https://github.com/user-attachments/assets/b73ecc1a-96e9-4b33-b72a-fecc2773e3cf" />




## 🎯 Project Objective

The goal of this project is to learn Arduino and embedded systems through a practical project rather than isolated basic experiments.

The project covers:

- Ultrasonic distance measurement
- Servo motor control
- Breadboard and circuit wiring
- Arduino programming
- Serial communication
- Sensor + actuator integration
- Real-time data processing
- Radar-style visualization on a computer

---

## 🛠️ Hardware Used

- Arduino UNO R4 WiFi
- HC-SR04 Ultrasonic Sensor
- SG90 Micro Servo Motor
- Breadboard
- Jumper Wires
- USB Cable
- Laptop with Arduino IDE

---

## 🔌 Pin Connections

### HC-SR04

| HC-SR04 Pin | Arduino |
|---|---|
| VCC | 5V |
| GND | GND |
| TRIG | D9 |
| ECHO | D10 |

### SG90 Servo

| Servo Wire | Arduino |
|---|---|
| Red (VCC) | 5V |
| Brown (GND) | GND |
| Orange (Signal) | D6 |

The 5V and GND connections are distributed using the breadboard power rails.

---

## ⚙️ How It Works

The HC-SR04 sends an ultrasonic pulse and measures the time taken for the reflected sound wave to return.

Distance is approximately calculated using:

Distance (cm) = Echo Time (µs) / 58

The SG90 servo rotates the ultrasonic sensor through different angles.

At every angle, the Arduino measures the distance and generates data in the format:

  45,27.8
  ↑   ↑
ANGLE DISTANCE (cm)

## 📡 System Flow

              Object
                 ↓
           Ultrasonic Echo
                 ↓
             HC-SR04
                 ↓
          Arduino UNO R4
             ↙       ↘
        SG90 Servo   Distance
             ↓
        Scan Angle
             ↓
        Serial Data
             ↓
            Laptop
             ↓
     Radar Visualization
16,83.7
17,81.4
18,35.6
