function outImg = medianFilter(imgChannel, ksize)
% replace each pixel with the median of its neighborhood
    arguments
        imgChannel (:,:) {mustBeNumeric}
        ksize (1,1) double {mustBePositive, mustBeInteger}
    end

    outImg = imgChannel;

    % TODO: implement

end
