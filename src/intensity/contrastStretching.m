function outImg = contrastStretching(imgChannel, r1, s1, r2, s2)
% piecewise-linear mapping through (r1,s1) and (r2,s2)
    arguments
        imgChannel (:,:) {mustBeNumeric}
        r1 (1,1) double {mustBeInRange(r1,0,255)}
        s1 (1,1) double {mustBeInRange(s1,0,255)}
        r2 (1,1) double {mustBeInRange(r2,0,255)}
        s2 (1,1) double {mustBeInRange(s2,0,255)}
    end

    outImg = imgChannel;

    % TODO: implement

end
