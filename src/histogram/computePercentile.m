function level = computePercentile(imgChannel, p)
% lowest intensity level at or below which a fraction p of the pixels fall
    arguments
        imgChannel (:,:) {mustBeNumeric}
        p (1,1) double {mustBeInRange(p, 0, 1)}
    end

    cdf = computeCDF(computeHistogram(imgChannel));
    level = find(cdf >= p, 1) - 1;

end
