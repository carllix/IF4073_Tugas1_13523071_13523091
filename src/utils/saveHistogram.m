function saveHistogram(img, filePath, titleText)
% export the histogram
    arguments
        img {mustBeNumeric}
        filePath (1,1) string
        titleText (1,1) string = ""
    end

    nChannels = size(img, 3);
    if nChannels == 1
        colors = {'k'};
        names = "Grayscale";
    else
        colors = {'r', 'g', 'b'};
        names = ["Red", "Green", "Blue"];
    end

    fig = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 900 300 * nChannels]);
    cleanup = onCleanup(@() close(fig));
    tl = tiledlayout(fig, nChannels, 1, 'TileSpacing', 'compact', 'Padding', 'compact');
    if titleText ~= ""
        title(tl, titleText, 'FontWeight', 'bold');
    end

    axesList = gobjects(1, nChannels);
    for k = 1:nChannels
        axesList(k) = nexttile(tl);
        plotHistogramToAxes(axesList(k), computeHistogram(img(:, :, k)), colors{k}, names(k));
    end
    linkaxes(axesList, 'y');   % same y-scale so channel heights are comparable

    exportgraphics(fig, filePath, 'Resolution', 300, 'BackgroundColor', 'white');

end
