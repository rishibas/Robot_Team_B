% %---------------------------------------
% %円の中心座標と半径
% 
% N = 100;
% theta = linspace(0, 2*pi, N);
% 
% xc = 25;
% yc = 125;
% r = 25;
% 
% target_x = xc + r*cos(theta);
% target_y = yc + r*sin(theta);
% %---------------------------------------
% 
% %---------------------------------------
% %×(ばつ)の座標
% 
% %左上座標
% x_left_top = 0;
% y_left_top = 150;
% 
% %左下座標
% x_left_bottom = 0;
% y_left_bottom = 100;
% 
% %右上座標
% x_right_top = 50;
% y_right_top = 150;
% 
% %右下座標
% x_right_bottom = 50;
% y_right_bottom = 100;
% 
% %分割数
% n = 31;
% 
% %左上座標から右下座標の線形座標
% target_x0 = linspace(x_left_top, x_right_bottom, n);
% target_y0 = linspace(y_left_top, y_right_bottom, n);
% 
% %右上座標から左下座標の線形座標
% target_x1 = linspace(x_right_top, x_left_bottom, n);
% target_y1 = linspace(y_right_top, y_left_bottom, n);
% 
% 
% target_x = [target_x0, target_x1];
% target_y = [target_y0, target_y1];
% %---------------------------------------
% 
% 

% %---------------------------------------
% %Aの座標

% %分割数
% n = 31;
% 
% %m1の座標
% m1_x = 0;
% m1_y = 100;
% 
% %m2の座標
% m2_x = 25;
% m2_y = 150;
% 
% %m3の座標
% m3_x = 50;
% m3_y = 100;
% 
% %m4の座標
% m4_x = (m1_x + m2_x) / 2;
% m4_y = (m1_y + m2_y) / 2;
% 
% %m5の座標
% m5_x = (m2_x + m3_x) / 2;
% m5_y = (m2_y + m3_y) / 2;
% 
% %m1からm2の線分座標
% m1_2_x = linspace(m1_x, m2_x, n);
% m1_2_y = linspace(m1_y, m2_y, n);
% 
% %m2からm3の線分座標
% m2_3_x = linspace(m2_x, m3_x, n);
% n2_3_y = linspace(m2_y, m3_y, n);
% 
% %m4からm5の線分座標
% m4_5_x = linspace(m4_x, m5_x, n);
% m4_5_y = linspace(m4_y, m5_y, n);
% 
% %各座標結合
% target_x = [m1_2_x, m2_3_x, m4_5_x];
% target_y = [m1_2_y, m2_3_y, m4_5_y];
% %---------------------------------------

% %---------------------------------------
% %Eの座標
% n = 31;
% 
% %m1の座標
% m1_x = 50;
% m1_y = 100;
% 
% %m2の座標
% m2_x = 0;
% m2_y = 100;
% 
% %m3の座標
% m3_x = 0;
% m3_y = 150;
% 
% %m4の座標
% m4_x = 50;
% m4_y = 150;
% 
% %m5の座標
% m5_x = (m2_x + m3_x) / 2;
% m5_y = (m2_y + m3_y) / 2;
% 
% %m6の座標
% m6_x = (m4_x + m1_x) / 2;
% m6_y = (m4_y + m1_y) / 2;
% 
% %m1からm2の線分
% m_12_x = linspace(m1_x, m2_x, n);
% m_12_y = linspace(m1_y, m2_y, n);
% 
% %m2からm3の線分
% m_23_x = linspace(m2_x, m3_x, n);
% m_23_y = linspace(m2_y, m3_y, n);
% 
% %m3からm4の線分
% m_34_x = linspace(m3_x, m4_x, n);
% m_34_y = linspace(m3_y, m4_y, n);
% 
% %m5からm6の線分
% m_56_x = linspace(m5_x, m6_x, n);
% m_56_y = linspace(m5_y, m6_y, n);
% 
% %線分結合
% target_x = [m_12_x, m_23_x, m_34_x, m_56_x];
% target_y = [m_12_y, m_23_y, m_34_y, m_56_y];
%---------------------------------------

%---------------------------------------
%Cの座標
% 
% % 基本設定
% r = 25;
% p_x = 25; 
% p_y = 125;
% n = 20; % 分割数
% 
% % 各点の相対座標から角度を直接計算 (atan2が最も安全です)
% % atan2(yの差分, xの差分)
% theta_p1 = atan2(137.5 - p_y, 50 - p_x);
% theta_p2 = pi/2;    % (25, 150) -> 真上
% theta_p3 = pi;      % (0, 125)   -> 真左
% theta_p4 = 3*pi/2;  % (25, 100)  -> 真下
% theta_p5 = atan2(112.5 - p_y, 50 - p_x); % 負の角度、または 2*piに近い値が返ります
% 
% % 軌道の生成 (linspaceで滑らかにつなぐ)
% t12 = linspace(theta_p1, theta_p2, n);
% t23 = linspace(theta_p2, theta_p3, n);
% t34 = linspace(theta_p3, theta_p4, n);
% % p4からp5へ。theta_p5がマイナスで返る場合があるため、連続性に注意
% t45 = linspace(theta_p4, 2*pi + theta_p5, n); 
% 
% % 角度の結合
% all_thetas = [t12, t23, t34, t45];
% 
% % 座標変換
% target_x = p_x + r * cos(all_thetas);
% target_y = p_y + r * sin(all_thetas);
%---------------------------------------

%---------------------------------------
%Dの座標

% %分割数
% n = 31;
% 
% %楕円のパラメータ
% a = 50;
% b = 25;
% 
% %p1の座標
% p1_x = 0;
% p1_y = 100;
% 
% %p2の座標
% p2_x = 0;
% p2_y = 150;
% 
% 
% %中心座標
% cx = p1_x;
% cy = (p1_y + p2_y) / 2;
% 
% theta = linspace(pi/2, -pi/2, n);
% 
% p_12_x = linspace(p1_x, p2_x, n);
% p_12_y = linspace(p1_y, p2_y, n);
% 
% p_x = cx + a*cos(theta);
% p_y = cy + b*sin(theta);
% 
% %連結
% target_x = [p_12_x, p_x];
% target_y = [p_12_y, p_y];
%---------------------------------------

%---------------------------------------
% %Bの座標
% %分割数
% n = 31;
% 
% %楕円のパラメータ
% a = 50;
% b = 25/2;
% 
% %p1の座標
% p1_x = 0;
% p1_y = 100;
% 
% %p2の座標
% p2_x = 0;
% p2_y = 150;
% 
% %上楕円の中心座標
% cx_1 = p1_x;
% cy_1 = (p2_y + (p1_y + p2_y) / 2) / 2;
% 
% %下楕円の中心座標
% cx_2 = p1_x;
% cy_2 = (p1_y + (p1_y + p2_y) / 2) / 2;
% 
% theta = linspace(pi/2, -pi/2, n);
% 
% p_12_x = linspace(p1_x, p2_x, n);
% p_12_y = linspace(p1_y, p2_y, n);
% 
% p_x1 = cx_1 + a*cos(theta);
% p_y1 = cy_1 + b*sin(theta);
% 
% p_x2 = cx_2 + a*cos(theta);
% p_y2 = cy_2 + b*sin(theta);
% 
% %連結
% target_x = [p_12_x, p_x1, p_x2];
% target_y = [p_12_y, p_y1, p_y2];
% %---------------------------------------