%% 5節リンクの逆運動学を計算する
clear;
clc;

SetPara;


%描く文字の指定
[target_x, target_y] = TextCoords('〇');

%逆運動学用パラメータ

theta_1 = [];
theta_2 = [];

%5節リンクの逆運動学を解く
for i = 1:length(target_x)

    cla;
    xlim([-300, 300]);
    ylim([-300, 300]);
    grid on;
    axis equal;

    d_13 = sqrt(target_x(i)^2 + (target_y(i))^2);
    d_24 = sqrt((target_x(i) - x2)^2 + (target_y(i))^2);

    arg1 = (d_13^2 + l2^2 - (l4 + l6)^2) / (2*l2*d_13);
    theta_1 = acos(arg1) + atan2(target_y(i), target_x(i));

    x3 = l2*cos(theta_1);
    y3 = l2*sin(theta_1);

    %----------------------AI-----------------
    % 1. 左肘(x3,y3)からペン先(tx,ty)までの距離を計算(これは l4 + l6 に等しいはず)
    dist_total = l4 + l6;

    % 2. 方向ベクトル(単位ベクトル)を求める
    % ペン先座標(tx, ty)は target_x(i), target_y(i) です
    unit_vec_x = (target_x(i) - x3) / dist_total;
    unit_vec_y = (target_y(i) - y3) / dist_total;

    % 3. 左肘から l4 だけ進んだ座標を算出
    x5 = x3 + l4 * unit_vec_x;
    y5 = y3 + l4 * unit_vec_y;
    %--------------------------------------------

    %-------------------------------AI------------------
    % 1. 右サーボ(x2, y2)から結合点(x5, y5)までの距離
    d25 = sqrt((x5 - x2)^2 + (y5 - y2)^2);

    % 2. 余弦定理の引数 (数値誤差対策で -1 ～ 1 にクランプ)
    arg2 = (d25^2 + l3^2 - l5^2) / (2 * l3 * d25);
    arg2 = max(-1, min(1, arg2));

    % 3. 右サーボ角 theta_2
    % 結合点への方向角から、三角形の内角を引く
    theta_2 = atan2(y5 - y2, x5 - x2) - acos(arg2);

    % 4. 右肘の座標 (x4, y4)
    x4 = x2 + l3 * cos(theta_2);
    y4 = y2 + l3 * sin(theta_2);
    %-------------------------------------
    fprintf("theta1: %f, theta2: %f\n", rad2deg(theta_1), rad2deg(theta_2));

    %リンク4とリンク5の関節の二点間の距離
    d_cd = sqrt((x3 - x4)*(x3 - x4) + (y3 - y4)*(y3 - y4));

    %左肘関節の点とリンク3の距離
    d_c_l3 = abs((y2 - y4)*x3 + (x4 - x2)*y3 + (x2*y4 - x4*y2)) / sqrt((y2 - y4)*(y2 - y4) + (x4 - x2)*(x4 - x2));

    %三角形の成  立条件
%     d_cd < 0.7
    if d_cd > (l4 + l5)
        fprintf("error: ステップ %d でリンクが届きません(d_cd = %f)\n", i, d_cd);
        continue;
    end

    %リンク間の衝突条件
    
    if d_cd < 0.7 || d_c_l3 < 2.0
        fprintf("error: リンク同士が衝突します.  d_cd: %f, d_c_l3: %f\n", d_cd, d_c_l3);
        continue;
    end

    %ペン先の座標の導出 (リンク3の関節を原点とした場合)
    x5_local = ((d_cd*d_cd) - (l5*l5) + (l4*l4))/(2*d_cd);
    val_to_sqrt = l4*l4 - x5_local*x5_local;

    if val_to_sqrt < 0
        fprintf("sqrtの中身が負です\n");
        continue;
    end
    y5_local = sqrt(val_to_sqrt);
%         fprintf("y5_localのルートの中身: %f\n", l4*l4 - x5_local*x5_local);

    %ペン先の座標の導出
    x6_local = ((l6 + l4) / l4)*x5_local;
    y6_local = ((l6 + l4) / l4)*y5_local;

    %world座標系へ変換
    a = atan2(real(y4 - y3), real(x4 - x3));
    x5 = x3 + x5_local*cos(a) - y5_local*sin(a);
    y5 = y3 + x5_local*sin(a) + y5_local*cos(a);

    x6 = x3 + x6_local*cos(a) - y6_local*sin(a);
    y6 = y3 + x6_local*sin(a) + y6_local*cos(a);

    %ペン先の座標を保存
    all_x5(end+1) = x5;
    all_y5(end+1) = y5;

    %ペン先座標の保存
    all_x6(end+1) = x6;
    all_y6(end+1) = y6;

    x_link1 = [x1, x3, x5, x6];
    y_link1 = [y1, y3, y5, y6];
    x_link2 = [x5, x4, x2, x1];
    y_link2 = [y5, y4, y2, y1];

    whiteboard_edge_x = [x1, x1, x1 + width, x1 + width, x1];
    whiteboard_edge_y = [y1, y1 + height, y1 + height, y1, y1];

    hold on;
    plot(x_link1, y_link1, 'bo-', 'LineWidth', 2);
    plot(x_link2, y_link2, 'bo-', 'LineWidth', 2);
    plot(whiteboard_edge_x, whiteboard_edge_y, 'g-', 'LineWidth', 2);
    plot(all_x6, all_y6, '.');
    pause(0.05);
    drawnow;
end
