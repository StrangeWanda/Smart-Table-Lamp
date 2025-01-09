# Smart-Table-Lamp
The Smart Adaptive Lamp is an intelligent lighting system designed to automatically adjust its brightness to achieve optimal illumination levels based on user-defined and environmental parameters. The system incorporates hardware and software components to ensure energy efficiency, user convenience, and adaptability.

## Operation Workflow
* User inputs desired brightness or provides parameters for recommended lux calculation.
* NodeMCU processes the input and adjusts the PWM duty cycle accordingly.
* The LED driver modifies the lamp's brightness based on the updated PWM signal.
* The system continuously monitors brightness levels and user activity, making adjustments as necessary.


## Software Design
* Control Algorithm:  A feedback loop monitors the current brightness (lux) and adjusts the PWM signal to reduce the error between the measured and target lux values.
Prevents overshooting by incrementally changing the PWM signal to achieve a smooth transition.
* Web/Mobile Interface:  A user-friendly interface allows manual brightness control. The interface communicates with the NodeMCU over Wi-Fi to update brightness settings in real time.
* Lux Recommendation Model: Calculates the target lux level based on parameters like user age and environmental conditions.
Ensures optimal lighting for comfort and eye health.
* OTA (Over-The-Air) Updates: Enables firmware updates to enhance functionality or fix bugs without requiring physical access to the device.
## Uses
* Personalized reading lamps for home and libraries.
* Adaptive lighting for energy-efficient workspaces.
* Smart lighting solutions for the elderly, tailored to their specific visual needs.
