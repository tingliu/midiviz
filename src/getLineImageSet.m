function lineImSet = getLineImageSet(segImSet)

global fnroot;

lineNum = getLength(segImSet, 1);
lineImSet = cell(lineNum, 1);

for cntLine = 1: 1: lineNum
    segNum = getLength(segImSet{cntLine}, 1);
    lineIm = [];
    for cntSeg = 1: 1: segNum
        lineIm = concat(lineIm, segImSet{cntLine}{cntSeg});
    end
    
    % Add Gclef
    lineHead = imread([fnroot 'Gclef.png']);
    % Add timesig for the first line
    if cntLine == 1
        im = imread([fnroot 'timesig.png']);
        lineHead = concat(lineHead, im);
    end
    lineIm = concat(lineHead, lineIm);
    if cntLine == lineNum
        im = imread([fnroot 'bar_end.png']);
        lineIm = concat(lineIm, im);
    end
    lineImSet{cntLine} = lineIm;
    
%     % For test
%     figure, imshow(lineIm);
end