# 5節リンク機構を用いたお絵描きロボット開発

## 目次
1.[1-インストール](#1-インストール)\
2.[2-使用方法](#2-使用方法)\
3.[3-コマンド一覧](#3-コマンド一覧)\
4.[4-ディレクトリ構成](#4-ディレクトリ構成)\
5.[5-システム構成](#5-システム構成)\
6.[6-課題概要](#6-課題概要)

<br>

### 1-インストール
1. リポジトリをクローンします
```
https://github.com/rishibas/Robot_Team_B.git
```

<br>

### 2-使用方法
1. コンパイルを行う
```
arduino-cli compile --fqbn arduino:renesas_uno:minima (.inoファイル)
```

2. ボードに書き込む
```
arduino-cli upload --fqbn arduino:renesas_uno:minima -p (ポート番号) (.inoファイル)
```

<br>

### 3-コマンド一覧
|コマンド|実行する処理|
|:--|:--|
|

<br>

### 4-ディレクトリ構成

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

<br>

### 5-システム構成

#### ハードウェア

- **マイコン**: Arduino Uno R4 Minima

- **アクチュエーター**:
    - SG90 ×2
    - FS90R ×1

- **その他**:
    - 単四乾電池 ×4
    - 乾電池ケース ×1
    - ブレッドボード ×1

<br>

### 6-課題概要

本課題では，A~Eおよび〇，×の文字を描画する「お絵描きロボット」を開発する．\
以下のレベル別タスクを段階的に実装する

- **レベル1**: 〇および×を描画できる
- **レベル2**: ローマ字を1文字描画できる
- **レベル3**: 複数の文字を連続して描画できる (ex: A→C→×→E)
- **レベル4**: シリアル通信により指定された1文字を描画できる
- **レベル5**: シリアル通信により指定された文字列を連続して描画できる (ex: B→C→A→E)
