% !Mode:: "MATLAB:UTF-8"
function [dot_X]=model(X,controller,para)

    n   = para.n;
    g   = para.g;
    X   = reshape(X,[],para.n);
    controller = reshape(controller,[],para.n);
    thrust  = controller(1,:);
    omega_x = controller(2,:);
    omega_y = controller(3,:);
    omega_z = controller(4,:);
    phi     = X(7,:);
    theta   = X(8,:);
    m       = X(10,:);

    ddot_x    =  -thrust.*sin(theta)./m;
    ddot_y    =   thrust.*sin(phi).*cos(theta)./m;
    ddot_z    =  -thrust.*cos(phi).*cos(theta)./m + g*ones(1,n);
    ddot_X    =  [ddot_x;ddot_y;ddot_z];
    dot_phi   =  omega_x + (omega_z.*cos(phi) + omega_y.*sin(phi)).*tan(theta);
    dot_theta =  omega_y.*cos(phi) - omega_z.*sin(phi);
    dot_psi   =  (omega_z.*cos(phi) + omega_y.*sin(phi))./cos(theta);
    dot_m     =  0;


    dot_X(1:3  ,:) = X(4:6,:);
    dot_X(4:6  ,:) = ddot_X;
    dot_X(7:9  ,:) = [dot_phi;dot_theta;dot_psi];
    dot_X(10   ,:) = dot_m;

    dot_X = reshape(dot_X,1,[]);

end
