% ------------------------------------------------------------------------
function images = CROP_LABEL(im)
% ------------------------------------------------------------------------
IMAGE_DIM = 350;
CROPPED_DIM = 300;

%d = load(mean_file);
%IMAGE_MEAN = mean_file;

% resize to fixed input size
im = single(im);
im = imresize(im, [IMAGE_DIM IMAGE_DIM], 'nearest');
% permute from RGB to BGR (IMAGE_MEAN is already BGR)
size(im);
% mean BGR pixel subtraction
%for c = 1:3
%    im(:, :, c) = im(:, :, c) - IMAGE_MEAN(c);
%end
%im = im(:,:,[3 2 1]) - IMAGE_MEAN;

%DISABLE THE Horizontal Flipping is bad for my LEFT, RIGHT leg dataset
%images = zeros(CROPPED_DIM, CROPPED_DIM, 1, 12, 'single');
% oversample (4 corners, center, and their x-axis flips)
images = zeros(CROPPED_DIM, CROPPED_DIM, 1, 11, 'single');
indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
curr = 1;
for i = indices
  for j = indices
    images(:, :, :, curr) = permute(im(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :), [2 1 3]);
    images(:, :, :, curr+5) = images(end:-1:1, :, :, curr);
    curr = curr + 1;
  end
end
center = floor(indices(2) / 2)+1;
images(:,:,:,5) = permute(im(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:), [2 1 3]);
images(:,:,:,10) = images(end:-1:1, :, :, curr);


im = imresize(im, [CROPPED_DIM CROPPED_DIM], 'nearest');
images(:,:,:,11) = permute(im, [2 1 3]);


%DISABLED
%I2 = flipdim(im ,2);           %# horizontal flip
%images(:,:,:,12) = permute(I2, [2 1 3]);


end