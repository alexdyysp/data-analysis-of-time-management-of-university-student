function [ mean_matrix ] = meanlize( data ,all_data)
%%mean lize
[sample,question]=size(data);
mean_matrix=zeros(sample,question);
for i=1:1:sample
    for j=1:1:question
        mean_matrix(i,j)=(data(i,j)-min(all_data(:,j)))/(max(all_data(:,j))-min(all_data(:,j)));
    end
end
end

