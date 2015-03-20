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
function noteTemplate = getNoteTemplate (subNoteInfo, ...
    forceTail, forceQuarter)

global halfdist;

noteTemplate = initNoteTemplate(subNoteInfo, forceTail);

if noteTemplate.feat.rest ~= 1
    pitch = round(subNoteInfo.pitch);
    switch pitch
        case 54 % bsol-
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 6;
                noteTemplate.feat.ledger = -4;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 12;
                noteTemplate.feat.ledger = 4;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 2;
        case 55 % sol-
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 6;
                noteTemplate.feat.ledger = -4;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 12;
                noteTemplate.feat.ledger = 4;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 56 % #sol-
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 6;
                noteTemplate.feat.ledger = -4;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 12;
                noteTemplate.feat.ledger = 4;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 57 % la-
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 5;
                noteTemplate.feat.ledger = -3;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 11;
                noteTemplate.feat.ledger = 3;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 58 % #la-
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 5;
                noteTemplate.feat.ledger = -3;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 11;
                noteTemplate.feat.ledger = 3;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 59 % si-
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 4;
                noteTemplate.feat.ledger = -2;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 10;
                noteTemplate.feat.ledger = 2;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 60 % do
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 3;
                noteTemplate.feat.ledger = -1;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 9;
                noteTemplate.feat.ledger = 1;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 61 % #do
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 3;
                noteTemplate.feat.ledger = -1;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 9;
                noteTemplate.feat.ledger = 1;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 62 % re
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 8;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 63 % #re
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 8;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 64 % mi
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 7;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 65 % fa
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 0;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 6;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 66 % #fa
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = 0;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 6;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 67 % sol
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = -1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 5;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 68 % #sol
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = -1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 5;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 69 % la
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = -2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 4;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 70 % #la
            if forceTail == 1 || forceTail == 0
                noteTemplate.verticalMove = -2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2
                noteTemplate.verticalMove = 4;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 71 % si
            if forceTail == 1
                noteTemplate.verticalMove = -3;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = 3;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 72 % do+
            if forceTail == 1
                noteTemplate.verticalMove = -4;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = 2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 73 % #do+
            if forceTail == 1
                noteTemplate.verticalMove = -4;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = 2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 74 % re+
            if forceTail == 1
                noteTemplate.verticalMove = -5;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = 1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 75 % #re+
            if forceTail == 1
                noteTemplate.verticalMove = -5;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = 1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 76 % mi+
            if forceTail == 1
                noteTemplate.verticalMove = -6;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = 0;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 77 % fa+
            if forceTail == 1
                noteTemplate.verticalMove = -7;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 78 % #fa+
            if forceTail == 1
                noteTemplate.verticalMove = -7;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -1;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 79 % sol+
            if forceTail == 1
                noteTemplate.verticalMove = -8;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 80 % #sol+
            if forceTail == 1
                noteTemplate.verticalMove = -8;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -2;
                noteTemplate.feat.ledger = 0;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 81 % la+
            if forceTail == 1
                noteTemplate.verticalMove = -9;
                noteTemplate.feat.ledger = -1;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -3;
                noteTemplate.feat.ledger = 1;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 82 % #la+
            if forceTail == 1
                noteTemplate.verticalMove = -9;
                noteTemplate.feat.ledger = -1;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -3;
                noteTemplate.feat.ledger = 1;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 83 % si+
            if forceTail == 1
                noteTemplate.verticalMove = -10;
                noteTemplate.feat.ledger = -2;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -4;
                noteTemplate.feat.ledger = 2;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 84 % do++
            if forceTail == 1
                noteTemplate.verticalMove = -11;
                noteTemplate.feat.ledger = -3;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -5;
                noteTemplate.feat.ledger = 3;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 85 % #do++
            if forceTail == 1
                noteTemplate.verticalMove = -11;
                noteTemplate.feat.ledger = -3;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -5;
                noteTemplate.feat.ledger = 3;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        case 86 % re++
            if forceTail == 1
                noteTemplate.verticalMove = -12;
                noteTemplate.feat.ledger = -4;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -6;
                noteTemplate.feat.ledger = 4;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 0;
        case 87 % #re++
            if forceTail == 1
                noteTemplate.verticalMove = -12;
                noteTemplate.feat.ledger = -4;
                noteTemplate.feat.tail = 0;
            elseif forceTail == 2 || forceTail == 0
                noteTemplate.verticalMove = -6;
                noteTemplate.feat.ledger = 4;
                noteTemplate.feat.tail = 1;
            end
            noteTemplate.feat.accidental = 1;
        otherwise % Unsupported notes
            disp(['No pitch matching for ' num2str(pitch)]);
    end
end

noteTemplate.verticalMove = noteTemplate.verticalMove * halfdist;
noteTemplate.image = synNoteImage(noteTemplate.feat, forceQuarter);