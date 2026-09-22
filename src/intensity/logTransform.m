function outImg = logTransform(imgChannel, c)
% s = c * log(1 + r)
    arguments
        imgChannel (:,:) {mustBeNumeric}
        c (1,1) double {mustBePositive} = 1
    end

    outImg = imgChannel;

    % TODO: implement

end
