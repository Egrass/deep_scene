function [PartMAsk, isperson] = fuse_Keypoints(cls_mask,part_mask)

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
           if(part_mask(i,j)>=13 && part_mask(i,j)<=24)
               PartMAsk(i,j)=part_mask(i,j);
           end
           %arms super class
           %if(part_mask(i,j)>=13 && part_mask(i,j)<=18)
           %    PartMAsk(i,j)=3; 
           %end
           
            %Legs super class
           %if(part_mask(i,j)>=19 && part_mask(i,j)<=24)
           %    PartMAsk(i,j)=4; 
           %end
        end
    end
end



end

