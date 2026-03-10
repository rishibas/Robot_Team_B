function [target_x, target_y, edge] = TextCoords(char, offsets)

    switch char
        case '〇'
            % %縦長の楕円をかくプログラム
            N = 20;
            a = 20;
            b = 30;

            theta = linspace(0, 2*pi, N);
            
            xc = 25 + offsets;
            yc = 195;
            r = 25;
            target_x = xc + a*cos(theta);
            target_y = yc + b*sin(theta);
            edge = xc + r;
        
        case '×'
            %左上座標
            x_left_top = 10 + offsets;
            y_left_top = 210;
            
            %左下座標
            x_left_bottom = x_left_top;
            y_left_bottom = y_left_top - 30;

            %右上座標
            x_right_top = x_left_top + 30;
            y_right_top = y_left_top;
            
            %右下座標
            x_right_bottom = x_left_top + 30;
            y_right_bottom = y_left_bottom;
            
            %分割数
            n = 31;
            
            %左上座標から右下座標の線形座標
            target_x0 = linspace(x_left_top, x_right_bottom, n);
            target_y0 = linspace(y_left_top, y_right_bottom, n);
            
            %右上座標から左下座標の線形座標
            target_x1 = linspace(x_right_top, x_left_bottom, n);
            target_y1 = linspace(y_right_top, y_left_bottom, n);
            
            
            target_x = [target_x0, target_x1];
            target_y = [target_y0, target_y1];
            edge = x_right_bottom;

        case 'A'
            %分割数
            n = 31;
            
            %m1の座標
            m1_x = 80 + offsets;
            m1_y = 90;
            
            %m2の座標
            m2_x = m1_x + 15;
            m2_y = m1_y + 30;
            
            %m3の座標
            m3_x = m1_x + 30;
            m3_y = m1_y;
            
            %m4の座標
            m4_x = (m1_x + m2_x) / 2;
            m4_y = (m1_y + m2_y) / 2;
            
            %m5の座標
            m5_x = (m2_x + m3_x) / 2;
            m5_y = (m2_y + m3_y) / 2;
            
            %m1からm2の線分座標
            m1_2_x = linspace(m1_x, m2_x, n);
            m1_2_y = linspace(m1_y, m2_y, n);
            
            %m2からm3の線分座標
            m2_3_x = linspace(m2_x, m3_x, n);
            m2_3_y = linspace(m2_y, m3_y, n);
            
            %m4からm5の線分座標
            m4_5_x = linspace(m4_x, m5_x, n);
            m4_5_y = linspace(m4_y, m5_y, n);
            
            %各座標結合
            target_x = [m1_2_x, m2_3_x, m4_5_x];
            target_y = [m1_2_y, m2_3_y, m4_5_y];
            edge = m3_x;

        case 'B'
            %Bの座標
            %分割数
            n = 31;
            
            %楕円のパラメータ
            a = 15;
            b = 15/2;
            
            %p1の座標
            p1_x = 10 + offsets;
            p1_y = 180;
            
            %p2の座標
            p2_x = p1_x;
            p2_y = p1_y + 30;
            
            %上楕円の中心座標
            cx_1 = p1_x;
            cy_1 = (p2_y + (p1_y + p2_y) / 2) / 2;
            
            %下楕円の中心座標
            cx_2 = p1_x;
            cy_2 = (p1_y + (p1_y + p2_y) / 2) / 2;
            
            theta = linspace(pi/2, -pi/2, n);
            
            p_12_x = linspace(p1_x, p2_x, n);
            p_12_y = linspace(p1_y, p2_y, n);
            
            p_x1 = cx_1 + a*cos(theta);
            p_y1 = cy_1 + b*sin(theta);
            
            p_x2 = cx_2 + a*cos(theta);
            p_y2 = cy_2 + b*sin(theta);
            
            %連結
            target_x = [p_12_x, p_x1, p_x2];
            target_y = [p_12_y, p_y1, p_y2];
            edge = p1_x + a;
        
        case 'C'
            cx = 25 + offsets;
            cy = 195;
            a = 15;
            b = 15;
            n = 60;
            theta = linspace(pi/4, 7*pi/4, n);
            target_x = cx + a*cos(theta);
            target_y = cy + b*sin(theta);
            edge = cx + a*cos(pi/4);
        
        case 'D'                
            n = 50;

            p1_x = 10 + offsets;
            p1_y = 180;

            p2_x = p1_x;
            p2_y = p1_y + 30;

            % 縦線
            p_12_x = linspace(p1_x, p2_x, n);
            p_12_y = linspace(p1_y, p2_y, n);

            % 楕円パラメータ
            cx = p1_x;
            cy = 195;
            a = 15;
            b = 15;

            theta = linspace(pi/2, -pi/2, n);

            p_x = cx + a*cos(theta);
            p_y = cy + b*sin(theta);

            target_x = [p_12_x, p_x];
            target_y = [p_12_y, p_y];
            edge = cx + a;
        
        case 'E'
            n = 31;
            
            %m1の座標
            m1_x = 40 + offsets;
            m1_y = 210;
            
            %m2の座標
            m2_x = m1_x - 30;
            m2_y = m1_y;
            
            %m3の座標
            m3_x = m1_x - 30;
            m3_y = m1_y - 30;
            
            %m4の座標
            m4_x = m1_x;
            m4_y = m3_y;
            
            %m5の座標
            m5_x = (m2_x + m3_x) / 2;
            m5_y = (m2_y + m3_y) / 2;
            
            %m6の座標
            m6_x = (m4_x + m1_x) / 2;
            m6_y = (m4_y + m1_y) / 2;
            
            %m1からm2の線分
            m_12_x = linspace(m1_x, m2_x, n);
            m_12_y = linspace(m1_y, m2_y, n);
            
            %m2からm3の線分
            m_23_x = linspace(m2_x, m3_x, n);
            m_23_y = linspace(m2_y, m3_y, n);
            
            %m3からm4の線分
            m_34_x = linspace(m3_x, m4_x, n);
            m_34_y = linspace(m3_y, m4_y, n);
            
            %m5からm6の線分
            m_56_x = linspace(m5_x, m6_x, n);
            m_56_y = linspace(m5_y, m6_y, n);
            
            %線分結合
            target_x = [m_12_x, m_23_x, m_34_x, m_56_x];
            target_y = [m_12_y, m_23_y, m_34_y, m_56_y];
            edge = m1_x;
    end