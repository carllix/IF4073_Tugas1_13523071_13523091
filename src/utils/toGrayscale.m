function grayImg = toGrayscale(rgbImg)
% convert RGB to grayscale
    arguments
        rgbImg {mustBeNumeric}
    end

    if size(rgbImg, 3) == 1
        grayImg = rgbImg;
        return;
    end

    grayImg = zeros(size(rgbImg, 1), size(rgbImg, 2), 'uint8');

    % TODO: implement

end
