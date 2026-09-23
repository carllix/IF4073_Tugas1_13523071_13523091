function outImg = sharpenFilter(imgChannel, kernelType, strength, paddingMode)
% sharpen using a laplacian-style kernel
    arguments
        imgChannel (:,:) {mustBeNumeric}
        kernelType (1,1) string {mustBeMember(kernelType, ["8-neighbor", "4-neighbor", "highpass"])} = "8-neighbor"
        strength (1,1) double {mustBeNonnegative} = 1
        paddingMode (1,1) string = "replicate"
    end

    identity = [0 0 0; 0 1 0; 0 0 0];
    laplacian4 = [0 -1 0; -1 4 -1; 0 -1 0];
    laplacian8 = [-1 -1 -1; -1 8 -1; -1 -1 -1];

    switch kernelType
        case "8-neighbor"
            kernel = identity + strength * laplacian8;
        case "4-neighbor"
            kernel = identity + strength * laplacian4;
        case "highpass"
            kernel = strength * laplacian8;
    end

    outImg = convolve2d(imgChannel, kernel, paddingMode);

end
