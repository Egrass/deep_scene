    

function PartMAsk = RGB2Mask(part_mask)

%Function that fuse Masks 
% Make super class HEAD


PartMAsk=zeros(size(part_mask,1),size(part_mask,2));
PartMAsk = single(PartMAsk);


for i=1:size(part_mask,1)
    for j=1:size(part_mask,2)
         % ROAD 
          if((part_mask(i,j,1)==170) && (part_mask(i,j,2)==170) && (part_mask(i,j,3)==170))
               PartMAsk(i,j)=1; 
          end
          % Grass 
          if((part_mask(i,j,1)==0) && (part_mask(i,j,2)==255) && (part_mask(i,j,3)==0))
               PartMAsk(i,j)=2; 
          end
          % VEG 
          if((part_mask(i,j,1)==102) && (part_mask(i,j,2)==102) && (part_mask(i,j,3)>=50 && part_mask(i,j,3)<=52))
               PartMAsk(i,j)=3; 
          end
          % SKY 
          if((part_mask(i,j,1)==0) && (part_mask(i,j,2)==120) && (part_mask(i,j,3)==255))
               PartMAsk(i,j)=4; 
          end
          % Tree 
          if((part_mask(i,j,1)==0) && (part_mask(i,j,2)==60) && (part_mask(i,j,3)==0))
               PartMAsk(i,j)=3; 
          end
          % Nothing 
          if((part_mask(i,j,1)==0) && (part_mask(i,j,2)==0) && (part_mask(i,j,3)==0))
               PartMAsk(i,j)=5; 
          end
          
          % Sky
          %if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=20) && (part_mask(i,j,2)>=100 && part_mask(i,j,2)<=140) && (part_mask(i,j,3)>=220 && part_mask(i,j,3)<=255))
          %     PartMAsk(i,j)=2; 
          %end  
         %ROAD
         %if((part_mask(i,j,1)>=0 && part_mask(i,j,1)<=20) && (part_mask(i,j,2)>=220 && part_mask(i,j,2)<=255) && (part_mask(i,j,3)>=0 && part_mask(i,j,3)<=20))
         %     PartMAsk(i,j)=3; 
         %end
          
         %BACKGROUND
         %if((part_mask(i,j,1)>=80 && part_mask(i,j,1)<=122) && (part_mask(i,j,2)>=80 && part_mask(i,j,2)<=122) && (part_mask(i,j,3)>=30 && part_mask(i,j,3)<=80))
         %     PartMAsk(i,j)=4; 
         %end
           
         
           
           
        
    end
end








end
