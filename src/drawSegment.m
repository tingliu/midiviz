function segImage = drawSegment (noteImSize, segImSize, segment)

global fnroot;

segHeight = segImSize(1);
segWidth = segImSize(2);
segImage = 255 * ones(segHeight, segWidth);
noteWidth = noteImSize(2);

vacNum = segment.noteNum + 1;
vacWidth = (segWidth - noteWidth * segment.noteNum) / vacNum;
sizes = [segHeight noteWidth vacWidth];

% for cntNote = 1: 1: segment.noteNum
%     noteTemplate = ...
%         genNoteTemplate(noteMat(segment.noteNo(cntNote), 4), ...
%         segment.dur(cntNote), 0, 0);
%     ic = floor(segHeight / 2) + noteTemplate.verticalMove;
%     jc = floor(vacWidth * cntNote + noteWidth * (cntNote - 0.5));
%     segImage = paste(segImage, noteTemplate.image, [ic jc]);
%     
% %     % For test
% %     imshow(segImage);
% end

noteNum = segment.noteNum;
% subNoteMat = zeros(noteNum, 7);
% subDur = zeros(noteNum, 1);
subNoteInfoSet = cell(noteNum, 1);
for cntNote = 1: 1: noteNum
    subNoteInfoSet{cntNote}.isRest = segment.isRest(cntNote);
    if subNoteInfoSet{cntNote}.isRest == 0
%         subNoteInfoSet{cntNote}.pitch = noteMat(segment.noteNo(cntNote), 4);
        subNoteInfoSet{cntNote}.pitch = segment.pitch(cntNote);
    else
        subNoteInfoSet{cntNote}.pitch = 0;
    end
    subNoteInfoSet{cntNote}.dur = segment.dur(cntNote);
%     subNoteMat(cntNote, :) = noteMat(segment.noteNo(cntNote), :);
%     subDur(cntNote) = segment.dur(cntNote);
end

noteGroupSet = getNoteGroupSet(segment);
groupNum = getLength(noteGroupSet, 1);
ic = floor(segHeight / 2);
jcprev = floor(vacWidth + 1);
for cntGroup = 1: 1: groupNum
    groupImage = drawGroup(noteGroupSet{cntGroup}, subNoteInfoSet, sizes);
    groupImWidth = getLength(groupImage, 2);
    jc = jcprev + floor(groupImWidth / 2);
    segImage = paste(segImage, groupImage, [ic jc]);
    jcprev = jcprev + floor(groupImWidth + vacWidth);
end

% Draw staff
staffImage = imread([fnroot 'staff.png']);
staffWidth = getLength(staffImage, 2);
staffNum = ceil(segWidth / staffWidth);
for cntStaff = 1: 1: staffNum
    ic = floor(segHeight / 2);
    jc = floor(staffWidth * (cntStaff - 0.5));
    segImage = paste(segImage, staffImage, [ic jc]);
end

% Draw bar
barImage = imread([fnroot 'bar.png']);
barWidth = getLength(barImage, 2);
ic = floor(segHeight / 2);
jc = segWidth - floor(barWidth / 2);
segImage = paste(segImage, barImage, [ic jc]);