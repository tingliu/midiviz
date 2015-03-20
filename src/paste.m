% if center == -1, im and imt have the same size and overlap
function im = paste (im, imt, center)

[m n] = size(im);
[mt nt] = size(imt);

if center == -1
    di = 0;
    dj = 0;
else
    di = center(1) - floor((mt - 1) / 2) - 1;
    dj = center(2) - floor((nt - 1) / 2) - 1;
end

for it = 1: 1: mt
    for jt = 1: 1: nt
        if imt(it, jt) ~= 255
            i = it + di;
            j = jt + dj;
            if i > 0 && i <= m && j > 0 && j <= n
                im(i, j) = imt(it, jt);
            end
        end
    end
end