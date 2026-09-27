function [outImg, label] = enhanceImage(img, method, params, refImg)
% run one enhancement method on a grayscale or RGB image, channel by channel
    arguments
        img {mustBeNumeric}
        method (1,1) string
        params (1,1) struct = struct()
        refImg {mustBeNumeric} = []
    end

    % each case builds fn(channel, channelIndex) and a label for the UI
    switch method
        case "brightening"
            fn = @(ch, ~) imageBrightening(ch, params.gain, params.offset);
            label = sprintf("Brightening (a = %.2f, b = %g)", params.gain, params.offset);

        case "negative"
            fn = @(ch, ~) negativeTransform(ch);
            label = "Negative";

        case "log"
            fn = @(ch, ~) logTransform(ch);
            label = "Log Transform";

        case "power"
            fn = @(ch, ~) powerLawTransform(ch, params.gamma);
            label = sprintf("Power Law (gamma = %.2f)", params.gamma);

        case "contrast"
            if params.r1 >= params.r2
                error("enhanceImage:invalidRange", "r1 must be smaller than r2.");
            end
            fn = @(ch, ~) contrastStretching(ch, params.r1, 0, params.r2, 255);   % output always [0,255]
            label = sprintf("Contrast Stretching (r1 = %g, r2 = %g)", params.r1, params.r2);

        case "equalization"
            fn = @(ch, ~) histogramEqualization(ch);
            label = "Histogram Equalization";

        case "specification"
            if isempty(refImg)
                error("enhanceImage:missingReference", "Histogram specification needs a reference image.");
            end
            if size(img, 3) == 1 && size(refImg, 3) == 3
                refImg = toGrayscale(refImg);
            end
            % R to R, G to G, B to B; a grayscale reference serves every channel
            fn = @(ch, k) histogramSpecification(ch, refImg(:, :, min(k, size(refImg, 3))));
            label = "Histogram Specification";

        case "mean"
            fn = @(ch, ~) meanFilter(ch, params.ksize);
            label = sprintf("Mean Filter (%dx%d)", params.ksize, params.ksize);

        case "median"
            fn = @(ch, ~) medianFilter(ch, params.ksize);
            label = sprintf("Median Filter (%dx%d)", params.ksize, params.ksize);

        case "gaussian"
            ksize = 2 * ceil(3 * params.sigma) + 1;   % covers +-3 sigma
            fn = @(ch, ~) gaussianFilter(ch, ksize, params.sigma);
            label = sprintf("Gaussian Filter (sigma = %.2f, %dx%d)", params.sigma, ksize, ksize);

        case "sharpen"
            fn = @(ch, ~) sharpenFilter(ch, params.sharpenMode, params.amount);
            label = sprintf("Sharpen (%s, amount = %.2f)", params.sharpenMode, params.amount);

        otherwise
            error("enhanceImage:unknownMethod", "Unknown method: %s.", method);
    end

    outImg = applyPerChannel(img, fn);

end
