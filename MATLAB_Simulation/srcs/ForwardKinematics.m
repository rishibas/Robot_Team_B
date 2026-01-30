%% 5節リンクの順運動学を計算する
clear;
clc;

SetPara;

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

        %Join5の座標の導出 (リンク3の関節を原点とした場合)
        x5_local = ((d_cd*d_cd) - (l5*l5) + (l4*l4))/(2*d_cd);
        y5_local = sqrt(l4*l4 - x5_local*x5_local);
%         fprintf("y5_localのルートの中身: %f\n", l4*l4 - x5_local*x5_local);

        %ペン先の座標の導出
        x6_local = ((l6 + l4) / l4)*((d_cd*d_cd) - (l5*l5) + (l4*l4))/(2*d_cd);
        y6_local = ((l6 + l4) / l4)*sqrt(l4*l4 - x5_local*x5_local);
        
        %world座標系へ変換
        a = atan2(y4 - y3, x4 - x3);
        x5 = x3 + x5_local*cos(a) - y5_local*sin(a);
        y5 = y3 + x5_local*sin(a) + y5_local*cos(a);

        x6 = x3 + x6_local*cos(a) - y6_local*sin(a);
        y6 = y3 + x6_local*sin(a) + y6_local*cos(a);

        %Joint5の座標を保存
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
%         plot([x3, x4], [y3, y4], 'r--', 'LineWidth', 2);
        plot(whiteboard_edge_x, whiteboard_edge_y, 'g-', 'LineWidth', 2);
        plot(all_x6, all_y6, 'o');
        drawnow;
%         pause(0.05);
    end
end

%お絵描き可能範囲の表示
scatter(all_x6, all_y6, 'ro');
