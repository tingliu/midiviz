function segBuffer = initSegBuffer (maxBufferSize, segNo)

segBuffer.segNo = segNo;
segBuffer.noteNum = 0;
segBuffer.noteNo = zeros(maxBufferSize, 1);
segBuffer.onset = zeros(maxBufferSize, 1);
segBuffer.dur = zeros(maxBufferSize, 1);
segBuffer.pitch = zeros(maxBufferSize, 1);
segBuffer.isHasArc = zeros(maxBufferSize, 1);
segBuffer.isRest = zeros(maxBufferSize, 1);
segBuffer.isExistRndErr = zeros(maxBufferSize, 1);