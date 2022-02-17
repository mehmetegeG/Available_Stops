function newarray=rowarradd(row_array,A)
newarray=A(row_array(1,1):row_array(1,2),:);
r=size(row_array,1)
for i=2:r
q=row_array(i,1):row_array(i,2);
newarray=[newarray;A(q,:)];
end
end