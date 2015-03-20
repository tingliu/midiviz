function segBuffer = incSegBuffer (segBuffer, noteNo, onset, dur, pitch, ...
    isHasArc, isRest, isExistRndErr)

segBuffer.noteNum = segBuffer.noteNum + 1;
segBuffer.noteNo(segBuffer.noteNum) = noteNo;
segBuffer.onset(segBuffer.noteNum) = onset;
segBuffer.dur(segBuffer.noteNum) = dur;
segBuffer.pitch(segBuffer.noteNum) = pitch;
segBuffer.isHasArc(segBuffer.noteNum) = isHasArc;
segBuffer.isRest(segBuffer.noteNum) = isRest;
segBuffer.isExistRndErr(segBuffer.noteNum) = isExistRndErr;