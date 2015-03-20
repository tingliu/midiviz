function beatTab = genBeatTab ()

beatOfOneNote = 4;
beatTab = zeros(10, 1);
divi = 1;
for cnt = 1: 2: 9
    beatTab(cnt + 1) = beatOfOneNote / divi;
    beatTab(cnt) = beatTab(cnt + 1) * 1.5;
    divi = divi * 2;
end