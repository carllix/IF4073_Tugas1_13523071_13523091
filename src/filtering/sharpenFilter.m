function outImg = sharpenFilter(imgChannel, strength)
% sharpen using a laplacian-style kernel
    arguments
        imgChannel (:,:) {mustBeNumeric}
        strength (1,1) double = 1
    end

    kernel = [0 0 0; 0 1 0; 0 0 0];

    % TODO: build sharpening kernel scaled by strength

    outImg = convolve2d(imgChannel, kernel, "replicate");

end
