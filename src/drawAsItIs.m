% sizes = [segHeight noteWidth vacWidth]
% forceQuarter: 0 (none); 1 (all use quarter note)
function [groupImage verticalMoveSet tailSet] = ...
    drawAsItIs (noteGroup, subNoteInfoSet, sizes, forceTail, forceQuarter)

% global halfdist;

noteNum = getLength(noteGroup, 2);
verticalMoveSet = zeros(noteNum, 1);
tailSet = zeros(noteNum, 1);

segHeight = sizes(1);
noteWidth = sizes(2);
vacWidth = sizes(3);
groupImage = 255 * ...
    ones(segHeight, round(noteWidth * noteNum + vacWidth * (noteNum - 1)));

for cntNote = 1: 1: noteNum
%     noteTemplate = genNoteTemplate(subNoteInfoSet{noteGroup(cntNote)}, ...
%         forceTail, forceQuarter);
    noteTemplate = getNoteTemplate(subNoteInfoSet{noteGroup(cntNote)}, ...
        forceTail, forceQuarter);
    
%     % For test
%     imshow(noteTemplate.image);
    
%     if noteTemplate.feat.tail == 1
%         noteTemplate.verticalMove = ...
%             6 * halfdist + noteTemplate.verticalMove;
%     end
    
    ic = floor(segHeight / 2 + noteTemplate.verticalMove);
    jc = floor(noteWidth * (cntNote - 0.5) + vacWidth * (cntNote - 1));
    groupImage = paste(groupImage, noteTemplate.image, [ic jc]);
    verticalMoveSet(cntNote) = noteTemplate.verticalMove;
    tailSet(cntNote) = noteTemplate.feat.tail;
    
%     % For test
%     imshow(groupImage);
end

% % For test
% imshow(groupImage);