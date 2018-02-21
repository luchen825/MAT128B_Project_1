% same code as part 1, but different function
%WHEN THE ORBIT OF 0 IS BOUNDED THEN THE JULIA
% SET IS CONNECTED
% SO IF THE ORBIT IS BOUNDED, SET OF POINTS WILL
%BE COLORED WITH RED
%c = 0.36 + 0.1i
%phi = inline('z^2 + 0.36 + 0.1*1i'); blue (S form)
% phi = inline('z^2 + 0.36 + 0.1*1i'); turn empty 
%when abs(z)>2
% phi = inline('z^2 - 1.25'); blue (cross form)
phi = @(z)(z^2 - 1.25);
fixpt1 = (1 + sqrt(6))/2;
fixpt2 = (1 - sqrt(6))/2;
% NUMBER 1 IS RED, NUMBER 2 IS WHITE ,
colormap([0 0 1; 1 1 1]); 
%ARRAY OF POINT COLORS TO 2
M = 2*ones(141,361);

for j=1:141
    y = -0.7 + (j-1)*0.01;
        for i=1:361
            x= -1.8 + (i-1)*0.01;z= x + 1i*y;zk = z;
            iflag1 = 0;iflag2 = 0;kount  = 0;
            
            while kount <100 && abs(zk) < 2 && iflag1 < 5 && iflag2 < 5
                kount = kount +1;
                zk = phi(zk);
                
        %TEST FOR CONVERGENCE TO FIX POINT 1 (FIXPT1)        
                err1 = abs(zk-fixpt1);
                if err1 < 1.e-6, iflag1 = iflag1 +1; else, iflag1 =0; end
        %TEST FOR CONVERGENCE TO FIX POINT 2 (FIXPT2)        
                err2 = abs(zk-fixpt2);
                if err2 < 1.e-6, iflag2 = iflag2 + 1; else, iflag2 =0; end
            end
         %IF THE ORBIT IS BOUNDED, IF   
            if iflag1 >=5 || iflag2 >= 5 || kount >=100
                M(j,i) = 1; % if orbit is bounded , it will turn red
                
            end
        end
end
     %CREATING GRAPH FOR THE RESULTS
    image([-1.8 1.8],[-0.7 0.7],M), 
    axis xy