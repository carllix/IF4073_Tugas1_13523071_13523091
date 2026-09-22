function outImg = histogramSpecification(imgChannel, refChannel)
% match imgChannel's histogram to refChannel's via CDF matching
    arguments
        imgChannel (:,:) {mustBeNumeric}
        refChannel (:,:) {mustBeNumeric}
    end

    outImg = imgChannel;

    % TODO: implement

end
