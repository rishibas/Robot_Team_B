%% 5節リンクの順運動学を計算する
clear;
clc;

%%各パラメータ
l1 = 60;
l2 = 80;
l3 = 80;
l4 = 100;
l5 = 100;

x1 = 0.0;
y1 = 0.0;
x2 = l1;
y2 = 0.0;

all_x5 = [];
all_y5 = [];

% %%5節リンクの順運動学を解く

theta_1 = deg2rad(linspace(10, 170, 31));
theta_2 = deg2rad(linspace(10, 160, 31)); %max 140°にしたのは適当なので再度調節

figure(1);

for i = 1:length(theta_1)
    for j = 1:length(theta_1)

        cla;
        xlim([-300, 300]);
        ylim([-300, 300]);
        grid on;
        axis equal;

        x3 = l2*cos(theta_1(i));
        y3 = l2*sin(theta_1(i));
        x4 = x2 + l3*cos(theta_2(j));
        y4 = y2 + l3*sin(theta_2(j));

        %リンク4とリンク5の関節の二点間の距離
        d_cd = sqrt((x3 - x4)*(x3 - x4) + (y3 - y4)*(y3 - y4));

        %左肘関節の点とリンク3の距離
        d_c_l3 = abs((y2 - y4)*x3 + (x4 - x2)*y3 + (x2*y4 - x4*y2)) / sqrt((y2 - y4)*(y2 - y4) + (x4 - x2)*(x4 - x2));

        fprintf("theta1: %f, theta2: %f, d_cdの値: %f, d_c_l3の値: %f\n",rad2deg(theta_1(i)), rad2deg(theta_2(j)), d_cd, d_c_l3);
        %三角形の成立条件
        if d_cd > (l4 + l5) || d_cd < 0.7
            fprintf("error: ステップ %d でリンクが届きません(d_cd = %f)\n", i, d_cd);
            continue;
        end

        %リンク間の衝突条件
        if d_cd < 0.7 || d_c_l3 < 2.0
            fprintf("error: リンク同士が衝突します．");
            break;
        end

        %ペン先の座標の導出 (リンク3の関節を原点とした場合)
        x5_local = ((d_cd*d_cd) - (l5*l5) + (l4*l4))/(2*d_cd);
        y5_local = sqrt(l4*l4 - x5_local*x5_local);
%         fprintf("y5_localのルートの中身: %f\n", l4*l4 - x5_local*x5_local);

        %world座標系へ変換
        a = atan2(y4 - y3, x4 - x3);
        x5 = x3 + x5_local*cos(a) - y5_local*sin(a);
        y5 = y3 + x5_local*sin(a) + y5_local*cos(a);

        %ペン先の座標を保存
        all_x5(end+1) = x5;
        all_y5(end+1) = y5;

        x_link = [x1, x3, x5, x4, x2, x1];
        y_link = [y1, y3, y5, y4, y2, y1];

        hold on;
        plot(x_link, y_link, 'bo-', 'LineWidth', 2);
         plot([x3, x4], [y3, y4], 'r--', 'LineWidth', 2);
        plot(x5, y5, 'o');
        plot(all_x5, all_y5, 'o');
        drawnow;
%         pause(0.09);
    end
end

%お絵描き可能範囲の表示
scatter(all_x5, all_y5, 'o');

%円の座標取得
% xlim([-5, 5]);
% ylim([-5, 5]);
grid on;
[pts_x, pts_y] = ginput(2);
r = sqrt((pts_x(2) - pts_x(1))^2 + (pts_y(2) - pts_y(1))^2);
theta_circle = linspace(0, 2*pi, 31);

target_x = pts_x(1) + r*cos(theta_circle);
target_y = pts_y(1) + r*sin(theta_circle);

plot(target_x, target_y, 'r-', 'LineWidth',1);

%逆運動学用パラメータ


theta_1 = [];
theta_2 = [];

%5節リンクの逆運動学を解く
for i = 1:length(target_x)

    cla;
    xlim([-500, 500]);
    ylim([-500, 500]);
    grid on;
%     axis equal;

    d_13 = sqrt(target_x(i)^2 + (target_y(i))^2);
    d_24 = sqrt((target_x(i) - x2)^2 + (target_y(i))^2);

    theta_1 = acos((d_13^2 + l2^2 - l4^2) / (2*l2*d_13)) + atan2(target_y(i), target_x(i));
    theta_2 = acos((d_24^2 + l3^2 - l5^2) / (2*l3*d_24)) + atan2(target_y(i), target_x(i) - x2);

    x3 = l2*cos(theta_1);
    y3 = l2*sin(theta_1);
    x4 = x2 + l3*cos(theta_2);
    y4 = y2 + l3*sin(theta_2);

    fprintf("x4 - x3: %f\n", x4 - x3);
    fprintf("y4 - y3: %f\n", y4 - y3);

    %リンク4とリンク5の関節の二点間の距離
    d_cd = sqrt((x3 - x4)*(x3 - x4) + (y3 - y4)*(y3 - y4));

    %左肘関節の点とリンク3の距離
    d_c_l3 = abs((y2 - y4)*x3 + (x4 - x2)*y3 + (x2*y4 - x4*y2)) / sqrt((y2 - y4)*(y2 - y4) + (x4 - x2)*(x4 - x2));

    %三角形の成立条件
    if d_cd > (l4 + l5) || d_cd < 0.7
        fprintf("error: ステップ %d でリンクが届きません(d_cd = %f)\n", i, d_cd);
        continue;
    end

    %リンク間の衝突条件
    if d_cd < 0.7 || d_c_l3 < 0.5
        fprintf("error: リンク同士が衝突します．");
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
    plot(x5, y5, 'o');
    plot(all_x5, all_y5, 'o');
    pause(0.05);
    drawnow;
end

