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
% H. F. Ng, D. Jargalsaikhan, H. C. Tsai, and C. Y. Lin. An improved method for
% image thresholding based on the valley-emphasis method.
% In Signal and Information Processing Association Annual Summit and Conference (APSIPA),
% 2013 Asia-Pacific, pages 1-4, Kaohsiung, Taiwan, 2013. IEEE.

function output = gaussian_valley_emphasis(I, sigma)
% Input:
%   I     : 8-bit gray scale image
%   sigma : parameter for gaussian distribution
% Output:
%   output : optimal threshold value,
%            binary image can be obtained by using `im2bw(I, output/255)`

    [COUNTS,X] = imhist(I);

    % Total number of pixels
    total = size(I, 1) * size(I, 2);

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
        mu_2 = (sumVal - mu_k) / (omega_2);
        W_t = 0;
        for x = 1 : 256
            W_t = W_t + (COUNTS(x)/total) * exp(-(x-t-1)^2 / (2*sigma^2));
        end
        currentVar = (1 - W_t) * (omega_1 * mu_1^2 + omega_2 * mu_2^2);
        % Check if new maximum found
        if (currentVar > varMax)
           varMax = currentVar;
           threshold = t-1;
        end
    end

    output = threshold;
end
