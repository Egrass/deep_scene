function  im = Medianfilter(im,m,n)
%Medianfilter - Gabriel Oliveira march 2016
%   Input is img and dimensions filter.

Imm=zeros(size(im,1)+2*m,size(im,2)+2*n);
kernel=zeros(m,n);
Imm(m+1:size(im,1)+m,n+1:size(im,2)+n)=im;

%imagesc(Imm)

for i=m:1:(size(im,1)+m)
   for j=n:1:(size(im,2))
            % i
            % j
            % m
            % n
            % size(im,1)
            % size(im,2)
            % (size(im,1)+m)
            % (size(im,2)+n)
            % size(Imm)
        kernel=Imm(i-floor(m/2):i+floor(m/2), j-floor(n/2):j+floor(n/2));
        kernel=reshape(kernel,(m*n),1);
        sortKernel = sort(kernel);
        if(Imm(i,j)==0)
           M = median(sortKernel);
           im(i-(m-1),j-(n-1))=M;
        end
   end
end



end

