function rgbImg = mergeChannels(R, G, B)
% combine R, G, B into one image
    arguments
        R (:,:) {mustBeNumeric}
        G (:,:) {mustBeNumeric}
        B (:,:) {mustBeNumeric}
    end

    rgbImg = cat(3, R, G, B);

end
