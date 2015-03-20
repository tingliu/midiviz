% forceTail: 0 (no); 1 (forced down); 2 (forced up)
% noteTemplate:
%   verticalMove
%   feat:
%       dur
%       ledger
%       accidental
%       tail
%       rest
%   image
function noteTemplate = genNoteTemplate (subNoteInfo, ...
    forceTail, forceQuarter)

global halfdist;

noteTemplate = initNoteTemplate(subNoteInfo, forceTail);

if noteTemplate.feat.rest ~= 1
    pitch = round(subNoteInfo.pitch);
    switch pitch
        case 54 % bsol-
            noteTemplate.verticalMove = halfdist * 6;
            noteTemplate.feat.ledger = 4;
            noteTemplate.feat.accidental = 2;
        case 55 % sol-
            noteTemplate.verticalMove = halfdist * 6;
            noteTemplate.feat.ledger = 4;
        case 56 % #sol-
            noteTemplate.verticalMove = halfdist * 6;
            noteTemplate.feat.ledger = 4;
            noteTemplate.feat.accidental = 1;
        case 57 % la-
            noteTemplate.verticalMove = halfdist * 5;
            noteTemplate.feat.ledger = 3;
        case 58 % #la-
            noteTemplate.verticalMove = halfdist * 5;
            noteTemplate.feat.ledger = 3;
            noteTemplate.feat.accidental = 1;
        case 59 % si-
            noteTemplate.verticalMove = halfdist * 4;
            noteTemplate.feat.ledger = 2;
        case 60 % do
            noteTemplate.verticalMove = halfdist * 3;
            noteTemplate.feat.ledger = 1;
        case 61 % #do
            noteTemplate.verticalMove = halfdist * 3;
            noteTemplate.feat.ledger = 1;
            noteTemplate.feat.accidental = 1;
        case 62 % re
            noteTemplate.verticalMove = halfdist * 2;
        case 63 % #re
            noteTemplate.verticalMove = halfdist * 2;
            noteTemplate.feat.accidental = 1;
        case 64 % mi
            noteTemplate.verticalMove = halfdist;
        case 65 % fa
        
        case 66 % #fa
            noteTemplate.feat.accidental = 1;
        case 67 % sol
            noteTemplate.verticalMove = -halfdist;
        case 68 % #sol
            noteTemplate.verticalMove = -halfdist;
            noteTemplate.feat.accidental = 1;
        case 69 % la
            noteTemplate.verticalMove = -halfdist * 2;
        case 70 % #la
            noteTemplate.verticalMove = -halfdist * 2;
            noteTemplate.feat.accidental = 1;
        case 71 % si
            noteTemplate.verticalMove = -halfdist * 3;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 72 % do+
            noteTemplate.verticalMove = -halfdist * 4;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 73 % #do+
            noteTemplate.verticalMove = -halfdist * 4;
            noteTemplate.feat.accidental = 1;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 74 % re+
            noteTemplate.verticalMove = -halfdist * 5;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 75 % #re+
            noteTemplate.verticalMove = -halfdist * 5;
            noteTemplate.feat.accidental = 1;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 76 % mi+
            noteTemplate.verticalMove = -halfdist * 6;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 77 % fa+
            noteTemplate.verticalMove = -halfdist * 7;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 78 % #fa+
            noteTemplate.verticalMove = -halfdist * 7;
            noteTemplate.feat.accidental = 1;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 79 % sol+
            noteTemplate.verticalMove = -halfdist * 8;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 80 % #sol+
            noteTemplate.verticalMove = -halfdist * 8;
            noteTemplate.feat.accidental = 1;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 81 % la+
            noteTemplate.verticalMove = -halfdist * 9;
            noteTemplate.feat.ledger = 1;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 82 % #la+
            noteTemplate.verticalMove = -halfdist * 9;
            noteTemplate.feat.ledger = 1;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 83 % si+
            noteTemplate.verticalMove = -halfdist * 10;
            noteTemplate.feat.ledger = 2;
            if forceTail == 0
                noteTemplate.feat.tail = 1;
            end
        case 84 % do++
            noteTemplate.verticalMove = -halfdist * 11;
            
        otherwise   % Other unsupported notes are regarded as rest
            noteTemplate.feat.rest = 1;
            noteTemplate.feat.dur = 0;
    end
end

noteTemplate.image = synNoteImage(noteTemplate.feat, forceQuarter);