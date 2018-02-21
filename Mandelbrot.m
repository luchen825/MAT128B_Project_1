function Mandelbrot(x1,x2,y1,y2) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The parameters to be introduced in the Mandelbrot function are the 
% following:
% x1: first value of the horizontal axis (real part of c)
% x2: final value of the horizontal axis (real part of c)
% y1: first value of the vertical axis (imaginary part of c)
% y2: final value of the vertical axis (imaginary part of c)
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

for j = 1:n_im + 1
    for k = 1:n_re + 1 % one pixel z = (j,k)
        c = Z(j,k);
        z=0;
        m = 0;
        flag = 0;
        while (flag == 0)
            % iteration
           z=z^2+c; %polynomial
           if (abs(z) >1000)                 
                flag = 1;
                Z1(j,k)=m;
            end
            if m > max_steps
                flag = 1;
                Z1(j,k)=1;
            end
            m = m + 1;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%PLOT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
axis equal
hold on

colormap(jet(150)); brighten(0.5);
pcolor(X,Y,Z1);shading flat;
xlim([x1 x2])
ylim([y1 y2])

figure(2);
% subplot(3,3,9); 
axis equal
hold on

colormap(hot);
pcolor(X,Y,Z1);shading flat;
xlim([x1 x2])
ylim([y1 y2])

figure(3)
axis equal
hold on
colormap(prism(10)); brighten(0.5);
pcolor(X,Y,Z1);shading flat;
xlim([x1 x2])
ylim([y1 y2])

clear all
return
