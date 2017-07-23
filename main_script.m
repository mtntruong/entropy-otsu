function main_script()
    clc;

    addpath('./implementation')

    result_matrix = zeros(10,6);
    threshold_matrix = zeros(10,6);

    for i = 0 : 9
        I = imread(['./data/sample' num2str(i) '.tif']);

        h = entropy_otsu(I);
        result_matrix(i+1,1) = pixel_count(I, h);
        threshold_matrix(i+1,1) = h;

        h = my_otsu(I);
        result_matrix(i+1,2) = pixel_count(I, h);
        threshold_matrix(i+1,2) = h;

        h = valley_emphasis(I);
        result_matrix(i+1,3) = pixel_count(I, h);
        threshold_matrix(i+1,3) = h;

        h = neighbor_valley_emphasis(I,5);
        result_matrix(i+1,4) = pixel_count(I, h);
        threshold_matrix(i+1,4) = h;

        h = gaussian_valley_emphasis(I,5);
        result_matrix(i+1,5) = pixel_count(I, h);
        threshold_matrix(i+1,5) = h;

        h = lda_valley_emphasis(I);
        result_matrix(i+1,6) = pixel_count(I, h);
        threshold_matrix(i+1,6) = h;
    end
    
    fprintf('Table 1. Pixel counts of defect regions.\n')
    fprintf([repmat('-',1,70) '\n'])
    fprintf('Image #   Proposed method  Valley-emphasis  Neighbor-VE  Fisher''s LDA\n');
    fprintf([repmat('-',1,70) '\n'])
    for i = 1 : 10
        fprintf([num2str(i) '\t  ' ...
                 num2str(result_matrix(i,1)) '\t\t   ' ...
                 num2str(result_matrix(i,3)) '\t\t    ' ...
                 num2str(result_matrix(i,4)) '\t\t ' ...
                 num2str(result_matrix(i,6)) '\n']);
    end
    fprintf([repmat('-',1,70) '\n\n'])
    
    fprintf('Table 2. Output thresholds.\n')
    fprintf([repmat('-',1,70) '\n'])
    fprintf('Image #   Proposed method  Valley-emphasis  Neighbor-VE  Fisher''s LDA\n');
    fprintf([repmat('-',1,70) '\n'])
    for i = 1 : 10
        fprintf([num2str(i) '\t  ' ...
                 num2str(threshold_matrix(i,1)) '\t\t   ' ...
                 num2str(threshold_matrix(i,3)) '\t\t    ' ...
                 num2str(threshold_matrix(i,4)) '\t\t ' ...
                 num2str(threshold_matrix(i,6)) '\n']);
    end
    fprintf([repmat('-',1,70) '\n'])

    rmpath('./implementation')

end

function output = pixel_count( img, threshold )

    img = im2bw(img, threshold/255);

    % if the thresholded image is mainly black, white pixels are supposed
    % to be abnormal, and vice versa
    if sum(sum(img == 0)) > sum(sum(img == 1))
        output =  sum(sum(img == 1));
    else
        output =  sum(sum(img == 0));
    end

end
