function PartMAsk = Mask2RGB(part_mask)

%Function that fuse Masks 
% Make super class HEAD


PartMAsk=zeros(size(part_mask,1),size(part_mask,2),3);
PartMAsk = uint8(PartMAsk);


for i=1:size(part_mask,1)
    for j=1:size(part_mask,2)
         % ROAD 
          if(part_mask(i,j)==1)
              PartMAsk(i,j,1)=170;
              PartMAsk(i,j,2)=170;
              PartMAsk(i,j,3)=170;
          end
          % Grass 
          if(part_mask(i,j)==2)
              PartMAsk(i,j,1)=0;
              PartMAsk(i,j,2)=255;
              PartMAsk(i,j,3)=0;
          end
          % VEG 
          if(part_mask(i,j)==3)
              PartMAsk(i,j,1)=102;
              PartMAsk(i,j,2)=102;
              PartMAsk(i,j,3)=51;
          end
          % SKY 
          if(part_mask(i,j)==4)
              PartMAsk(i,j,1)=0;
              PartMAsk(i,j,2)=120;
              PartMAsk(i,j,3)=255;
          end
          % Tree 
          if(part_mask(i,j)==5)
              PartMAsk(i,j,1)=0;
              PartMAsk(i,j,2)=60;
              PartMAsk(i,j,3)=0;
          end
          % Nothing 
          if(part_mask(i,j)==6)
              PartMAsk(i,j,1)=0;
              PartMAsk(i,j,2)=0;
              PartMAsk(i,j,3)=0;
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
