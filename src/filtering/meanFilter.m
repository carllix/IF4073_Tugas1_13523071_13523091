function outImg = meanFilter(imgChannel, ksize)
% average filter
    arguments
        imgChannel (:,:) {mustBeNumeric}
        ksize (1,1) double {mustBePositive, mustBeInteger}
    end

    kernel = ones(ksize, ksize) / (ksize^2);
    outImg = convolve2d(imgChannel, kernel, "replicate");

end
