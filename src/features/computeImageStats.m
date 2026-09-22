function stats = computeImageStats(imgChannel)
% min, max, mean, std, entropy
    arguments
        imgChannel (:,:) {mustBeNumeric}
    end

    stats = struct('minVal', 0, 'maxVal', 0, 'meanVal', 0, ...
                    'stdVal', 0, 'entropy', 0);

    % TODO: implement

end
