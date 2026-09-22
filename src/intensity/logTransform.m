function outImg = logTransform(imgChannel, c)
% s = c * log(1 + r)
    arguments
        imgChannel (:,:) {mustBeNumeric}
        c (1,1) double {mustBePositive} = 255 / log(256)
    end

    r = double(imgChannel);
    s = c * log(1 + r);
    outImg = uint8(s);

end
