# 5節リンク機構を用いたお絵描きロボット開発

## 目次
1.[1-インストール](#2-インストール)
2.[2-ディレクトリ構成](#2-ディレクトリ構成)
3.[3-]

### 1-インストール

### 2-ディレクトリ構成

```
├── link-robot # 手先延長型5節リンクのお絵描きロボットのディレクトリ
|        ├── include
|        |      └── LinkRobot.hpp #ヘッダーファイル
|        ├── srcs
|        |    ├── InverseKinematics.cpp #逆運動学を解く
|        |    ├── LinkRobot.cpp # メインコントローラ
|        |    ├── moveMotor.cpp # モータ動作
|        |    ├── penControl.cpp # ペン上げ下げ動作
|        |    └── TextCoords.cpp # テキスト座標
|        |
|        └── link-robot.ino # メインのArduinoスケッチ
|
├── MATLAB-Simulation # シミュレーション
|         ├── ForwardKinematics.m # 順運動学を解く
|         ├── InverseKinematics.m # 逆運動学を解く
|         ├── InverseKinematics.m # ヤコビアン
|         ├── SetPara.m # パラメーター設定
|         ├── TextCoords.m # 文字情報
|
└── README.md
```

