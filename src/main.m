close all;
clear all;
clc

global fnroot;
global err;
global noteHeight;
global noteWidth;
global halfdist;
global beatPerSeg;
global beatTab;

fnroot = 'image/';
err = 1e-4;
noteHeight = 300;
noteWidth = 100;
halfdist = 12;
beatPerSeg = 3;
beatTab = genBeatTab();

segPerLine = 4;

% noteMat = midi2nmat('laksin.mid');
noteMat = midi2nmat('mid/sarabande.mid');

% noteMat(2, 1) = 2.0;
% noteMat(3, 1) = 2.5;
% noteMat(4, 1) = 2.75;
% noteMat(1, 2) = 1.99;
% noteMat(2, 2) = 0.49;
% noteMat(3, 2) = 0.24;
% noteMat(4, 2) = 0.24;

% noteMat(6, 1) = 3.25;
% noteMat(7, 1) = 3.5;
% noteMat(8, 1) = 3.75;
% noteMat(9, 1) = 6.5;
% noteMat(5, 2) = 0.24;
% noteMat(6, 2) = 0.24;
% noteMat(7, 2) = 0.24;
% noteMat(8, 2) = 0.24;
% noteMat(9, 2) = 0.5;

% noteMat(5, 2) = 0.24;
% noteMat(6, 1) = 3.25;
% noteMat(6, 2) = 0.24;
% noteMat(7, 1) = 3.5;
% noteMat(7, 2) = 0.24;
% noteMat(8, 1) = 3.75;
% noteMat(8, 2) = 0.24;
% noteMat(9, 1) = 9.5;
% noteMat(9, 2) = 0.5;
% noteMat(10: 1: 23, 1) = noteMat(10: 1: 23, 1) + 3;


% noteMatSet = separateChannel(noteMat);
% channelNum = getLength(noteMatSet, 1);
% 
% for cntChannel = 1: 1: channelNum
%     segmentSet = getSegmentSet(noteMatSet{cntChannel}.noteMat, beatPerSeg);
%     segImSet = getSegImageSet(segmentSet, segPerLine);
%     lineImSet = getLineImageSet(segImSet);
%     im = getFinalImage(lineImSet);
%     im = uint8(im);
%     figure, imshow(im);
% end

noteMat = getmidich(noteMat, 1);
% noteMat = onsetwindow(noteMat, 0, 50, 'beat');

segmentSet = getSegmentSet(noteMat, beatPerSeg);
segImSet = getSegImageSet(segmentSet, segPerLine);
lineImSet = getLineImageSet(segImSet);
im = getFinalImage(lineImSet);
im = uint8(im);
figure, imshow(im);
imwrite(im, 'mid/sheet.png');