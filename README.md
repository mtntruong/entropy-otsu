# entropy-otsu
MATLAB code and data for our paper:  
Automatic image thresholding using Otsu’s method and entropy weighting scheme for surface defect detection  
M. T. N. Truong and S. Kim  
Journal of Soft Computing  
2017  
https://link.springer.com/article/10.1007%2Fs00500-017-2709-1

# MATLAB code
Besides the implementation of our proposed method, we also provide our implementations of several thresholding methods which were used for comparison in our paper.
* `entropy_otsu.m` : Our method.
* `my_otsu.m` : Our implementation of Otsu's method.
* `valley_emphasis.m` : H. F. Ng. Automatic thresholding for defect detection. Pattern Recognition Letters, 27(14):1644-1649, 2006.
* `neighbor_valley_emphasis.m` : J. L. Fan and B. Lei. A modified valley-emphasis method for automatic thresholding. Pattern Recognition Letters, 33(6):703-708, 2012.
* `gaussian_valley_emphasis.m` : H. F. Ng, D. Jargalsaikhan, H. C. Tsai, and C. Y. Lin. An improved method for image thresholding based on the valley-emphasis method. In Signal and Information Processing Association Annual Summit and Conference (APSIPA), 2013 Asia-Pacific, pages 1-4, Kaohsiung, Taiwan, 2013. IEEE.
* `lda_valley_emphasis.m` : Z. Liu, J. Wang, Q. Zhao, and C. Li. A fabric defect detection algorithm based on improved valley-emphasis method. Research Journal of Applied Sciences, Engineering and Technology, 7(12):2427-2431, 2014.
* `main_script.m` : This source code reproduces two tables in our publication.

# Data
Ten samples of wafer surface used in experiments.
