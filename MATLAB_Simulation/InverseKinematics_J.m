%% 5節リンク機構の順運動学とヤコビ行列
clear; clc; close all;

%パラメータ設定
SetPara;

%% 1. 数式としてのヤコビ行列を事前に定義(ループ外で行うことで計算速度を向上させている)
syms theta1 theta2 real

% 順運動学の数式定義
x3 = l2 * cos(theta1);
y3 = l2 * sin(theta1);
x4 = x2 + l3 * cos(theta2);
y4 = y2 + l3 * sin(theta2);

d_cd = sqrt((x3 - x4)^2 + (y3 - y4)^2);
x5_local = (d_cd^2 - l5^2 + l4^2) / (2 * d_cd);
y5_local = sqrt(l4^2 - x5_local^2);

a = atan2(y4 - y3, x4 - x3);
x5_expr = x3 + x5_local * cos(a) - y5_local * sin(a);
y5_expr = y3 + x5_local * sin(a) + y5_local * cos(a);

%ヤコビ行列の計算 (微分)
J_sym = [diff(x5_expr, theta1), diff(x5_expr, theta2);
         diff(y5_expr, theta1), diff(y5_expr, theta2)];

%高速化のために関数ハンドルへ変換(symsは計算速度が非常に遅い)
%変換したい数式をどの変数を使って関数化するか．
f_x5 = matlabFunction(x5_expr, 'Vars', [theta1, theta2]);
f_y5 = matlabFunction(y5_expr, 'Vars', [theta1, theta2]);
f_J = matlabFunction(J_sym, 'Vars', [theta1, theta2]);

%% 2. 数値計算ループ
theta1_range = deg2rad(linspace(0, 180, 40));
theta2_range = deg2rad(linspace(0, 180, 40));

res_x = [];
res_y = [];
res_det = [];
res_cond = [];

fprintf("----------計算開始----------\n");

for i = 1:length(theta1_range)
    for j = 1:length(theta2_range)

        t1 = theta1_range(i);
        t2 = theta2_range(j);

        %順運動学の数値計算
        try
            px = f_x5(t1, t2);
            py = f_y5(t1, t2);

            %実数解でない場合はスキップ
            if ~isreal(px) || ~isreal(py), continue; end

            %ヤコビ行列の数値取得
            J_num = f_J(px, py);

            %指標の計算
            d_val = det(J_num); %行列式
            c_val = cond(J_num); %条件数

            fprintf('J: %f\n', d_val);
            if abs(d_val)  <  1e-12, fprintf("J: 0\n"); end

            %データの保存
            res_x(end+1) = px;
            res_y(end+1) = py;
            res_det(end+1) = abs(d_val);
            res_cond(end+1) = c_val;
        catch
            continue; end
    end
end

 %% 3.可視化 (行列式0〜1.0e5の範囲を最適化)
figure('Color', 'w','Position', [100, 100, 1200, 500]);

% --- 設定値 ---
det_min = 0;
det_max = 1000; % ユーザー指定の範囲上限

% --- 行列式の分布 ---
subplot(1, 2, 1);

% カラーマップの作成: 0に近いほど赤(Red)、1.0e5に近いほど青(Blue)
my_cmap_nodes = [
    1 0 0;   % 0: 赤 (特異点)
    1 0.5 0; % 2.5e4: オレンジ
    1 1 0;   % 5.0e4: 黄色
    0 1 1;   % 7.5e4: 水色
    0 0 1    % 1.0e5: 青
];
% 256階調に補間
my_cmap = interp1(linspace(0, 1, 5), my_cmap_nodes, linspace(0, 1, 256));

% 表示用のデータをクランプ（範囲外の大きな値を上限値に固定）
% これにより、1.0e5以上の地点も「青」で表示され、範囲内のグラデーションが維持されます
display_det = res_det;
display_det(display_det > det_max) = det_max;

% 散布図の描画
scatter(res_x, res_y, 20, display_det, 'filled');
h_cb1 = colorbar;
ylabel(h_cb1, 'Determinant Value');
colormap(gca, my_cmap);

% カラー軸の範囲を固定
clim([det_min, det_max]); 

title(sprintf('Determinant |det(J)| (Range: 0 to %.1e)', det_max));
xlabel('X [mm]'); ylabel('Y [mm]');
axis equal; grid on;
hold on; 
plot([0, x2], [0, y2], 'ko', 'MarkerSize', 10, 'LineWidth', 2); % モーター位置

% --- 条件数の分布 (参考) ---
subplot(1, 2, 2);
cond_upper_limit = 50;
display_cond = res_cond;
display_cond(display_cond > cond_upper_limit) = cond_upper_limit;

scatter(res_x, res_y, 20, display_cond, 'filled');
h_cb2 = colorbar;
ylabel(h_cb2, 'Condition Number');
colormap(gca, jet); % 条件数は標準のjet

title(sprintf('Condition Number (Clamped at %d)', cond_upper_limit));
xlabel('X [mm]'); ylabel('Y [mm]');
axis equal; grid on;
hold on; 
plot([0, x2], [0, y2], 'ko', 'MarkerSize', 10, 'LineWidth', 2);

fprintf("--- Visualization Completed (Det Range: 0 to %.1e) ---\n", det_max);