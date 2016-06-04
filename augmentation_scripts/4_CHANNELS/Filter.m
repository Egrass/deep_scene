


function output = Filter(input)

%Function that fuse Masks 
% Make super class HEAD


output=input;

%PartMAsk=zeros(size(part_mask,1),size(part_mask,2));
%PartMAsk = single(PartMAsk);

K=0;


while sum(input(:)==0)>0
    
        
        for i=1:size(input,1)
            for j=1:size(input,2)
                 index=1; 
                 K=0;
                 for z=-1:1:1
                    for t=-1:1:1 
                      if((i+z>=1 && i+z<=size(input,1)) && (j+t>=1 && j+t<=size(input,2)) && input(i+z,j+t)~=0)
                         K(index)=input(i+z,j+t);        
                         index=index+1; 
                      end
                      %index
                    end
                 end

                 if (output(i,j)==0) 
                      P=mode(K);     
                      output(i,j)=P;
                 end    


            end
        end
        
        
 input=output;
      
 sum(input(:)==0)
  
end





end