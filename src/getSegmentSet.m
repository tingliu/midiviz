function segmentSet = getSegmentSet (noteMat, beatPerSeg)

global err;

[dur durIsExistRndErr] = roundBeat(noteMat(:, 2));

noteNum = getLength(noteMat, 1);
segNum = ceil((noteMat(noteNum, 1) + noteMat(noteNum, 2)) / beatPerSeg);
segmentSet = cell(segNum, 1);

segNo = 1;
segBuffer = initSegBuffer(32, segNo);
extraNote = initSegBuffer(32, 0);

beatSegEnd = beatPerSeg;
lastBeatEnd = 0;
for cntNote = 1: 1: noteNum
    thisOnset = noteMat(cntNote, 1);
    thisDur = dur(cntNote);
    
    if abs(thisDur) < err
        lastBeatEnd = thisOnset + thisDur;
        continue;
    end
    
    % Find a rest
    while thisOnset > lastBeatEnd && abs(thisOnset - lastBeatEnd) > err
        % If this note already belongs to next segment
        % Then limit rest in this segment
        if thisOnset >= beatSegEnd || abs(thisOnset - beatSegEnd) < err
            [restDur restIsExistRndErr] = ...
                roundBeat(beatSegEnd - lastBeatEnd);
            lastBeatEnd = beatSegEnd;
            if abs(restDur) > err
                restOnset = lastBeatEnd;
                segBuffer = incSegBuffer(segBuffer, 0, restOnset, ...
                    restDur, 0, 0, 1, restIsExistRndErr);
            end
            % Save buffer to segmentSet
            segmentSet{segNo} = saveSegBuffer(extraNote, segBuffer);
            segNo = segNo + 1;
            beatSegEnd = beatSegEnd + beatPerSeg;
            % Clear buffer and extra note
            segBuffer = initSegBuffer(32, segNo);
            extraNote = initSegBuffer(32, 0);
        else
            [restDur restIsExistRndErr] = ...
                roundBeat(thisOnset - lastBeatEnd);
            if abs(restDur) > err
                restOnset = lastBeatEnd;
                segBuffer = incSegBuffer(segBuffer, 0, restOnset, ...
                    restDur, 0, 0, 1, restIsExistRndErr);
            end
            lastBeatEnd = thisOnset + thisDur;
        end
    end
    lastBeatEnd = thisOnset + thisDur;
    
    if thisOnset >= beatSegEnd || abs(thisOnset - beatSegEnd) < err
        % Save buffer to segmentSet
        segmentSet{segNo} = saveSegBuffer(extraNote, segBuffer);
        
        segNo = segNo + 1;
        beatSegEnd = beatSegEnd + beatPerSeg;
        
        % Clear buffer and extra note
        segBuffer = initSegBuffer(32, segNo);
        extraNote = initSegBuffer(32, 0);
    end
    
    % If note duration out of bound, add extra note for next iteration
    if thisOnset + thisDur > beatSegEnd
        extraDur = thisDur - (beatSegEnd - thisOnset);
        [extraDur extraIsExistRndErr] = roundBeat(extraDur);
        if abs(extraDur) > err
            extraNote = incSegBuffer(extraNote, cntNote, beatSegEnd, ...
                extraDur, noteMat(cntNote, 4), 1, 0, extraIsExistRndErr);
            disp('Note duration out of bound');
            thisIsHasArc = 1;
        else
            thisIsHasArc = 0;
        end
    else
        thisIsHasArc = 0;
    end
    
    % Push note into buffer
    segBuffer = incSegBuffer(segBuffer, cntNote, thisOnset, ...
        thisDur, noteMat(cntNote, 4), ...
        thisIsHasArc, 0, durIsExistRndErr(cntNote));
end



% Save buffer to segment
segmentSet{segNo} = saveSegBuffer(extraNote, segBuffer);

nullNum = 0;
for cntSeg = segNum: -1: 1
    if getLength(segmentSet{cntSeg}, 1) == 0
        nullNum = nullNum + 1;
    end
end
newSegmentSet = cell(segNum - nullNum, 1);
for cntSeg = 1: 1: segNum - nullNum
    newSegmentSet{cntSeg} = segmentSet{cntSeg};
end
segmentSet = newSegmentSet;