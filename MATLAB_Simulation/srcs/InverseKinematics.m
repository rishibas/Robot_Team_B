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

    %文字スペース
    a1 = [0, 50, 50, 0, 0];
    a2 = [100, 100, 150, 150, 100];
    plot(a1, a2, 'r-', 'LineWidth',1);

    d_13 = sqrt(target_x(i)^2 + (target_y(i))^2);
    d_24 = sqrt((target_x(i) - x2)^2 + (target_y(i))^2);

    theta_1 = acos((d_13^2 + l2^2 - l4^2) / (2*l2*d_13)) + atan2(target_y(i), target_x(i));
    theta_2 = acos((d_24^2 + l3^2 - l5^2) / (2*l3*d_24)) + atan2(target_y(i), target_x(i) - x2);

    x3 = l2*cos(theta_1);
    y3 = l2*sin(theta_1);
    x4 = x2 + l3*cos(theta_2);
    y4 = y2 + l3*sin(theta_2);

    %リンク4とリンク5の関節の二点間の距離
    d_cd = sqrt((x3 - x4)*(x3 - x4) + (y3 - y4)*(y3 - y4));

    %左肘関節の点とリンク3の距離
    d_c_l3 = abs((y2 - y4)*x3 + (x4 - x2)*y3 + (x2*y4 - x4*y2)) / sqrt((y2 - y4)*(y2 - y4) + (x4 - x2)*(x4 - x2));

    %三角形の成立条件
%     d_cd < 0.7
    if d_cd > (l4 + l5) || d_cd < 0.7
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
    y5_local = sqrt(l4*l4 - x5_local*x5_local);
%         fprintf("y5_localのルートの中身: %f\n", l4*l4 - x5_local*x5_local);

    %world座標系へ変換
    a = atan2(real(y4 - y3), real(x4 - x3));
    x5 = x3 + x5_local*cos(a) - y5_local*sin(a);
    y5 = y3 + x5_local*sin(a) + y5_local*cos(a);

    %ペン先の座標を保存
    all_x5(end+1) = x5;
    all_y5(end+1) = y5;

    x_link = [x1, x3, x5, x4, x2, x1];
    y_link = [y1, y3, y5, y4, y2, y1];

    hold on;
    plot(x_link, y_link, 'bo-', 'LineWidth', 2);
%          plot([x3, x4], [y3, y4], 'r--', 'LineWidth', 2);
%     plot(x5, y5, 'o');
    plot(all_x5, all_y5, '.');
    pause(0.05);
    drawnow;
end
