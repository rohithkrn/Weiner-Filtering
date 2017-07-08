%% This script implements the weiner filter equation that denoises the input image 
clc
clear all;

load('Hubble.mat')

[a,b] = size(blurred_galaxy);
g = zero_pad(estimated_g,a,b);
G = fft2(g);
CG = fft2(clean_galaxy);
Sv = (CG.*conj(CG))/(a*b);

bgF = fft2(blurred_galaxy);

sigma = 0.00001^(.5);
Wf = (conj(G).*Sv)./(((G.*conj(G)).*Sv)+ sigma^2);
WfO = (bgF.*Wf);
filtered_galaxy1 = real(ifft2(WfO));
figure,subplot(1,2,1);imagesc(blurred_galaxy); colormap 'gray';title 'Blurred Image'
subplot(1,2,2);imagesc(filtered_galaxy); colormap 'gray'; title 'Filtered image, noise power = 0.0001';

% figure,subplot(1,3,1);imagesc(abs(fftshift(bgF)));title 'blurred';colormap 'gray';
% subplot(1,3,2);imagesc(abs(fftshift(WfO)));title 'filtered';colormap 'gray';
% subplot(1,3,3);imagesc(abs(fftshift(Wf)));title 'WeinFilt';colormap 'gray';

