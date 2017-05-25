function [ CLUSTER , C ] = Kmeans( CASE_DATA )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
CASE_size=size(CASE_DATA);
k=3;    %cluster
iteration=10000000;
distance='sqEuclidean';
%deal data by kmean
X=zscore(CASE_DATA);
opts=statset('MaxIter',iteration);
[IDX,C]=kmeans(X,k,'distance',distance,'Options',opts);
%get result
CLUSTER=IDX;

end

