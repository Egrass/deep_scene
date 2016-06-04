% Inputs: Input Image (var: inputImage), Scale Change level (var:
% scaleLevel) Valid values for scale change should go from 0.1 to 1
% Outputs: Vignetting effect added image (var: vignettImg, Time taken (var: timeTaken)
% Example  [vignettImg, timeTaken]=funcVignettingEffect('Baby1LeftColor.png', 0.5);
% *************************************************************************
function [vignettImg]=funcVignettingEffect(inputImage,scaleLevel)
% Read the input image
    % Read an image using imread function
    %inputImage=imread(inputImage);
    % grab the number of rows, columns, and channels
    [nr, nc, nChannels]=size(inputImage);
    if(nChannels==1)
      colored=0;
    else
      colored=1;  
    end
   
    
if scaleLevel <= 0
    error('Scale value must be > 0');
end
vignettImg=inputImage;
tic; % Initialize the timer to calculate the time consumed.
imgCntX = nc/2;
imgCntY = nr/2;
maxDistance = sqrt (imgCntY^2 + imgCntX^2);
if(colored==1)
    for (i=1:nr)
        for (j=1:nc)
           dis = sqrt (abs(i-imgCntY)^2 + abs(j-imgCntX)^2);          
           %% reduce brighness of pixel based on distance from the image center
           vignettImg(i,j,1) = vignettImg(i,j,1)* (1 - (1-scaleLevel)*(dis/maxDistance) );
           vignettImg(i,j,2) = vignettImg(i,j,2)* (1 - (1-scaleLevel)*(dis/maxDistance) );
           vignettImg(i,j,3) = vignettImg(i,j,3)* (1 - (1-scaleLevel)*(dis/maxDistance) );
       end
    end
else
%gray
     for (i=1:nr)
        for (j=1:nc)
           dis = sqrt (abs(i-imgCntY)^2 + abs(j-imgCntX)^2);          
           %% reduce brighness of pixel based on distance from the image center
           vignettImg(i,j) = vignettImg(i,j)* (1 - (1-scaleLevel)*(dis/maxDistance) );
       end
    end
end
% Stop the timer to calculate the time consumed.
timeTaken=toc;