% sizes = [segHeight noteWidth vacWidth]
% If there is rest, it must be in a group with no others
function groupImage = drawGroup (noteGroup, subNoteInfoSet, sizes)

global err;

noteNum = getLength(noteGroup, 2);  % Note num in this group
segHeight = sizes(1);
noteWidth = sizes(2);
vacWidth = sizes(3);

totalNoteNum = getLength(subNoteInfoSet, 1);
subDur = zeros(totalNoteNum, 1);
for cntNote = 1: 1: totalNoteNum
    subDur(cntNote) = subNoteInfoSet{cntNote}.dur;
end

groupImage = 255 * ...
    ones(segHeight, round(noteWidth * noteNum + vacWidth * (noteNum - 1)));

if noteNum == 1
    % Only one note or rest, draw as it is
    [groupImage verticalMoveSet tailSet] = ...
        drawAsItIs(noteGroup, subNoteInfoSet, sizes, 0, 0);
elseif noteNum == 2  
    % If two notes have different beats, draw as they are separately
    if abs(subDur(noteGroup(1)) - subDur(noteGroup(2))) >= err
        [groupImage verticalMoveSet tailSet] = ...
            drawAsItIs(noteGroup, subNoteInfoSet, sizes, 0, 0);
    % If two notes have same beat, combine them
    else
        forceTail = getForceTail([subNoteInfoSet{noteGroup(1)}.pitch;...
                                  subNoteInfoSet{noteGroup(2)}.pitch]);
        [groupImage verticalMoveSet tailSet] = ...
            drawAsItIs(noteGroup, subNoteInfoSet, sizes, forceTail, 1);
        point = zeros(noteNum, 2);
        for cnt = 1: 1: noteNum
            ic = floor(segHeight / 2 + verticalMoveSet(cnt));
            jc = floor(noteWidth * (cnt - 0.5) + vacWidth * (cnt - 1));
            if tailSet(cnt) == 0
                point(cnt, :) = [ic - 47 jc + 13];
            else
                point(cnt, :) = [ic + 47 jc - 14 + 1];
            end
        end
        
        if abs(subDur(noteGroup(1)) - 0.5) < err
            [groupImage point] = ...
                drawBeam(groupImage, point, 1, forceTail - 1);
        elseif abs(subDur(noteGroup(1)) - 0.25) < err
            [groupImage point] = ...
                drawBeam(groupImage, point, [1 2], forceTail - 1);
        end
        
%         % For test
%         imshow(groupImage);
    end
elseif noteNum == 3
    % If middle note is different from others, draw as they are separately
    if abs(subDur(noteGroup(1)) - subDur(noteGroup(2)) >= err) ...
            && abs(subDur(noteGroup(2)) - subDur(noteGroup(3))) >= err
        [groupImage verticalMoveSet tailSet] = ...
            drawAsItIs(noteGroup, subNoteInfoSet, sizes, 0, 0);
    % If at least two notes have same beat, combine them
    else
        forceTail = getForceTail([subNoteInfoSet{noteGroup(1)}.pitch;...
                                  subNoteInfoSet{noteGroup(2)}.pitch; ...
                                  subNoteInfoSet{noteGroup(3)}.pitch]);
        [groupImage verticalMoveSet tailSet] = ...
            drawAsItIs(noteGroup, subNoteInfoSet, sizes, forceTail, 1);
        
        % Draw 1st order beam
        point = zeros(noteNum, 2);
        for cnt = 1: 1: noteNum
            ic = floor(segHeight / 2 + verticalMoveSet(cnt));
            jc = floor(noteWidth * (cnt - 0.5) + vacWidth * (cnt - 1));
            if tailSet(cnt) == 0
                point(cnt, :) = [ic - 47 jc + 13];
            else
                point(cnt, :) = [ic + 47 jc - 14 + 1];
            end
        end
        [groupImage point] = ...
            drawBeam(groupImage, point, 1, forceTail - 1);
        
%         % For test
%         imshow(groupImage);
        
        % Draw 2nd order beam
        if abs(subDur(noteGroup(1)) - subDur(noteGroup(2))) < err
            point = point([1 2], :);
        else
            point = point([2 3], :);
        end
        [groupImage point] = ...
            drawBeam(groupImage, point, 2, forceTail - 1);
        
%         % For test
%         imshow(groupImage);
    end
elseif noteNum == 4
    % Four notes, they must have same beat, so combine them
    % Draw 1st and 2nd order beams together
    forceTail = getForceTail([subNoteInfoSet{noteGroup(1)}.pitch;...
                                  subNoteInfoSet{noteGroup(2)}.pitch; ...
                                  subNoteInfoSet{noteGroup(3)}.pitch; ...
                                  subNoteInfoSet{noteGroup(4)}.pitch]);
    [groupImage verticalMoveSet tailSet] = ...
        drawAsItIs(noteGroup, subNoteInfoSet, sizes, forceTail, 1);
    point = zeros(noteNum, 2);
    for cnt = 1: 1: noteNum
        ic = floor(segHeight / 2 + verticalMoveSet(cnt));
        jc = floor(noteWidth * (cnt - 0.5) + vacWidth * (cnt - 1));
        if tailSet(cnt) == 0
            point(cnt, :) = [ic - 47 jc + 13];
        else
            point(cnt, :) = [ic + 47 jc - 14 + 1];
        end
    end
    [groupImage point] = ...
        drawBeam(groupImage, point, [1 2], forceTail - 1);
    
%     % For test
%     imshow(groupImage);
end