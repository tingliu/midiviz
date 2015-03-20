function segUnit = saveSegBuffer (extraNote, segBuffer)

global err;
global beatPerSeg;
global beatTab;

segUnit.segNo = segBuffer.segNo;

segUnit.noteNum = segBuffer.noteNum + extraNote.noteNum;

segUnit.noteNo = [extraNote.noteNo(1: 1: extraNote.noteNum); ...
                  segBuffer.noteNo(1: 1: segBuffer.noteNum)];

segUnit.onset = [extraNote.onset(1: 1: extraNote.noteNum); ...
                 segBuffer.onset(1: 1: segBuffer.noteNum)];

segUnit.dur = [extraNote.dur(1: 1: extraNote.noteNum); ...
               segBuffer.dur(1: 1: segBuffer.noteNum)];
           
segUnit.pitch = [extraNote.pitch(1: 1: extraNote.noteNum); ...
                 segBuffer.pitch(1: 1: segBuffer.noteNum)];

segUnit.isHasArc = [extraNote.isHasArc(1: 1: extraNote.noteNum); ...
                    segBuffer.isHasArc(1: 1: segBuffer.noteNum)];

segUnit.isRest = [extraNote.isRest(1: 1: extraNote.noteNum); ...
                  segBuffer.isRest(1: 1: segBuffer.noteNum)];
              
segUnit.isExistRndErr = [extraNote.isExistRndErr(1: 1: extraNote.noteNum); ...
                         segBuffer.isExistRndErr(1: 1: segBuffer.noteNum)];
              
for cntNote = 1: 1: segUnit.noteNum
    if abs(segUnit.dur(cntNote) - 1.25) < err ...
            || abs(segUnit.dur(cntNote) - 1.75) < err
        newSegUnit.segNo = segUnit.segNo;
        newSegUnit.noteNum = segUnit.noteNum + 1;
        
        newSegUnit.noteNo = zeros(newSegUnit.noteNum, 1);
        newSegUnit.noteNo(1: 1: cntNote, :) = ...
            segUnit.noteNo(1: 1: cntNote, :);
        newSegUnit.noteNo(1: 1: cntNote + 1, :) = newSegUnit.noteNo(cntNote);
        newSegUnit.noteNo(cntNote + 2: 1: newSegUnit.noteNum) = ...
            segUnit.noteNo(cntNote + 1: 1: segUnit.noteNum);

        newSegUnit.dur = zeros(newSegUnit.noteNum, 1);
        newSegUnit.dur(1: 1: cntNote, :) = ...
            segUnit.dur(1: 1: cntNote, :);
        newSegUnit.dur(cntNote) = newSegUnit.dur(cntNote) - 0.25;
        newSegUnit.dur(cntNote + 1) = 0.25;
        newSegUnit.dur(cntNote + 2: 1: newSegUnit.noteNum, :) = ...
            segUnit.dur(cntNote + 1: 1: segUnit.noteNum, :);
        
        newSegUnit.onset = zeros(newSegUnit.noteNum, 1);
        newSegUnit.onset(1: 1: cntNote, :) = ...
            segUnit.onset(1: 1: cntNote, :);
        newSegUnit.onset(1: 1: cntNote + 1, :) = ...
            newSegUnit.onset(cntNote) + newSegUnit.dur(cntNote);
        newSegUnit.onset(cntNote + 2: 1: newSegUnit.noteNum) = ...
            segUnit.onset(cntNote + 1: 1: segUnit.noteNum);
        
        newSegUnit.pitch = zeros(newSegUnit.noteNum, 1);
        newSegUnit.pitch(1: 1: cntNote, :) = ...
            segUnit.pitch(1: 1: cntNote, :);
        newSegUnit.pitch(1: 1: cntNote + 1, :) = newSegUnit.pitch(cntNote);
        newSegUnit.pitch(cntNote + 2: 1: newSegUnit.noteNum) = ...
            segUnit.pitch(cntNote + 1: 1: segUnit.noteNum);
        
        newSegUnit.isHasArc = zeros(newSegUnit.noteNum, 1);
        newSegUnit.isHasArc(1: 1: cntNote, :) = ...
            segUnit.isHasArc(1: 1: cntNote, :);
        newSegUnit.isHasArc(1: 1: cntNote + 1, :) = ...
            newSegUnit.isHasArc(cntNote);
        newSegUnit.isHasArc(cntNote + 2: 1: newSegUnit.noteNum) = ...
            segUnit.isHasArc(cntNote + 1: 1: segUnit.noteNum);
        
        newSegUnit.isRest = zeros(newSegUnit.noteNum, 1);
        newSegUnit.isRest(1: 1: cntNote, :) = ...
            segUnit.isRest(1: 1: cntNote, :);
        newSegUnit.isRest(1: 1: cntNote + 1, :) = ...
            newSegUnit.isRest(cntNote);
        newSegUnit.isRest(cntNote + 2: 1: newSegUnit.noteNum) = ...
            segUnit.isRest(cntNote + 1: 1: segUnit.noteNum);
        
        newSegUnit.isExistRndErr = zeros(newSegUnit.noteNum, 1);
        newSegUnit.isExistRndErr(1: 1: cntNote, :) = ...
            segUnit.isExistRndErr(1: 1: cntNote, :);
        newSegUnit.isExistRndErr(1: 1: cntNote + 1, :) = ...
            newSegUnit.isExistRndErr(cntNote);
        newSegUnit.isExistRndErr(cntNote + 2: 1: newSegUnit.noteNum) = ...
            segUnit.isExistRndErr(cntNote + 1: 1: segUnit.noteNum);
        disp('1.25/1.75: Big move');
        segUnit = newSegUnit;
    end
