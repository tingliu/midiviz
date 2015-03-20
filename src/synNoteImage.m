function im = synNoteImage (feat, forceQuarter)

global fnroot;
global noteHeight;
global noteWidth;
global halfdist;
global beatTab;

isMatched = 1;
feat.dur = roundBeat(feat.dur);

switch feat.dur
    case beatTab(1) % 3/2
        isPlusDot = 1;
        fn = [fnroot 'whole'];
    case beatTab(2) % 1
        isPlusDot = 0;
        fn = [fnroot 'whole'];
    case beatTab(3) % 3/4
        isPlusDot = 1;
        fn = [fnroot 'half'];
    case beatTab(4) % 1/2
        isPlusDot = 0;
        fn = [fnroot 'half'];
    case beatTab(5) % 3/8
        isPlusDot = 1;
        fn = [fnroot 'quarter'];
    case beatTab(6) % 1/4
        isPlusDot = 0;
        fn = [fnroot 'quarter'];
    case beatTab(7) % 3/16
        isPlusDot = 1;
        fn = [fnroot 'eighth'];
    case beatTab(8) % 1/8
        isPlusDot = 0;
        fn = [fnroot 'eighth'];
    case beatTab(9) % 3/32
        isPlusDot = 1;
        fn = [fnroot 'sixteenth'];
    case beatTab(10)% 1/16
        isPlusDot = 0;
        fn = [fnroot 'sixteenth'];
%     case beatTab(11)% 3/64
%         isPlusDot = 1;
%         fn = [fnroot 'thirtysecond'];
%     case beatTab(12)% 1/32
%         isPlusDot = 0;
%         fn = [fnroot 'thirtysecond'];
    otherwise   % No matching pitch
        isMatched = 0;
        disp(['No matching beat for ' num2str(feat.dur)]);
end

if isMatched == 0
%     im = imread([fnroot 'Gclef.png']);
    im = [];
else
    if feat.rest == 0
        fn = [fn 'note'];
        if forceQuarter == 1
            fn = [fnroot 'quarternote'];
        end
        if feat.tail == 1
            fn = [fn '_rot'];
        end
    else
        fn = [fn 'rest'];
    end

    fn = [fn '.png'];

    im = imread(fn);
    if isPlusDot == 1
        if feat.tail == 1
            imt = imread([fnroot 'dot_rot.png']);
        else
            imt = imread([fnroot 'dot.png']);
        end
        if feat.rest == 1
            ic = floor(noteHeight / 2 - halfdist * 3.5);
            jc = floor(noteWidth / 2);
            im = paste(im, imt, [ic jc]);
        else
            im = paste(im, imt, -1);
        end
    end
    
    if feat.rest == 0
        if feat.accidental == 1
            if feat.tail == 1
                imt = imread([fnroot 'sharp_rot.png']);
            else
                imt = imread([fnroot 'sharp.png']);
            end
            im = paste(im, imt, -1);
        elseif feat.accidental == 2
            if feat.tail == 1
                imt = imread([fnroot 'flat_rot.png']);
            else
                imt = imread([fnroot 'flat.png']);
            end
            im = paste(im, imt, -1);
        end
        
        if feat.ledger ~= 0
            fnledger = [fnroot 'ledger_' num2str(int32(feat.ledger)) '.png'];
            imt = imread(fnledger);
            im = paste(im, imt, -1);
        end
    end
end