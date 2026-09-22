function cdf = computeCDF(counts)
% cumulative sum of a histogram, normalized to [0,1]
    arguments
        counts (1,256) {mustBeNumeric}
    end

    total = sum(counts);
    cumulative = cumsum(counts);
    cdf = cumulative / total;

end
