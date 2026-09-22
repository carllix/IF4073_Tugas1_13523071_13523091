function outImg = powerLawTransform(imgChannel, gamma, c)
% s = c * r^gamma
    arguments
        imgChannel (:,:) {mustBeNumeric}
        gamma (1,1) double {mustBePositive}
        c (1,1) double {mustBePositive} = 1
    end

    r = double(imgChannel) / 255;
    s = c * (r .^ gamma);
    outImg = uint8(s * 255);

end
