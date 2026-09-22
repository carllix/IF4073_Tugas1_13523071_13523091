function outImg = negativeTransform(imgChannel)
% s = 255 - r
    arguments
        imgChannel (:,:) {mustBeNumeric}
    end

    outImg = uint8(255 - double(imgChannel));

end
