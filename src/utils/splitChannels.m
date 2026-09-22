function [R, G, B] = splitChannels(rgbImg)
% split into R, G, B
    arguments
        rgbImg (:,:,3) {mustBeNumeric}
    end

    R = rgbImg(:,:,1);
    G = rgbImg(:,:,2);
    B = rgbImg(:,:,3);

end
