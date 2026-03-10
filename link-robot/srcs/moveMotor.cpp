#include "../include/LinkRobot.hpp"

void LinkRobot::moveMotor(const float &theta1, const float &theta2) {
    float degL = theta1 * (180.0f / (float)M_PI);
    float degR = theta2 * (180.0f / (float)M_PI);
    servoL.write((int)degL);
    servoR.write((int)degR);
    delay(500);
}
