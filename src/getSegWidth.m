function width = getSegWidth (segment, no)

width = 0;
for cnt = 1: 1: segment{no}.noteNum
    width = width + 1;
end