end
                     
segDur = 0.0;
changeableDurNum = 0;
for cntNote = 1: 1: segUnit.noteNum
    segDur = segDur + segUnit.dur(cntNote);
    if segUnit.isExistRndErr(cntNote) == 1
        changeableDurNum = changeableDurNum + 1;
    end
end
changedDurNote = ones(changeableDurNum, 1);
for cntNote = 1: 1: segUnit.noteNum
    if segUnit.isExistRndErr(cntNote) == 1
        changedDurNote(cntNote) = 0;
    end
end

checkIndexMinus = 1;
% checkIndexPlus = segUnit.noteNum;
lenTab = getLength(beatTab, 1);
while (segDur > beatPerSeg && abs(segDur - beatPerSeg) > err ...
        || segDur < beatPerSeg && abs(segDur - beatPerSeg) > err) ...
        && changeableDurNum > 0
    
    while checkIndexMinus <= segUnit.noteNum
        if segUnit.isExistRndErr(checkIndexMinus) == 1
            % Match in beatTab
            minDiff = 99;
            minJ = 0;
            for j = 1: 1: lenTab
                diff = abs(segUnit.dur(checkIndexMinus) - beatTab(j));
                if diff < minDiff && abs(diff - minDiff) > err
                    minDiff = diff;
                    minJ = j;
                end
            end
            segUnit.dur(checkIndexMinus) = beatTab(minJ + 1);
            segDur = segDur - (beatTab(minJ) - beatTab(minJ + 1));
            changedDurNote(checkIndexMinus) = 1;
            changeableDurNum = changeableDurNum - 1;
            checkIndexMinus = checkIndexMinus + 1;
            break;
        else
            checkIndexMinus = checkIndexMinus + 1;
        end
    end
    
%     while checkIndexPlus >= 1
%         if segUnit.isExistRndErr(checkIndexPlus) == 1
%             % Match in beatTab
%             minDiff = 99;
%             minJ = 0;
%             for j = 1: 1: lenTab
%                 diff = abs(segUnit.dur(checkIndexMinus) - beatTab(j));
%                 if diff < minDiff && abs(diff - minDiff) > err
%                     minDiff = diff;
%                     minJ = j;
%                 end
%             end
%             segUnit.dur(checkIndexMinus) = beatTab(minJ + 1);
%             segDur = segDur - (beatTab(minJ) - beatTab(minJ + 1));
%             changedDurNote(checkIndexMinus) = 1;
%             changeableDurNum = changeableDurNum - 1;
%             checkIndexMinus = checkIndexMinus + 1;
%             break;
%         else
%             checkIndexPlus = checkIndexPlus - 1;
%         end
%     end
end