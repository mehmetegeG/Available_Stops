function [maximum,minimum]= geographicalInterval(geoVal,t,type)
speed=0.0613;
londelta=cos(41.0385*pi/180)*111;
latdelta=111;
if type=="lon" ||type=="boylam"
maximum=geoVal + (t*speed)/londelta;
minimum=geoVal - (t*speed)/londelta;
elseif type=="lat"||type =="enlem"
maximum=geoVal + (t*speed)/latdelta;
minimum=geoVal - (t*speed)/latdelta;    
else
    maximum=-1;minimum=-1;
end


end