function outImg = imageBrightening(imgChannel, a, b)
% s = a*r + b
    arguments
        imgChannel (:,:) {mustBeNumeric}
        a (1,1) double = 1
        b (1,1) double = 0
    end

    r = double(imgChannel);
    s = a * r + b;
    outImg = uint8(s);

end
