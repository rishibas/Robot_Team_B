//キャリブレーション

#include <Servo.h>

Servo motor1;
Servo motor2;

const int motor1Pin = 9;
const int motor2Pin = 10;

void setup() {
    motor1.attach(motor1Pin);
    motor2.attach(motor2Pin);

    // 初期位置 0°
    motor1.write(0);
    motor2.write(0);
    delay(1000);  // 安定待ち

    // 90°へ移動
    motor1.write(90);
    motor2.write(90);
}

void loop() {
    // 永久待機
    while (true) {
        // 何もしない
    }
}

// //ペン上げ下げ確認プログラム．
// #include <Servo.h>

// Servo servoZ;

// const int servoPin = 11;

// void penUp();
// void penDown();

// void setup() {
//     servoZ.attach(servoPin);
//     // 初期状態：停止
// }

// void loop() {
//    penDown();
//    delay(3000);
//    penUp();
//    delay(3000);    
// }

// void penDown() {
//     servoZ.write(89);   // 停止確認
//     delay(1000);

//     servoZ.write(81);    // 上げ方向に回転
//     delay(1000);        // 必要な回転時間

//     servoZ.write(89);   // 停止
// }

// void penUp() {
//     servoZ.write(93);  // 下げ方向に回転
//     delay(1000);        // 必要な回転時間

//     servoZ.write(89);   // 停止
// }