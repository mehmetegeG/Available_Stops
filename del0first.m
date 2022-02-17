function newarr=del0first(A)
if(class(A)=='string')
    k='0';
else
    k=0;
end
if(A(1,:)==k)
    newarr=A(2:size(A,1),:);
else
    newarr=A;
end
end