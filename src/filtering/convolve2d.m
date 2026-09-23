function outImg = convolve2d(imgChannel, kernel, paddingMode)
% slide kernel over the image, sum products per window
    arguments
        imgChannel (:,:) {mustBeNumeric}
        kernel (:,:) double {mustBeNonempty}
        paddingMode (1,1) string {mustBeMember(paddingMode, ["replicate", "zero"])} = "replicate"
    end

    [kh, kw] = size(kernel);
    padRows = floor(kh / 2);
    padCols = floor(kw / 2);

    [H, W] = size(imgChannel);
    img = double(imgChannel);
    if paddingMode == "zero"
        padded = zeros(H + 2*padRows, W + 2*padCols);
        padded(padRows+1 : padRows+H, padCols+1 : padCols+W) = img;
    else
        rowIdx = [ones(1, padRows), 1:H, H * ones(1, padRows)];
        colIdx = [ones(1, padCols), 1:W, W * ones(1, padCols)];
        padded = img(rowIdx, colIdx);
    end

    flipped = kernel(end:-1:1, end:-1:1);

    acc = zeros(H, W);
    for i = 1:kh
        for j = 1:kw
            acc = acc + flipped(i, j) * padded(i : i+H-1, j : j+W-1);
        end
    end

    acc(acc < 0) = 0;
    acc(acc > 255) = 255;
    outImg = uint8(acc);

end
