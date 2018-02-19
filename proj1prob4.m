%% Part IV: Fractal Dimension
% A fractal dimension is a ratio that correlates how 
%   a pattern changes as the scaling increases or decreases.
%   A fractal dimension of 2 is usually seen as a smooth-surface,
%   while a fractal dimension of 3 is more rigged and jaggered.

% read in the image of fractal
im = imread('fractal2.jpg'); %use the name of the picture
grayim = rgb2gray(im);
[row, col] = size(grayim);

%% Method 1 (Reticular cell counting method)
% count the number of "cells" in an MxM image
%   with LxL grids
n = 0;
l = 1; % L = 1
for i = 1:l:row
  for j = 1:l:col
    if grayim(i,j) ~= 255
      n = n + 1; %counting number of nonwhite spaces
    end
  end
end

% '1/r = M/L' here '1/r' = row/l
D = log(n)/log(row/l);
% D = 1.855798197632252 for c = 0.36 + 0.1*1i in part(ii)

n = 0;
l = 2; % L = 2
for i = 1:l:row
  for j = 1:l:col
    if grayim(i,j) ~= 255
      n = n + 1;
    end
  end
end

D = log(n)/log(row/l);
% D = 1.837265895561122 using L = 2

n = 0;
l = 5; % L = 5
for i = 1:l:row
  for j = 1:l:col
    if grayim(i,j) ~= 255
      n = n + 1;
    end
  end
end

D = log(n)/log(row/l);
% D = 1.803470825290574 using L = 5

%% Method 2 Differential box-counting method
norm_grayim = im2double(grayim);

% for L = 1
% N is simply adding the number '1' row*col times
D = log(row*col)/log(row/l);
% D = 2.000416739543221 

summat = 0;
l = 2;
for i = 1:l:row
  for j = 1:l:col
    smallest = 1;
    largest = 0;
    for x = i:i+4 % this is for the ith row
      if x > row
        break;
      end
      for y = j:j+4 %this is for the jth column
        if y > col
          break;
        end
        if norm_grayim(x,y) < smallest 
          % look for the smallest 
          smallest = norm_grayim(x,y);
        elseif norm_grayim(x,y) > largest
            largest = norm_grayim(x,y);
        end
      end
    end
    summat = summat + l*l*(largest - smallest + 1);
  % sum(norm_grayim(i,:) is 'l-k', and col is the '+1'
  end
end

D = log(summat)/log(row/l);
% D = 2.292079294667360 using L = 2
% D = 2.483673395687672 using L = 3
% D = 2.773045563576989 using L = 5



