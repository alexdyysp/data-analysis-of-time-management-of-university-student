figure(3)
hold on
x=ATMD_ENTROPY;y=ROSE_ENTROPY;
case_number=size(ATMD_ENTROPY,1);
for i=1:1:case_number
    if ALL_CLUSTER(i)==1
        plot(y(i),x(i),['.','g'])
    end
     if ALL_CLUSTER(i)==2
        plot(y(i),x(i),['.','r'])
     end
     if ALL_CLUSTER(i)==3
        plot(y(i),x(i),['.','b'])
     end
end