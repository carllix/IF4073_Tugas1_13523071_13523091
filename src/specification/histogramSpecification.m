function outImg = histogramSpecification(imgChannel, refChannel)
% match imgChannel's histogram to refChannel's via CDF matching
    arguments
        imgChannel (:,:) {mustBeNumeric}
        refChannel (:,:) {mustBeNumeric}
    end

    cdfSrc = computeCDF(computeHistogram(imgChannel));
    cdfRef = computeCDF(computeHistogram(refChannel));

    distance = abs(cdfSrc(:) - cdfRef(:)');
    [~, nearestIdx] = min(distance, [], 2);
    lookupTable = nearestIdx' - 1;

    idx = double(imgChannel) + 1;
    outImg = uint8(lookupTable(idx));

end
