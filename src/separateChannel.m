function noteMatSet = separateChannel (noteMat)

channelNum = 0;
channel = [];

noteNum = getLength(noteMat, 1);

for cntNote = 1: 1: noteNum
    isChannelExist = 0;
    for cntChannel = 1: 1: channelNum
        if noteMat(cntNote, 3) == channel(cntChannel, 1)
            channel(cntChannel, 2) = channel(cntChannel, 2) + 1;
            isChannelExist = 1;
        end
    end
    if isChannelExist == 0
        channel = [channel; [noteMat(cntNote, 3) 1]];
        channelNum = channelNum + 1;
    end
end

[channel(:, 1) index] = sort(channel(:, 1));
channel(:, 2) = channel(index, 2);

noteMatSet = cell(channelNum, 1);
for cntChannel = 1: 1: channelNum
    noteMatSet{cntChannel}.channelNo = channel(cntChannel, 1);
    noteMatSet{cntChannel}.noteMat = zeros(channel(cntChannel, 2), 7);
end

channelNoteIndex = zeros(channelNum, 1);
for cntNote = 1: 1: noteNum
    for cntChannel = 1: 1: channelNum
        if noteMatSet{cntChannel}.channelNo == noteMat(cntNote, 3)
            channelNoteIndex(cntChannel) = channelNoteIndex(cntChannel) + 1;
            noteMatSet{cntChannel}.noteMat(channelNoteIndex(cntChannel), :) = ...
                noteMat(cntNote, :);
        end
    end
end