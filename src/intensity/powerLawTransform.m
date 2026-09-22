function outImg = powerLawTransform(imgChannel, gamma, c)
% s = c * r^gamma
    arguments
        imgChannel (:,:) {mustBeNumeric}
        gamma (1,1) double {mustBePositive}
        c (1,1) double {mustBePositive} = 1
    end

    outImg = imgChannel;

    % TODO: implement

end
