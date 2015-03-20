function im = drawLine (im, pt1, pt2, width)

diff = pt2 - pt1;
[m n] = size(im);

if norm(diff) <= 1
    return;
end

if abs(diff(1)) < abs(diff(2))
    if diff(2) < 0
        tmp = pt1;
        pt1 = pt2;
        pt2 = tmp;
        diff = -diff;
    end
    k = diff(1) / diff(2);
    if width > 0
        for delta = 0: 1: width - 1
            for j = pt1(2): 1: pt2(2)
                i = round(pt1(1) + k * (j - pt1(2))) + delta;
                if i > 0 && i <= m && j > 0 && j <= n
                    im(int32(i), int32(j)) = 0;
                end
            end
        end
    else
        for delta = width + 1: 1: 0
            for j = pt1(2): 1: pt2(2)
                i = round(pt1(1) + k * (j - pt1(2))) + delta;
                if i > 0 && i <= m && j > 0 && j <= n
                    im(int32(i), int32(j)) = 0;
                end
            end
        end
    end
else
    if diff(1) < 0
        tmp = pt1;
        pt1 = pt2;
        pt2 = tmp;
        diff = -diff;
    end
    k = diff(2) / diff(1);
    if width > 0
        for delta = 0: 1: width - 1
            for i = pt1(1) + delta: 1: pt2(1) + delta
                j = round(pt1(2) + k * (i - pt1(1) - delta));
                if i > 0 && i <= m && j > 0 && j <= n
                    im(int32(i), int32(j)) = 0;
                end
            end
        end
    else
        for delta = width + 1: 1: 0
            for i = pt1(1) + delta: 1: pt2(1) + delta
                j = round(pt1(2) + k * (i - pt1(1) - delta));
                if i > 0 && i <= m && j > 0 && j <= n
                    im(int32(i), int32(j)) = 0;
                end
            end
        end
    end
end

% % For test
% figure, imshow(im);