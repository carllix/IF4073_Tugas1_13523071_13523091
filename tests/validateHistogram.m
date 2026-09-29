function results = validateHistogram()
% validate computeHistogram against imhist on data/histogram-citra
%
% output:
%   <image>_histogram.png   channel image | computeHistogram | imhist
%   validation.csv          one row per image channel

    rootDir = fileparts(fileparts(mfilename('fullpath')));
    addpath(genpath(fullfile(rootDir, 'src')));

    dataDir = fullfile(rootDir, 'data', 'histogram-citra');
    outDir = fullfile(rootDir, 'tests', 'output', 'histogram-citra');
    if ~isfolder(outDir)
        mkdir(outDir);
    end

    files = dir(fullfile(dataDir, '*.png'));
    rows = {};

    for k = 1:numel(files)
        name = files(k).name;
        img = loadImage(fullfile(files(k).folder, name));
        numCh = size(img, 3);

        if numCh == 3
            imgType = "RGB";
            chNames = ["R", "G", "B"];
            chColors = [0.85 0.2 0.2; 0.2 0.65 0.2; 0.2 0.35 0.85];
        else
            imgType = "Grayscale";
            chNames = "Gray";
            chColors = [0.3 0.3 0.3];
        end

        fig = figure('Visible', 'off', 'Position', [100 100 1200 320 * numCh]);
        tl = tiledlayout(fig, numCh, 3, 'TileSpacing', 'compact', 'Padding', 'compact');
        title(tl, sprintf('%s (%s, %dx%d)', name, imgType, size(img, 2), size(img, 1)), ...
            'Interpreter', 'none');

        for c = 1:numCh
            ch = img(:,:,c);
            mine = computeHistogram(ch);
            ref = imhist(ch)';              

            maxDiff = max(abs(mine - ref));
            sumOk = sum(mine) == numel(ch);       
            isValid = maxDiff == 0 && sumOk;
            stats = computeImageStats(ch);

            rows(end + 1, :) = {string(name), imgType, chNames(c), numel(ch), sum(mine), ...
                sumOk, maxDiff, isValid, stats.minVal, stats.maxVal, stats.meanVal, ...
                stats.stdVal, stats.entropy}; %#ok<AGROW>

            fprintf('%-12s %-4s  pixels=%-8d sum=%-8d maxDiff=%-3d %s\n', name, chNames(c), ...
                numel(ch), sum(mine), maxDiff, validLabel(isValid));

            ax = nexttile(tl);
            imshow(ch, 'Parent', ax);
            title(ax, sprintf('Kanal %s', chNames(c)));

            ax = nexttile(tl);
            bar(ax, 0:255, mine, 1, 'FaceColor', chColors(c, :), 'EdgeColor', 'none');
            xlim(ax, [-1 256]);
            title(ax, sprintf('computeHistogram (%s)', chNames(c)));
            xlabel(ax, 'Intensitas'); ylabel(ax, 'Jumlah piksel');

            ax = nexttile(tl);
            bar(ax, 0:255, ref, 1, 'FaceColor', chColors(c, :), 'EdgeColor', 'none');
            xlim(ax, [-1 256]);
            title(ax, sprintf('imhist (%s) | max selisih = %d', chNames(c), maxDiff));
            xlabel(ax, 'Intensitas'); ylabel(ax, 'Jumlah piksel');
        end

        [~, base] = fileparts(name);
        exportgraphics(fig, fullfile(outDir, [base '_histogram.png']), 'Resolution', 150);
        close(fig);
    end

    results = cell2table(rows, 'VariableNames', {'Image', 'Type', 'Channel', 'NumPixels', ...
        'SumCounts', 'SumOk', 'MaxDiff', 'Valid', 'Min', 'Max', 'Mean', 'Std', 'Entropy'});
    writetable(results, fullfile(outDir, 'validation.csv'));

    fprintf('\n%d/%d kanal valid. Output: %s\n', sum(results.Valid), height(results), outDir);

end

function s = validLabel(isValid)
    if isValid
        s = 'VALID';
    else
        s = 'MISMATCH';
    end
end
