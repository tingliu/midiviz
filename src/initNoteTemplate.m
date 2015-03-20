function noteTemplate = initNoteTemplate (subNoteInfo, forceTail)

noteTemplate.verticalMove = 0;
noteTemplate.feat.dur = subNoteInfo.dur;
noteTemplate.feat.ledger = 0;
noteTemplate.feat.accidental = 0;

if forceTail == 2
    noteTemplate.feat.tail = 1;
else
    noteTemplate.feat.tail = 0;
end

noteTemplate.feat.rest = subNoteInfo.isRest;
noteTemplate.image = [];