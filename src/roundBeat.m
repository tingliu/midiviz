% isExistRndErr: 0 (no); 
%                1 (may be next smaller beat);
function [beatOut isExistRndErr] = roundBeat (beatIn)

global err;
global beatTab;

len = getLength(beatIn, 1);
beatOut = zeros(len, 1);
isExistRndErr = zeros(len, 1);
lenTab = getLength(beatTab, 1);

if len == 1
    % Add exception only for beat = 1.25 or 1.75
    % Should be more sophisticated
    if abs(beatIn - 1.25) < err
        beatOut = 1.25;
        isExistRndErr = 0;
    elseif abs(beatIn - 1.75) < err
        beatOut = 1.75;
        isExistRndErr = 0;
    else
        minDiff = 99;
        minJ = 0;
        for j = 1: 1: lenTab
            diff = abs(beatIn - beatTab(j));
            if diff < minDiff && abs(diff - minDiff) > err
                minDiff = diff;
                minJ = j;
            elseif abs(diff - minDiff) < err
                isExistRndErr = 1;
            end
        end
        beatOut = beatTab(minJ);

        % If beatIn(i) is very very small, round to 0
        if beatOut / beatIn > 2
            beatOut = 0;
        end
        return;
    end
end

i = 1;
while i <= len
    % Add exception only for beat = 1.25 or 1.75
    % Should be more sophisticated
    if abs(beatIn(i) - 1.25) < err
        beatOut(i) = 1.25;
        isExistRndErr(i) = 0;
    elseif abs(beatIn(i) - 1.75) < err
        beatOut(i) = 1.75;
        isExistRndErr(i) = 0;
    else
       if beatIn(i) < beatTab(lenTab) / 2
           beatAcc = beatIn(i);
           j = i + 1;
           while j <= len - 2
               beatAcc = beatAcc + beatIn(j);
               if beatAcc > 0.9 && beatAcc < 1.1 ...
                       && beatAcc + beatIn(j + 1) > 1.1
                   break;
               elseif beatAcc > 1.1
                   j = j - 1;
                   break;
               end
               j = j + 1;
           end
           for cnt = i: 1: j - 1
               beatOut(cnt) = 0.0;
           end
           beatOut(j) = 1.0;
           i = j + 1;
           continue;
       else
           minDiff = 99;
           minJ = 0;
           for j = 1: 1: lenTab
               diff = abs(beatIn(i) - beatTab(j));
               if diff < minDiff && abs(diff - minDiff) > err
                   minDiff = diff;
                   minJ = j;
               elseif abs(diff - minDiff) < err % May have rounding error
                   isExistRndErr(i) = 1;
               end
           end
           beatOut(i) = beatTab(minJ);

           % If beatIn(i) is very very small, round to 0
           if beatOut(i) / beatIn(i) > 2
               beatOut(i) = 0;
               disp(['igmore beat ' num2str(i)]);
           end
       end 
    end
    i = i + 1;
end