function outImg = gaussianFilter(imgChannel, ksize, sigma, paddingMode)
% gaussian blur
    arguments
        imgChannel (:,:) {mustBeNumeric}
        ksize (1,1) double {mustBePositive, mustBeInteger}
        sigma (1,1) double {mustBePositive} = 1
        paddingMode (1,1) string = "replicate"
    end

    center = floor(ksize / 2);
    [x, y] = meshgrid(-center:center, -center:center);

    kernel = (1 / (2*pi*sigma^2)) * exp(-(x.^2 + y.^2) / (2*sigma^2));

    kernel = kernel / sum(kernel(:));

    outImg = convolve2d(imgChannel, kernel, paddingMode);

end
