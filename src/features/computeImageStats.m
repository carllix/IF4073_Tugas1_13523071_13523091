function stats = computeImageStats(imgChannel)
% min, max, mean, std, entropy
    arguments
        imgChannel (:,:) {mustBeNumeric}
    end

    pixels = double(imgChannel(:));

    counts = computeHistogram(imgChannel);
    probs = counts / sum(counts);
    nonZeroProbs = probs(probs > 0);
    entropyVal = -sum(nonZeroProbs .* log2(nonZeroProbs));

    stats = struct( ...
        'minVal', min(pixels), ...
        'maxVal', max(pixels), ...
        'meanVal', mean(pixels), ...
        'stdVal', std(pixels), ...
        'entropy', entropyVal);

end
