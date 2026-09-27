function summary = diagnoseImage(img)
% short problem description from the histogram and basic statistics

    arguments
        img {mustBeNumeric}
    end

    DARK_MEAN = 85;          % lower third of 0-255
    BRIGHT_MEAN = 170;       % upper third of 0-255
    NARROW_RANGE = 128;      % histogram spans less than half of 0-255
    SPIKE_FRACTION = 0.01;   % at least 1% of pixels in the end bin
    SPIKE_RATIO = 5;         % end bin at least 5x its neighbouring bins

    gray = toGrayscale(img);
    stats = computeImageStats(gray);

    % effective range: P1-P99 ignores a few outliers that make min/max misleading
    cdf = computeCDF(computeHistogram(gray));
    p1 = find(cdf >= 0.01, 1) - 1;
    p99 = find(cdf >= 0.99, 1) - 1;

    issues = strings(0);
    if stats.meanVal < DARK_MEAN
        issues(end+1) = sprintf("too dark (mean %.0f)", stats.meanVal);
    elseif stats.meanVal > BRIGHT_MEAN
        issues(end+1) = sprintf("too bright (mean %.0f)", stats.meanVal);
    end
    if p99 - p1 < NARROW_RANGE
        issues(end+1) = sprintf("low contrast (histogram spans %d-%d)", p1, p99);
    end

    % salt-and-pepper puts isolated spikes at BOTH 0 and 255; clipping spikes one end only
    for k = 1:size(img, 3)
        counts = computeHistogram(img(:, :, k));
        minCount = SPIKE_FRACTION * sum(counts);
        if isEndSpike(counts(1), counts(2:6), minCount, SPIKE_RATIO) && ...
           isEndSpike(counts(256), counts(251:255), minCount, SPIKE_RATIO)
            issues(end+1) = "salt-and-pepper noise (spikes at 0 and 255)";
            break;
        end
    end

    if isempty(issues)
        summary = "No major brightness, contrast or impulse-noise issue detected.";
    else
        summary = strjoin(issues, ", ") + ".";
    end

end

function tf = isEndSpike(endCount, neighbourCounts, minCount, minRatio)
% end bin holds many pixels and towers over its neighbouring bins
    tf = endCount >= minCount && endCount >= minRatio * max(mean(neighbourCounts), 1);

end
