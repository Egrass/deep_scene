function[imf] = DCTIFlp(IM1,IM2,k)
% LP DCT based image fusion
% IM1 & IM2 are the images to be fused
for i=1:k
    IM = reduce2d(IM1);
    %size(IM1)
    %size(expand2d(IM))
    Id1 = IM1 - expand2d(IM);
    IM1 = IM;
    IM = reduce2d(IM2);
    Id2 = IM2 - expand2d(IM);
    IM2 = IM;
    dl = abs(Id1)-abs(Id2)>=0;
    Idf{i} = dl.*Id1+(~dl).*Id2;
end
imf = 0.5*(IM1+IM2);

for i=k:-1:1
    imf = Idf{i} + expand2d(imf);
end

%======================================================
function[Ie] = expand2d(I)
mn = size(I)*2;
IDCT = dct2(I);
Ie = idct2(IDCT,[mn(1) mn(2)]);

%=====================================================
function[Id] = reduce2d(I)
mn = size(I)/2;
IDCT = dct2(I);
Id = round(idct2(IDCT(1:mn(1),1:mn(2))));