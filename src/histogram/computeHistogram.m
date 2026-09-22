function counts = computeHistogram(imgChannel)
% count pixels per intensity level (0-255)
    arguments
        imgChannel (:,:) {mustBeNumeric}
    end

    counts = zeros(1, 256);
    pixels = double(imgChannel(:));

    for level = 0:255
        counts(level + 1) = sum(pixels == level);
    end

end
