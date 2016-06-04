function [PartMAsk, isperson] = fuse_masks_5(cls_mask,part_mask)

%Function that fuse Masks 
% Make super class HEAD

%Person is false 
isperson = 0;

PartMAsk=zeros(size(cls_mask));

for i=1:size(cls_mask,1)
    for j=1:size(cls_mask,2)
        if(cls_mask(i,j)==15)
            %There is a person 
            isperson=1;
            %head super class
           if(part_mask(i,j)>=1 && part_mask(i,j)<=10)
               PartMAsk(i,j)=1; 
           end
            %torso super class
           if(part_mask(i,j)>=11 && part_mask(i,j)<=12)
               PartMAsk(i,j)=2; 
           end
            %Left lower arm
           if(part_mask(i,j)==13)
               PartMAsk(i,j)=3; 
           end
            %Left upper arm
           if(part_mask(i,j)==14)
               PartMAsk(i,j)=3; 
           end
            %Left hand
           if(part_mask(i,j)==15)
               PartMAsk(i,j)=3; 
           end
            %Right lower arm
           if(part_mask(i,j)==16)
               PartMAsk(i,j)=3; 
           end
            %Right upper arm
           if(part_mask(i,j)==17)
               PartMAsk(i,j)=3; 
           end
            %Right hand
           if(part_mask(i,j)==18)
               PartMAsk(i,j)=3; 
           end
            %Left lower leg
           if(part_mask(i,j)==19)
               PartMAsk(i,j)=4; 
           end
            %Left upper leg
           if(part_mask(i,j)==20)
               PartMAsk(i,j)=4; 
           end
            %Left feet
           if(part_mask(i,j)==21)
               PartMAsk(i,j)=4; 
           end
            %Right lower leg
           if(part_mask(i,j)==22)
               PartMAsk(i,j)=4; 
           end
            %Right upper leg
           if(part_mask(i,j)==23)
               PartMAsk(i,j)=4; 
           end
            %Right feet
           if(part_mask(i,j)==24)
               PartMAsk(i,j)=4; 
           end
        end
    end
end



end

