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
% M. T. N. Truong and S. Kim. Automatic image thresholding using Otsu’s method and entropy weighting scheme for surface defect detection
% Journal of Soft Computing 2017

function output = entropy_otsu(I)
% Input:
%   I : 8-bit gray scale image
% Output:
%   output : optimal threshold value,
%            binary image can be obtained by using `im2bw(I, output/255)`

    [COUNTS,X] = imhist(I);
    p = zeros(1,256);
    Hn = 0;
    sumVal = 0;

    % Total number of pixels
    total = size(I, 1) * size(I, 2);

    for t = 1 : 256
        p(t) = COUNTS(t)/total;
        if (p(t) ~= 0)
            Hn = Hn + p(t) * log(p(t));
        end
        sumVal = sumVal + ((t-1) * COUNTS(t)/total);
    end
    Hn = -Hn;

    varMax = 0;
    threshold = 0;

    omega_1 = 0;
    mu_k = 0;
    Ps = 0;
    Hs = 0;

    for t=1:256
        omega_1 = omega_1 + p(t);
        omega_2 = 1 - omega_1;
        mu_k = mu_k + (t-1) * COUNTS(t)/total;
        mu_1 = mu_k / omega_1;
        mu_2 = (sumVal - mu_k) / (omega_2);
        Ps = Ps + p(t);
        if (p(t) ~= 0)
            Hs = Hs - p(t) * log(p(t));
        end
        psi = log(Ps * (1 - Ps)) + Hs/Ps + (Hn - Hs)/(1 - Ps);
        currentVar = psi * (omega_1 * mu_1^2 + omega_2 * mu_2^2);
        % Check if new maximum found
        if (currentVar > varMax)
           varMax = currentVar;
           threshold = t-1;
        end
    end

    output = threshold;
end
