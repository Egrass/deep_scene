function [KeypointMap] = KeypointCreation(PartMask,inst_mask,cls_mask)


KeypointMap=zeros(size(cls_mask));

NumberInstaces=0;

%count Numer of instances
for i=1:size(cls_mask,1)
            for j=1:size(cls_mask,2)
                %person
                if(cls_mask(i,j)==15)
                   if NumberInstaces < inst_mask(i,j)
                        NumberInstaces = inst_mask(i,j);
                   end
                end
            end
 end

NumberInstaces;


for Instance=1:NumberInstaces

                %%Head
                for part=1:24
                    N=0;X=0;Y=0;
                    find=0;
                        for i=1:size(cls_mask,1)
                            for j=1:size(cls_mask,2)
                               
                                if((PartMask(i,j)==part) && (inst_mask(i,j) == Instance))
                                    X=X+i; Y=Y+j;
                                    N=N+1;
                                    find=1;
                                end
                            end
                        end
                    posx=round(X/N);
                    posy=round(Y/N);

                    %draw keypoint
                        for ii=-2:2
                            for jj=-2:2
                                if(((ii>=1 && ii<=size(PartMask,1))) && ((jj>=1 && jj<=size(PartMask,2)))) 
                                        %head
                                        if((part==1 && find ==1))
                                            PartMask(posx+ii,posy+jj)=1;
                                            KeypointMap(posx+ii,posy+jj)=1;
                                        end
                                        %torso
                                        if((part==2 && find ==1))
                                            PartMask(posx+ii,posy+jj)=2;
                                            KeypointMap(posx+ii,posy+jj)=2;
                                        end
                                        %hands
                                        if((part==15 || part ==18) && find ==1)
                                            PartMask(posx+ii,posy+jj)=3;
                                            KeypointMap(posx+ii,posy+jj)=3;
                                        end
                                        %lower arms
                                         if((part==13 || part ==16) && find ==1)
                                            PartMask(posx+ii,posy+jj)=4;
                                            KeypointMap(posx+ii,posy+jj)=4;
                                         end
                                         %upper arms 
                                         if((part==14 || part ==17) && find ==1)
                                            PartMask(posx+ii,posy+jj)=5;
                                            KeypointMap(posx+ii,posy+jj)=5;
                                         end
                                         %legs
                                         if((part==19 || part ==20 || part==22 || part ==23 ) && find ==1)
                                            PartMask(posx+ii,posy+jj)=6;
                                            KeypointMap(posx+ii,posy+jj)=6;
                                         end
                                         %feet
                                         if((part==21 || part == 24) && find ==1)
                                            PartMask(posx+ii,posy+jj)=7;
                                            KeypointMap(posx+ii,posy+jj)=7;
                                         end
                                end
                            end
                        end
                end    

end