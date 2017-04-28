% !Mode:: "MATLAB:UTF-8"
function [ret] = control_post(t, X, U, Z, Formation,para)

    ret.n    = para.n;
    ret.DOF  = para.DOF;
    ret.lx   = para.lx;
    ret.lu   = para.lu;
    ret.lz   = para.lz;
    ret.ly   = para.ly;
    ret.lf   = para.lf;
    ret.flag = para.flag;
    ret.L    = para.L;
    ret.str  = para.str;
    ret.t    = t;
    [V,~]    = eig(ret.L.');

    x = zeros(length(ret.t),ret.n);
    y = zeros(length(ret.t),ret.n);
    z = zeros(length(ret.t),ret.n);
    dot_x = zeros(length(ret.t),ret.n);
    dot_y = zeros(length(ret.t),ret.n);
    dot_z = zeros(length(ret.t),ret.n);
    phi   = zeros(length(ret.t),ret.n);
    theta = zeros(length(ret.t),ret.n);
    psi   = zeros(length(ret.t),ret.n);
    m     = zeros(length(ret.t),ret.n);
    thrust = zeros(length(ret.t),ret.n);
    m_esti = zeros(length(ret.t),ret.n);
    mg_esti = zeros(length(ret.t),ret.n);
    u_x   = zeros(length(ret.t),ret.n);
    u_y   = zeros(length(ret.t),ret.n);
    u_z   = zeros(length(ret.t),ret.n);
    Formation_x   = zeros(length(ret.t),ret.n);
    Formation_y   = zeros(length(ret.t),ret.n);
    Formation_z   = zeros(length(ret.t),ret.n);
    Formation_vx   = zeros(length(ret.t),ret.n);
    Formation_vy   = zeros(length(ret.t),ret.n);
    Formation_vz   = zeros(length(ret.t),ret.n);

for i = 1:ret.n

          x(:,i)  = X(:,(i-1)*ret.lx+1);
          y(:,i)  = X(:,(i-1)*ret.lx+2);
          z(:,i)  = X(:,(i-1)*ret.lx+3);
      dot_x(:,i)  = X(:,(i-1)*ret.lx+4);
      dot_y(:,i)  = X(:,(i-1)*ret.lx+5);
      dot_z(:,i)  = X(:,(i-1)*ret.lx+6);
        phi(:,i)  = X(:,(i-1)*ret.lx+7);
      theta(:,i)  = X(:,(i-1)*ret.lx+8);
        psi(:,i)  = X(:,(i-1)*ret.lx+9);
          m(:,i)  = X(:,    i*ret.lx);
     thrust(:,i)  = Z(:,(i-1)*ret.lz+1);
     m_esti(:,i)  = Z(:,(i-1)*ret.lz+5);
    mg_esti(:,i)  = Z(:,(i-1)*ret.lz+6);
        u_x(:,i)  = U(:,(i-1)*ret.lu+1);
        u_y(:,i)  = U(:,(i-1)*ret.lu+2);
        u_z(:,i)  = U(:,(i-1)*ret.lu+3);
        Formation_x(:,i)  = Formation(:,(i-1)*ret.lf + 1);
        Formation_y(:,i)  = Formation(:,(i-1)*ret.lf + 2);
        Formation_z(:,i)  = Formation(:,(i-1)*ret.lf + 3);
        Formation_vx(:,i) = Formation(:,(i-1)*ret.lf + 4);
        Formation_vy(:,i) = Formation(:,(i-1)*ret.lf + 5);
        Formation_vz(:,i) = Formation(:,(i-1)*ret.lf + 6);
end
    V(:,1);
    aver_dot_x = dot_x*V(:,1)/(ones(1,ret.n)*V(:,1));
    aver_dot_y = dot_y*V(:,1)/(ones(1,ret.n)*V(:,1));
    aver_dot_z = dot_z*V(:,1)/(ones(1,ret.n)*V(:,1));
    aver       = [aver_dot_x aver_dot_y aver_dot_z];

    err_x = Formation_x-x;
    err_y = Formation_y-y;
    err_z = Formation_z-z;
    errp = [err_x err_y err_z];
    errf = [err_x*para.L.' err_y*para.L.' err_z*para.L.'];
    Epz = zeros(length(ret.t),1);
    Epf = zeros(length(ret.t),1);
    for i =1 :length(ret.t)
    Epz(i,:) = norm(errp(i,:),'fro');
    Epf(i,:) = norm(errf(i,:),'fro');
    end
    Ep = Epz + Epf;

    ret.x   = x;
    ret.y   = y;
    ret.z   = z;

    ret.Formation_x = Formation_x;
    ret.Formation_y = Formation_y;
    ret.Formation_z = Formation_z;
    ret.Formation_vx = Formation_vx;
    ret.Formation_vy = Formation_vy;
    ret.Formation_vz = Formation_vz;
    ret.Formation = Formation;

    ret.dot_x = dot_x;
    ret.dot_y = dot_y;
    ret.dot_z = dot_z;
    ret.aver  = aver;

    ret.u_x   = u_x;
    ret.u_y   = u_y;
    ret.u_z   = u_z;

    ret.phi   = phi;
    ret.theta = theta;
    ret.psi   = psi;
    ret.a_esti = [m_esti mg_esti];%adaptative para
    ret.Ep = Ep;
end
