% point: every row is a point
function [im point] = drawBeam (im, point, order, tail)

beamWidth = 10;
intervalWidth = round(beamWidth / 2);  % interval between two beams
noteNum = getLength(point, 1);

[m n] = size(im);

is = point(1, 1);
js = point(1, 2);
ie = point(noteNum, 1);
je = point(noteNum, 2);
if is < ie
    js = js + 1;
    je = je + 1;
end

orderNum = getLength(order, 2);
for cntOrder = 1: 1: orderNum
    curOrder = order(cntOrder);
    if curOrder == 1
        k = (ie - is) / (je - js);
        for cnt = 2: 1: noteNum - 1
            i = point(cnt, 1);
            j = point(cnt, 2);
            inew = round(is + k * (j - js));
            point(cnt, 1) = inew;
            if tail == 0
                if inew < i
                    for idraw = inew: 1: i
                        if idraw > 0 && idraw <= m
                            if j > 0 && j <= n
                                im(idraw, j) = 0;
                            end
                            if j + 1 > 0 && j + 1 <= n
                                im(idraw, j + 1) = 0;
                            end
                        end
                    end
                else
                    for idraw = i: 1: inew
                        if idraw > 0 && idraw <= m
                            if j > 0 && j <= n
                                im(idraw, j) = 255;
                            end
                            if j + 1 > 0 && j + 1 <= n
                                im(idraw, j + 1) = 255;
                            end
                        end
                    end
                end
            else
                if inew < i
                    for idraw = inew: 1: i
                        if idraw > 0 && idraw <= m
                            if j > 0 && j <= n
                                im(idraw, j) = 255;
                            end
                            if j + 1 > 0 && j + 1 <= n
                                im(idraw, j + 1) = 255;
                            end
                        end
                    end
                else
                    for idraw = i: 1: inew
                        if idraw > 0 && idraw <= m
                            if j > 0 && j <= n
                                im(idraw, j) = 0;
                            end
                            if j + 1 > 0 && j + 1 <= n
                                im(idraw, j + 1) = 0;
                            end
                        end
                    end
                end
            end
        end
        if tail == 0
            im = drawLine(im, [is js], [ie je], beamWidth);
        else
            im = drawLine(im, [is js], [ie je], -beamWidth);
        end
    elseif curOrder == 2
        if tail == 0
            is = is + beamWidth + intervalWidth;
            ie = ie + beamWidth + intervalWidth;
            im = drawLine(im, [is js], [ie je], beamWidth);
        else
            is = is - beamWidth - intervalWidth;
            ie = ie - beamWidth - intervalWidth;
            im = drawLine(im, [is js], [ie je], -beamWidth);
        end
    end
end