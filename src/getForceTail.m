function forceTail = getForceTail (pitchSet)

noteNum = getLength(pitchSet, 1);
deltaSet = zeros(noteNum, 1);

pitchSet = round(pitchSet);
for cntNote = 1: 1: noteNum
    switch pitchSet(cntNote)
        case {54, 55, 56} % sol-
            deltaSet(cntNote) = -4.5;
        case {57, 58} % la-
            deltaSet(cntNote) = -4.0;
        case 59 % si-
            deltaSet(cntNote) = -3.5;
        case {60, 61} % do
            deltaSet(cntNote) = -3.0;
        case {62, 63} % re
        	deltaSet(cntNote) = -2.5;
        case 64 % mi
            deltaSet(cntNote) = -2.0;
        case {65, 66} % fa
            deltaSet(cntNote) = -1.5;
        case {67, 68} % sol
            deltaSet(cntNote) = -1.0;
        case {69, 70} % la
            deltaSet(cntNote) = -0.5;
        case 71 % si
            deltaSet(cntNote) = 0.0;
        case {72, 73} % do+
            deltaSet(cntNote) = 0.5;
        case {74, 75} % re+
            deltaSet(cntNote) = 1.0;
        case 76 % mi+
            deltaSet(cntNote) = 1.5;
        case {77, 78} % fa+
            deltaSet(cntNote) = 2.0;
        case {79, 80} % sol+
            deltaSet(cntNote) = 2.5;
        case {81, 82} % la+
            deltaSet(cntNote) = 3.0;
        case 83 % si+
            deltaSet(cntNote) = 3.5;
        case {84, 85} % do++
            deltaSet(cntNote) = 4.0;
        case {86, 87} % re++
            deltaSet(cntNote) = 4.5;
        otherwise   % Other unsupported pitch
            if pitchSet(cntNote) < 59
                deltaSet(cntNote) = -5.0;
            else
                deltaSet(cntNote) = 5.0;
            end
    end
end
s = sum(sum(deltaSet));
if s > 0.0
    forceTail = 2;
else
    forceTail = 1;
end