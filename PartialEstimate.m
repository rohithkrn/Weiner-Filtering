clc
close all
clear all

load('GPfiles.mat');

n = 50;
U = vals';
l_U = locs';
l_U = l_U/n;
l_total = zeros(n^2,2);

for i = 1:50^2
    l_total(i,1) = ceil(i/n);
    l_total(i,2) = rem(i-1,n)+1;
end

l_total = l_total/n;
l_V = setdiff(l_total, l_U, 'rows');

l = 0.01;

Cu = zeros(size(l_U,1),size(l_U,1));

for i = 1:size(l_U,1)
    for j = 1:size(l_U,1)
        delx = l_U(i,:)-l_U(j,:);
        Cu(i,j) = exp(-((delx*delx')/(2*l^2)));
    end
end

Cui = inv(Cu);

Cvu = zeros(size(l_V,1),size(l_U,1));
for i = 1:size(l_V,1)
    for j = 1:size(l_U,1)
        delx = l_V(i,:)-l_U(j,:);
        Cvu(i,j) = exp(-((delx*delx')/(2*l^2)));
    end
end

xhat = Cvu*Cui*U;

A = zeros(50,50);
l_U=ceil(50*l_U);
l_V=ceil(50*l_V);
for i=1:1500
    A(l_U(i,1),l_U(i,2)) = U(i);
end

for i=1:1000
    A(l_V(i,1),l_V(i,2)) = xhat(i);
end
imagesc(A); colormap gray;title 'l = 0.01'