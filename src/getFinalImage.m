function im = getFinalImage (lineImSet)

margin = 20;
lineNum = getLength(lineImSet, 1);
width = 0;
height = 0;
for cntLine = 1: 1: lineNum
    [lineImHeight lineImWidth] = size(lineImSet{cntLine});
    if width < lineImWidth
        width = lineImWidth;
    end
    height = height + lineImHeight;
end

im = 255 * ones(height, width + margin * 2);
is = 1;
for cntLine = 1: 1: lineNum
    [lineImHeight lineImWidth] = size(lineImSet{cntLine});
    im(is: 1: is + lineImHeight - 1, margin + 1: 1: margin + lineImWidth) ...
        = lineImSet{cntLine};
    is = is + lineImHeight;
end