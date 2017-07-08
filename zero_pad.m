function zp = zero_pad(input, num_rows, num_columns)
% Zero-pad the input image to the specified size and shift the result
% so that convolution with fft2 doesn't introduce a phase shift

zp = zeros(num_rows,num_columns);

% Zero-pad
s1 = size(input,1);
s2 = size(input,2);
zp(1:s1,1:s2) = input;

% Shift
if mod(s1,2)==0
    zp = [zp(s1/2:end,:); zp(1:s1/2-1,:)];
else
    zp = [zp((s1+1)/2:end,:); zp(1:(s1+1)/2-1,:)];
end

if mod(s2,2)==0
    zp = [zp(:,s2/2:end), zp(:,1:s2/2-1)];
else
    zp = [zp(:,(s2+1)/2:end), zp(:,1:(s2+1)/2-1)];
end

