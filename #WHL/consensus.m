% !Mode:: "MATLAB:UTF-8"
function [U,Formation,controller,dot_Z]=consensus(t,X,Z,para)

    n    = para.n;
    L    = para.L;
    flag = para.flag;
    X    = reshape(X,[],para.n);
    Z    = reshape(Z,[],para.n);
    %%
    if flag == 0
            w   = 0.5;
            H   = [cos(w*t)     cos(w*t + 2*pi/3)    cos(w*t + 4*pi/3);
                   sin(w*t)     sin(w*t + 2*pi/3)    sin(w*t + 4*pi/3);
                   1            1                    1               ;
                  -w*sin(w*t)  -w*sin(w*t + 2*pi/3) -w*sin(w*t + 4*pi/3);
                   w*cos(w*t)   w*cos(w*t + 2*pi/3)  w*cos(w*t + 4*pi/3);
                   0            0                    0                 ];
          dot_H_v = w*w*[H(1:2,:);
                         0 0 0];
          ddot_H_v = w*w*w*[H(1:2,:);
                         0 0 0];
            K11 = -2;  K12 = -2;  K21 = 0.4; K22 = 0.6;%r+jm=-1+j
    elseif flag == 1
            H   = [0.05*t       0.05*t+0.6             0.05*t+0.2;
                   0.05*t+0.001*t*t  0.05*t+0.001*t*t+0.2    0.05*t+0.001*t*t+0.6;
                   1            1                    1;
                   0.05         0.05                 0.05;
                   0.05+0.002*t         0.05+0.002*t                 0.05+0.002*t;
                   0            0                    0];
            dot_H_v = [0 0 0;
                0.002 0.002 0.002;
                0 0 0];
            ddot_H_v = [0 0 0;
                0 0 0;
                0 0 0];
            K11 = -2;  K12 = -2;  K21 = 0.4; K22 = 0.6;%r+jm=-1+j
    elseif flag == 2
        H = [0 0 0 0 0 0 0;
             0 0 0 0 0 0 0;
             0 0 0 0 0 0 0;
             0 0 0 0 0 0 0;
             0 0 0 0 0 0 0;
             0 0 0 0 0 0 0];
        dot_H_v = [0 0 0 0 0 0 0;
            0 0 0 0 0 0 0;
            0 0 0 0 0 0 0];
        ddot_H_v = [0 0 0 0 0 0 0;
            0 0 0 0 0 0 0;
            0 0 0 0 0 0 0];
%            K11 = -4;  K12 = -5;  K21 = 0.077; K22 = 0.0154;%r+jm=-2+j
%            K11 = -2;  K12 = -2;  K21 = 0.1174; K22 = 0.2122;%r+jm=-1+j (theorital)
           K11 = -2;  K12 = -2;  K21 = 0.1;    K22 = 0.1;%r+jm=-1+j
    end

    Formation = H;
    %%
    alpha = 10;
    g = para.g;

    Lambda = 10*diag(ones(1,3));
    Tao    = diag([0.001 0.1]);
    phi    = X(7,:);
    theta  = X(8,:);
    m      = X(10,:);

    thrust = Z(1,:);
    inte_s = Z(2:4,:);
%     a_esti = Z(5:6,:);



    ddot_x    =  -thrust.*sin(theta)./m;
    ddot_y    =  thrust.*sin(phi).*cos(theta)./m;
    ddot_z    =  -thrust.*cos(phi).*cos(theta)./m + g*ones(1,n);
    ddot_X    =  [ddot_x;ddot_y;ddot_z];
    dot_a_esti = zeros(2,n);

%%
%formation algorithm
    K1  = [K11*diag(ones(1,3)) K12*diag(ones(1,3))];
    K2  = [K21*diag(ones(1,3)) K22*diag(ones(1,3))];
    s         = - K1*(X(1:6,:) - H) + K2*(X(1:6,:)-H)*L.' + dot_H_v + ddot_X;
    ddot_X_r  =  K1*(X(1:6,:) - H) - K2*(X(1:6,:)-H)*L.'  - dot_H_v - Lambda * inte_s;
    dddot_X_r =  K1*([X(4:6,:);ddot_X] - [H(4:6,:);dot_H_v]) - K2*([X(4:6,:);ddot_X] - [H(4:6,:);dot_H_v])*L.' - ddot_H_v  - Lambda * s;
%%
if flag ==2
%consensus algorithm
    b = 0.9;
    k = 0.5;%the velo of convengence
    s         = ddot_X + b*X(4:6,:)*L.' + k*X(1:3,:)*L.';
    ddot_X_r  = - b*X(4:6,:)*L.' - k*X(1:3,:)*L.' - Lambda * inte_s;
    dddot_X_r = - b*ddot_X*L.' - k*X(4:6,:)*L.' - Lambda * s;
end
 %%
    xi        = ddot_X -  ddot_X_r;
    for i = 1:n
        d  = dddot_X_r(:,i)+alpha*ddot_X_r(:,i);
        d1 = [d -alpha*[0 0 1].'];
        dot_a_esti(:,i) = -Tao*d1.'*xi(:,i);
    end

    U = -(dddot_X_r+alpha*ddot_X_r).*[Z(5,:);Z(5,:);Z(5,:)] + alpha*[0 0 1].'*Z(6,:);

    dot_thrust = U(3,:) - alpha*thrust;
    omega_x    = -U(2,:)./thrust;
    omega_y    = U(1,:)./thrust;
    omega_z    = zeros(1,n);
    controller = [thrust;omega_x;omega_y;omega_z];

    dot_Z = [dot_thrust;s;dot_a_esti];

    U     = reshape(    U,1,[]);
    dot_Z = reshape(dot_Z,1,[]);
    controller = reshape(controller,1,[]);
    Formation = reshape(Formation,1,[]);
end
