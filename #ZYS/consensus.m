function [U,Formation,controller,dot_Z]=consensus(t,X,Z,para)

    n    = para.n;
    L    = - para.L;
    flag = para.flag;
    X    = reshape(X,[],para.n);
    %%
    if flag == 0
            w   = 0.5;
            H   = [cos(w*t)     cos(w*t + 2*pi/3)    cos(w*t + 4*pi/3);
                   sin(w*t)     sin(w*t + 2*pi/3)    sin(w*t + 4*pi/3);
                   1            1                    1               ;
                  -w*sin(w*t)  -w*sin(w*t + 2*pi/3) -w*sin(w*t + 4*pi/3);
                   w*cos(w*t)   w*cos(w*t + 2*pi/3)  w*cos(w*t + 4*pi/3);
                   0            0                    0                 ];  
        dot_H_v = w*w*[H(1:2,:);0 0 0];
            K11 = -2;  K12 = -2;  K21 = 0.4; K22 = 0.6;%r+jm=-1+j
%             K11 = -0;  K12 = -0;  K21 = 0.667; K22 = 1.154;
%             K11 = -2;  K12 = -2;  K21 = 0.1574; K22 = 0.2262;%the theoritical coefficient   
    elseif flag == 1
            H   = [0.05*t       0.05*t+0.6             0.05*t+0.2;
                   0.05*t+0.001*t*t  0.05*t+0.001*t*t+0.2    0.05*t+0.001*t*t+0.6;
                   1            1                    1;
                   0.05          0.05                 0.05;
                   0.05+0.002*t  0.05+0.002*t  0.05+0.002*t;
                   0             0                    0];
        dot_H_v = [    0     0     0;
                   0.002 0.002 0.002;
                       0     0     0];
            
            K11 = -2;  K12 = -2;  K21 = 0.4; K22 = 0.6;%r+jm=-1+j
%             K11 = -2;  K12 = -2;  K21 = 0.1574; K22 = 0.2262;
%             K11 = -0;  K12 = -0;  K21 = 0.667; K22 = 1.154;

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
%         K11 = -4;  K12 = -5;  K21 = 0.077; K22 = 0.0154;%r+jm=-2+j
%         K11 = -2;  K12 = -2;  K21 = 0.1174; K22 = 0.2122;%r+jm=-1+j (theorital)
%         K11 = -2;  K12 = -2;  K21 = 0.1;    K22 = 0.1;%r+jm=-1+j
%         K11 = 0;   K12 = 0;   K21  =0.6254; K22 = 1.0832; %(theorital)
        K11 = 0;   K12 = 0;   K21  = 0.2; K22 = 0.9;
%           K11 = 0;   K12 = 0;   K21  = 0.5; K22 = 0.9;
    end
    Formation = H;
    %%   

    g = para.g; 
    
    K1  = [K11*diag(ones(1,3)) K12*diag(ones(1,3))];
    K2  = [K21*diag(ones(1,3)) K22*diag(ones(1,3))];
    U   = zeros(3,para.n);
%%    
%    for i = 1:n    
%        U(:,i) = K1*(X(1:6,i) - H(:,i)) + K2*(X(1:6,:)-H(:,1:n))*L(i,:).' - dot_H_v(:,i);
%    end
    U = K1*(X(1:6,:) - H) + K2*(X(1:6,:)-H)*L.' - dot_H_v;
    
    if flag ==2
    U = K2*X(1:6,:)*L.';
    end
%%  
    U1     = diag([1 -1 -1])*U + g*[zeros(2,n);ones(1,n)];%%%%%%zuo biao xi zhuan huan shi fen zhong yao
    phi    = X(7,:);
    theta  = X(8,:);
    m      = X(10,:);
    
    kp      = 3;%>2
    thrust = m.*sqrt(dot(U1,U1));
    phi_d   =   -atan(U1(2,:)./U1(3,:));
    theta_d =   -atan(U1(1,:)./U1(3,:));
    dot_phi   = kp * (phi_d   - phi);
    dot_theta = kp * (theta_d - theta);
    dot_psi   = zeros(1,n);
  
    omega_x    =  dot_phi - dot_psi.*sin(theta);
    omega_y    =  dot_theta.*cos(phi) + dot_psi.*cos(theta).*sin(phi);
    omega_z    = -dot_theta.*sin(phi) + dot_psi.*cos(theta).*cos(phi);
    controller = [thrust;omega_x;omega_y;omega_z];
    
    dot_Z =zeros(6,para.n);
    
    U          = reshape(    U,1,[]);
    controller = reshape(controller,1,[]);
    Formation  = reshape(Formation,1,[]);
    dot_Z      = reshape(dot_Z,1,[]);
end
