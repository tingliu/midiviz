function noteGroupSet = getNoteGroupSet (segment)

global err;

minDurSumPerGroup = 1.0;
maxGroupNum = 32;
groupNum = 0;
noteGroupSet = cell(maxGroupNum, 1);
cntNote = 1;
while cntNote <= segment.noteNum
    if segment.dur(cntNote) >= minDurSumPerGroup ...
            || abs(segment.dur(cntNote) - minDurSumPerGroup) < err ...
            || segment.isRest(cntNote) == 1
        groupNum = groupNum + 1;
        noteGroupSet{groupNum} = cntNote;
        cntNote = cntNote + 1;
    else
        durAcc = 0;
        i = cntNote;
        while i <= segment.noteNum
            durAcc = durAcc + segment.dur(i);
            diff = abs(durAcc - minDurSumPerGroup);
            if durAcc > minDurSumPerGroup && diff > err ...
                    || segment.isRest(i) == 1
                break;
            end
            i = i + 1;
        end
        groupNum = groupNum + 1;
        noteGroupSet{groupNum} = cntNote: 1: i - 1;
        cntNote = i;
    end
end

% Trim noteGroup
noteGroupSet = noteGroupSet(1: 1: groupNum);