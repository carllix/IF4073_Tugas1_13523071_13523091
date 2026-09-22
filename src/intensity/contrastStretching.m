function outImg = contrastStretching(imgChannel, r1, s1, r2, s2)
% piecewise-linear mapping through (r1,s1) and (r2,s2)
    arguments
        imgChannel (:,:) {mustBeNumeric}
        r1 (1,1) double {mustBeInRange(r1,0,255)}
        s1 (1,1) double {mustBeInRange(s1,0,255)}
        r2 (1,1) double {mustBeInRange(r2,0,255)}
        s2 (1,1) double {mustBeInRange(s2,0,255)}
    end

    r = double(imgChannel);
    s = zeros(size(r));

    mask1 = r < r1;
    mask2 = r >= r1 & r <= r2;
    mask3 = r > r2;

    if r1 > 0
        s(mask1) = (s1 / r1) * r(mask1);
    end

    if r2 > r1
        s(mask2) = ((s2 - s1) / (r2 - r1)) * (r(mask2) - r1) + s1;
    else
        s(mask2) = s1;
    end

    if r2 < 255
        s(mask3) = ((255 - s2) / (255 - r2)) * (r(mask3) - r2) + s2;
    else
        s(mask3) = s2;
    end

    outImg = uint8(s);

end
