function outImg = histogramEqualization(imgChannel)
% flatten intensity distribution using the CDF as a mapping
    arguments
        imgChannel (:,:) {mustBeNumeric}
    end

    counts = computeHistogram(imgChannel);
    cdf = computeCDF(counts);
    lookupTable = round(255 * cdf);

    idx = double(imgChannel) + 1;
    outImg = uint8(lookupTable(idx));

end
