function Newton_root(a,p,x1,x2,y1,y2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The parameters to be introduced in the Newton function are the following:
% n: degree of the polynomial
% a: independent term
% x1: initial value of the horizontal axis (real part of z)
% x2: final value of the horizontal axis (real part of z)
% y1: initial value of the vertical axis (imaginary part of z)
% y2: final value of the vertical axis (imaginary part of z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%DATA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min_re =x1;
max_re =x2;
min_im =y1;
max_im =y2;
n_re= 300;
n_im = 300;
tol = 0.031;

format compact;
max_steps = 30;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Stepsize %%%%%%%%%%%%%%%%%%%%%%%%%%%%

delta_re = (max_re-min_re)/n_re; 
delta_im = (max_im-min_im)/n_im;
x = min_re:delta_re:max_re;
y = min_im:delta_im:max_im;
[X,Y] =meshgrid(x,y); 
Z = X + i*Y;

F(1,1)=1;
F(1,p+1)=-a;
R=roots(F);

for j = 1:n_im + 1
    for k = 1:n_re + 1 % one pixel z = (j,k)
        z = Z(j,k);
        if z == 0
            z = tol;
        end
        m = 0;
        flag = 0;
        while (flag == 0)
            % iteration
           z=z-(z^p-a)/(p*z^(p-1)); 
           
            if (abs((a-z^p)/a) <= tol)                 
                % we are next to a zero
                flag = 1;
            end
            if m > max_steps
                flag = 1;
            end
            m = m + 1;
        end
        % assign color according to number of roots
        if (m > max_steps)
           Z1(j,k)=0;
        end
         for ii = 1:p
            if (abs(R(ii)-z) < tol)
              Z1(j,k)=3*ii-1+m/(.8*max_steps);
            end
       end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
axis equal
hold on

colormap(jet(100)); brighten(0.5);
pcolor(X,Y,Z1);shading flat;
xlim([x1 x2])
ylim([y1 y2])

return
