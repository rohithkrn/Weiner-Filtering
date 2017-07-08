%% 
clc
clear variables;
load('fireworks.mat')
[a,b] = size(blurry_fireworks);
figure,imagesc(blurry_fireworks); colormap 'gray';title 'Blurred Image';

%% choose sub image
sub_im = blurry_fireworks(330:450,164:263);
[a,b] = size(sub_im);
figure,imagesc(sub_im); colormap 'gray';title 'Blurred Sub-Image';


%% compute correlation
ref11 = rgb2gray(imread('ref_image2.jpg'));
ref1 = ref11(1:a,220:220+b-1);
figure, imagesc(ref1); colormap 'gray'; title 'Reference image';
ref1 = im2double(imresize(ref1,[a,b]));
FT_ref1 = fft2(ref1);
Sv = (FT_ref1.*conj(FT_ref1))/(a*b);
figure, imagesc(ref11); colormap 'gray'; title 'Reference image';
%% design blur function
% est_g = blurry_fireworks(128:132,128:132);
est_g = blurry_fireworks(173:176,88:92);
g = zero_pad(est_g,a,b);
G = fft2(g);
%% Weiner filtering for sub image
sigma = 50;
Wf = (conj(G).*Sv)./(((G.*conj(G)).*Sv)+ sigma^2);

FT_sbf = fft2(sub_im);

WfO = (FT_sbf.*Wf);
filtered_sub_im = real(ifft2(WfO));
figure,subplot(1,2,1);imagesc(sub_im); colormap 'gray';title 'Blurred Sub-Image'
subplot(1,2,2);imagesc(filtered_sub_im); colormap 'gray'; title 'Filtered image';

%% Weiner filtering for entire image
% sigma = 100;
% Wf = (conj(G).*Sv)./(((G.*conj(G)).*Sv)+ sigma^2);
% 
% %FT_bf = fft2(blurry_fireworks);
% 
% WfO = (FT_bf.*Wf);
% filtered_fireworks = real(ifft2(WfO));
% figure,subplot(1,2,1);imagesc(blurry_fireworks); colormap 'gray';title 'Blurred Image'
% subplot(1,2,2);imagesc(filtered_fireworks); colormap 'gray'; title 'Filtered image';
% 

