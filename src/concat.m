function im = concat (im1, im2)

[m1 n1] = size(im1);
[m2 n2] = size(im2);
m = max(m1, m2);
n = n1 + n2;
im = 255 * ones(m, n);
im(1: 1: m1, 1: 1: n1) = im1;
im(1: 1: m2, n1 + 1: 1: n) = im2;