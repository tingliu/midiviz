function segImSet = getSegImageSet (segmentSet, segPerLine)

global noteWidth;
global noteHeight;

segNum = getLength(segmentSet, 1);
lineNum = ceil(segNum / segPerLine);
lastLineSegNum = segNum - segPerLine * (lineNum - 1);

maxNoteNumPerSeg = 0;
for cntSeg = 1: 1: segNum
%     noteNumPerSeg = getSegWidth(segmentSet, cntSeg);
    noteNumPerSeg = segmentSet{cntSeg}.noteNum;
    if noteNumPerSeg > maxNoteNumPerSeg
        maxNoteNumPerSeg = noteNumPerSeg;
    end
end

segWidth = noteWidth * maxNoteNumPerSeg;
segHeight = noteHeight;

segNo = 1;
segImSet = cell(lineNum, 1);
for cntLine = 1: 1: lineNum
    if cntLine ~= lineNum
        segImSet{cntLine} = cell(segPerLine, 1);
        for cntSeg = 1: 1: segPerLine
            segImage = drawSegment([noteHeight noteWidth], ...
                [segHeight segWidth], segmentSet{segNo});
            segImSet{cntLine}{cntSeg} = segImage;
            segNo = segNo + 1;
            
%             % For test
%             figure, imshow(segImage);
        end
    else
        segImSet{lineNum} = cell(lastLineSegNum, 1);
        for cntSeg = 1: 1: lastLineSegNum
            segImage = drawSegment([noteHeight noteWidth], ...
                [segHeight segWidth], segmentSet{segNo});
            segImSet{lineNum}{cntSeg} = segImage;
            segNo = segNo + 1;
            
%             % For test
%             figure, imshow(segImage);
        end
    end
end