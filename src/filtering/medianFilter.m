function outImg = medianFilter(imgChannel, ksize, paddingMode)
% median filter
    arguments
        imgChannel (:,:) {mustBeNumeric}
        ksize (1,1) double {mustBePositive, mustBeInteger}
        paddingMode (1,1) string {mustBeMember(paddingMode, ["replicate", "zero"])} = "replicate"
    end

    [H, W] = size(imgChannel);
    pad = floor(ksize / 2);
    if paddingMode == "zero"
        padded = zeros(H + 2*pad, W + 2*pad, 'like', imgChannel);
        padded(pad+1 : pad+H, pad+1 : pad+W) = imgChannel;
    else
        rowIdx = [ones(1, pad), 1:H, H * ones(1, pad)];
        colIdx = [ones(1, pad), 1:W, W * ones(1, pad)];
        padded = imgChannel(rowIdx, colIdx);
    end

    windows = zeros(H, W, ksize^2, 'like', imgChannel);
    k = 0;
    for i = 1:ksize
        for j = 1:ksize
            k = k + 1;
            windows(:, :, k) = padded(i : i+H-1, j : j+W-1);
        end
    end

    sorted = sort(windows, 3);
    medianPos = (ksize^2 + 1) / 2;
    outImg = uint8(sorted(:, :, medianPos));

end
