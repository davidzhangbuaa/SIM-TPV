% !Mode:: "MATLAB:UTF-8"
function [ret] = simulate(method,flag)

    addpath(strcat('#',method));
    [y_0,para] = initial(flag);

    function [dot_y] = odefun(t, y)
            t;
            Y = reshape(y,[],para.n);
            X = reshape(Y( 1: 10,:),1,[]);
            Z = reshape(Y(11:end,:),1,[]);

            [~,~,controller,dot_Z] = consensus(t,X,Z,para);

            dot_X = model(X,controller,para);

            dot_X = reshape(dot_X,[],para.n);
            dot_Z = reshape(dot_Z,[],para.n);
            dot_y = reshape([dot_X;dot_Z],[],1);
    end

     t  = [0 50];

    [t,y] = ode45(@odefun, t, y_0);

    X = zeros(length(t),para.n*para.lx);
    Z = zeros(length(t),para.n*para.lz);
    for j = 1:para.n
        X(:,(j-1)*para.lx+1:j*para.lx) = y(:,(j-1)*para.ly+1:(j-1)*para.ly+para.lx);
        Z(:,(j-1)*para.lz+1:j*para.lz) = y(:,(j-1)*para.ly+para.lx+1:j*para.ly);
    end

    U         = zeros(length(t),para.n*para.lu);
    Formation = zeros(length(t),para.n*para.lf);

    for i = 1:length(t)
        [U(i,:),Formation(i,:),~,~] = consensus(t(i),X(i,:),Z(i,:),para);
    end

    ret = control_post(t,X,U,Z,Formation,para);

    rmpath(strcat('#',method));
end
