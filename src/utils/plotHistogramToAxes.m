function plotHistogramToAxes(axesHandle, counts, barColor, titleText)
% draw histogram bars on a UIAxes
    arguments
        axesHandle
        counts (1,256) {mustBeNumeric}
        barColor = 'k'
        titleText (1,1) string = ""
    end

    bar(axesHandle, 0:255, counts, 'FaceColor', barColor, 'EdgeColor', 'none');
    xlim(axesHandle, [0 255]);
    title(axesHandle, titleText);
    xlabel(axesHandle, 'Intensity');
    ylabel(axesHandle, 'Pixel Count');

end
