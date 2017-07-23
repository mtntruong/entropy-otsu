% Copyright (C) 2017, Mai Thanh Nhat Truong, All rights reserved.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License version 3,
% as published by the Free Software Foundation.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% An implementation of
% J. L. Fan and B. Lei. A modified valley-emphasis method for automatic thresholding.
% Pattern Recognition Letters, 33(6):703-708, 2012.

function output = neighbor_valley_emphasis(I, N)
% Input:
%   I : 8-bit gray scale image
%   N : the number of neighbor is 2N + 1
% Output:
%   output : optimal threshold value,
%            binary image can be obtained by using `im2bw(I, output/255)`

    [COUNTS,X] = imhist(I);

    % Total number of pixels
    total = size(I,1)*size(I,2);

    sumVal = 0;
    for t = 1 : 256
        sumVal = sumVal + ((t-1) * COUNTS(t)/total);
    end

    varMax = 0;
    threshold = 0;

    omega_1 = 0;
    omega_2 = 0;
    mu_1 = 0;
    mu_2 = 0;
    mu_k = 0;

    for t = 1 : 256
        omega_1 = omega_1 + COUNTS(t)/total;
        omega_2 = 1 - omega_1;
        mu_k = mu_k + (t-1) * (COUNTS(t)/total);
        mu_1 = mu_k / omega_1;
        mu_2 = (sumVal - mu_k)/(omega_2);
        sumOfNeighbors = sum(COUNTS(max(1,t-N):min(256,t+N)));
        denom = total;
        currentVar = (1 - sumOfNeighbors/denom) * (omega_1 * mu_1^2 + omega_2 * mu_2^2);
        % Check if new maximum found
        if (currentVar > varMax)
           varMax = currentVar;
           threshold = t-1;
        end
    end

    output = threshold;
end
