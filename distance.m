function dist=distance(x1,x2,y1,y2)
distDelta2ofX=(cos(41.0385*pi/180)*111); %boylam uzunluk km long
distDelta2ofY=(111); %enlem uzunluk km
dist=sqrt((distDelta2ofX*(x1-x2)).^2 + (distDelta2ofY*(y1-y2)).^2);
end