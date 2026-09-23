function outImg = meanFilter(imgChannel, ksize, paddingMode)
% average filter
    arguments
        imgChannel (:,:) {mustBeNumeric}
        ksize (1,1) double {mustBePositive, mustBeInteger}
        paddingMode (1,1) string = "replicate"
    end

    kernel = ones(ksize, ksize) / (ksize^2);
    outImg = convolve2d(imgChannel, kernel, paddingMode);

end
