function outImg = gaussianFilter(imgChannel, ksize, sigma)
% gaussian blur
    arguments
        imgChannel (:,:) {mustBeNumeric}
        ksize (1,1) double {mustBePositive, mustBeInteger}
        sigma (1,1) double {mustBePositive} = 1
    end

    kernel = zeros(ksize, ksize);

    % TODO: fill gaussian kernel, normalize sum to 1

    outImg = convolve2d(imgChannel, kernel, "replicate");

end
