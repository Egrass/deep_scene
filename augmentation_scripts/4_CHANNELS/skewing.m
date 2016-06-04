
function T=skewing(f,shx,shy)

[r,c,d]=size(f);
%shx=rand*0.2;
%shy=rand*0.2;

for i=1:r
    for j=1:c
        for z=1:d
            x=i+shx*j;
            y=j+shy*i;
            T(round(x),round(y),z)=f(i,j,z);
        end
    end
end

%if(d==1)
%    imagesc(f), figure, imagesc(T);
%else
%   imshow(f), figure, imshow(T);
%end
