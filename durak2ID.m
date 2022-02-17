function IdCol=durak2ID(DurakCol)
[Column1, SDURAKKODU]=importfileID_DURAKKODU();
IdCol=zeros(size(DurakCol));
for i=1:size(DurakCol,1)
r=find(SDURAKKODU==DurakCol(i));
if(~isempty(Column1(r,1)))
IdCol(i,1)=Column1(r,1);
else
 IdCol(i,1)=-1;
end
end
end