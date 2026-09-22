function outImg = convolve2d(imgChannel, kernel, paddingMode)
% slide kernel over the image, sum products per window
    arguments
        imgChannel (:,:) {mustBeNumeric}
        kernel (:,:) double
        paddingMode (1,1) string = "replicate"
    end

    outImg = imgChannel;

    % TODO: implement

end
