    

function PartMAsk = RGB2Mask(part_mask)

%Function that fuse Masks 
% Make super class HEAD


PartMAsk=zeros(size(part_mask,1),size(part_mask,2));
PartMAsk = single(PartMAsk);

result = zeros(3, 14, 1, 'single');

for i=1:size(part_mask,1)
    for j=1:size(part_mask,2)
         %head class
           if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=30) && (part_mask(i,j,2)>=0 && part_mask(i,j,2)<=30) && (part_mask(i,j,3)>=225 && part_mask(i,j,3)<=255))
               PartMAsk(i,j)=1;
               result(1,1) = result(1,1) + i;
               result(2,1) = result(2,1) + j;
               result(3,1) = result(3,1) + 1;
           end
           
           %torso class
           if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=30) && (part_mask(i,j,2)>=225 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=0 && part_mask(i,j,3)<=30))
               PartMAsk(i,j)=2; 
               result(1,2) = result(1,2) + i;
               result(2,2) = result(2,2) + j;
               result(3,2) = result(3,2) + 1;
           end
           
           %Right upper arm
           if((part_mask(i,j,1)>=225 && part_mask(i,j,1)<=255) && (part_mask(i,j,2)>=0 && part_mask(i,j,2)<=30) && (part_mask(i,j,3)>=0 && part_mask(i,j,3)<=30))
               PartMAsk(i,j)=7; 
               result(1,7) = result(1,7) + i;
               result(2,7) = result(2,7) + j;
               result(3,7) = result(3,7) + 1;
           end
           %Right lower arm
           if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=30) && (part_mask(i,j,2)>=225 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=225 && part_mask(i,j,3)<=255))
               PartMAsk(i,j)=6;
               result(1,6) = result(1,6) + i;
               result(2,6) = result(2,6) + j;
               result(3,6) = result(3,6) + 1;
           end
           %Right Hand
           if((part_mask(i,j,1)>=225 && part_mask(i,j,1)<=255) && (part_mask(i,j,2)>=0 && part_mask(i,j,2)<=30) && (part_mask(i,j,3)>=225 && part_mask(i,j,3)<=255))
               PartMAsk(i,j)=8; 
               result(1,8) = result(1,8) + i;
               result(2,8) = result(2,8) + j;
               result(3,8) = result(3,8) + 1;
           end
           
            %Left upper arm
           if((part_mask(i,j,1)>=225 && part_mask(i,j,1)<=255) && (part_mask(i,j,2)>=225 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=0 && part_mask(i,j,3)<=30))
               PartMAsk(i,j)=4;
               result(1,4) = result(1,4) + i;
               result(2,4) = result(2,4) + j;
               result(3,4) = result(3,4) + 1;
           end
           %Left lower arm
           if((part_mask(i,j,1)>=225 && part_mask(i,j,1)<=255) && (part_mask(i,j,2)>=225 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=225 && part_mask(i,j,3)<=255))
               PartMAsk(i,j)=3;
               result(1,3) = result(1,3) + i;
               result(2,3) = result(2,3) + j;
               result(3,3) = result(3,3) + 1;
           end
           %Left Hand
           if((part_mask(i,j,1)>=98 && part_mask(i,j,1)<=158) && (part_mask(i,j,2)>=98 && part_mask(i,j,2)<=158) && (part_mask(i,j,3)>=98 && part_mask(i,j,3)<=158))
               PartMAsk(i,j)=5; 
               result(1,5) = result(1,5) + i;
               result(2,5) = result(2,5) + j;
               result(3,5) = result(3,5) + 1;
           end
           
           
           
           %Right upper leg
           if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=30) && (part_mask(i,j,2)>=98 && part_mask(i,j,2)<=158) && (part_mask(i,j,3)>=225 && part_mask(i,j,3)<=255))
               PartMAsk(i,j)=13; 
               result(1,13) = result(1,13) + i;
               result(2,13) = result(2,13) + j;
               result(3,13) = result(3,13) + 1;
           end
           %Right lower leg
           if((part_mask(i,j,1)>=98 && part_mask(i,j,1)<=158) && (part_mask(i,j,2)>=0 && part_mask(i,j,2)<=30) && (part_mask(i,j,3)>=225 && part_mask(i,j,3)<=255))
               PartMAsk(i,j)=12; 
               result(1,12) = result(1,12) + i;
               result(2,12) = result(2,12) + j;
               result(3,12) = result(3,12) + 1;
           end
           %Right foot
           if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=30) && (part_mask(i,j,2)>=225 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=98 && part_mask(i,j,3)<=158))
               PartMAsk(i,j)=14;
               result(1,14) = result(1,14) + i;
               result(2,14) = result(2,14) + j;
               result(3,14) = result(3,14) + 1;
           end
           
            %Left upper leg
           if((part_mask(i,j,1)>=98 && part_mask(i,j,1)<=158) && (part_mask(i,j,2)>=225 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=0 && part_mask(i,j,3)<=30))
               PartMAsk(i,j)=10;
               result(1,10) = result(1,10) + i;
               result(2,10) = result(2,10) + j;
               result(3,10) = result(3,10) + 1;
           end
           %Left lower leg
           if((part_mask(i,j,1)>=225 && part_mask(i,j,1)<=255) && (part_mask(i,j,2)>=0 && part_mask(i,j,2)<=30) && (part_mask(i,j,3)>=98 && part_mask(i,j,3)<=158))
               PartMAsk(i,j)=9;
               result(1,9) = result(1,9) + i;
               result(2,9) = result(2,9) + j;
               result(3,9) = result(3,9) + 1;
           end
           %Left foot
           if((part_mask(i,j,1)>=225 && part_mask(i,j,1)<=255) && (part_mask(i,j,2)>=98 && part_mask(i,j,2)<=158) && (part_mask(i,j,3)>=0 && part_mask(i,j,3)<=30))
               PartMAsk(i,j)=11;
               result(1,11) = result(1,11) + i;
               result(2,11) = result(2,11) + j;
               result(3,11) = result(3,11) + 1;
           end
           
           
        
    end
end

center = zeros(2,14);

for i = 1:14    
    center(1,i) = result(1,i)/result(3,i);
    center(2,i) = result(2,i)/result(3,i);
end

for i=1:size(part_mask,1)
    for j=1:size(part_mask,2)
        n = PartMAsk(i,j);
        switch n
            case 2
                if(abs(i-center(1,2)) > 80 || abs(j-center(2,2)) > 80)
                    PartMAsk(i,j) = 0;
                end
            case 14
                if(abs(i-center(1,14)) > 40 || abs(j-center(2,14)) > 40)
                    PartMAsk(i,j) = 0;
                end
        end
        if(n~=0)
            if(abs(i-center(1,n)) > 65 || abs(j-center(2,n)) > 60)
                PartMAsk(i,j) = 0;
            end
        end
    end
end






end
