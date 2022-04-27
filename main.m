%main program for the project
[Hatlar,SeferSureleri]= importHatlarinSeferSuresi("C:\Users\Ege\Desktop\MATLAB DERS\HatSüre.csv");
[HATKODU, YON, SIRANO, DURAKKODU, XKOORDINATI, YKOORDINATI] = importLines_StopCodes_Order_Coordinates_();
[DURAKID,X,Y]=importLocationsOfStops();
uniLINE=unique([HATKODU,YON],'rows');
% [r c]=size(HATKODU)
% HATLAR=unique(HATKODU)
% HATLAR=unique(HATLAR)
A=zeros(size(uniLINE,1),1);A=A-1;
for i=1:size(Hatlar,1)
   k=Hatlar(i)
   r1=find(uniLINE(:,1)==k)
   if(~isempty(r1))
   A(r1)=SeferSureleri(i,1);
   end
end
DistanceVector=[0]

for i=1:(size(XKOORDINATI,1)-1)
    if(SIRANO(i,1)==(SIRANO(i+1,1)-1))
       DistanceVector=[DistanceVector;distance(XKOORDINATI(i,1),XKOORDINATI(i+1,1),YKOORDINATI(i,1),YKOORDINATI(i+1,1))];
    else DistanceVector=[DistanceVector;0];

    end
end
DistanceVector=del0first([DistanceVector;0]);
 rowsErrorofA=find(A==-1);
a=1
arr=0
 for i=1:length(rowsErrorofA)
     arr=[arr,a:(rowsErrorofA(i,1)-1)];
     a=rowsErrorofA(i,1)+1;
     %rowsError =e1,e2,e3,e4... en arr= 1:e1-1,e1+1:e2-1,e2+1:e3-1 ....en-1+1:en -1  
 end
arr=del0first(arr');
Duraklarin_Sonu=find(DistanceVector==0);%durak sonlarında 0 olduğundan tüm hatlardaki bitişi r2 ye aktarma
locationsOfLines=[[1;Duraklarin_Sonu(1:1878)+1],Duraklarin_Sonu] ;%r2 durak sonu olduğundan r2+1 bir sonraki hatların başlangıcı böylece tüm hatların tAM LOKASYONLARINI kaydetmiş oldum
%r3=find(locationsOfLines(:,1)<=locationsOfLines(:,2))
%check for round trips -> q with errors to check -> !time=fdist ->
    %Total time div by total length of line(Ddist) Ddist*LengthBtw = time
    %weight of node :: apply (strech) Sefer süresi to 1548
StrechedTimeArr  =zeros(size(A,1),1);
StrechedTimeArr =StrechedTimeArr -1;
    %insertIndex=1;
    
% %  for i=1:size(SeferSureleri,1)
% %      theLabel=AlabelforHAT(i);
% %      %LofVL1 every distinct 
% %      rLabel=find(      ;%rows which val eq 2 the label
% %      StrechedTimeArr(rLabel')=SEFER_SURESI(i);
% %  end
% 
% % x= unique(hatTekrarlari(locationsof_VALID_lines(:,2),1));
% % y=[[zeros(806-796,1);x],unique(AlabelforHAT)]

locationsof_VALID_lines=locationsOfLines(arr(:,1),:); %%geçerli hatların sınırlarının olduğu matrix
namesof_VALID_lines=uniLINE(arr,:);%%geçerli hatların isimleri
DistanceVector_Validated=rowarradd(locationsof_VALID_lines,DistanceVector);%array of valid Distances 
SeferSureleri_VALID=A(arr,:);%% üstteki array için karşılık gelen toplam süre
%%disp(table(namesof_VALID_lines,locationsof_VALID_lines));
numberof_VALIDATED=locationsof_VALID_lines(:,2)-locationsof_VALID_lines(:,1)+1;
locationsof_VALIDATED(1,:)=[1,numberof_VALIDATED(1)]
for i=2:size(numberof_VALIDATED,1)
    locationsof_VALIDATED(i,:)=[1+locationsof_VALIDATED(i-1,2),numberof_VALIDATED(i)+locationsof_VALIDATED(i-1,2)];
    %new locations after we delete rows with nonvalid lines %%check var
    %used
end

sumsofLines=zeros(size(locationsof_VALIDATED,1),1);
k=1;
for indexLol=1:size(locationsof_VALIDATED,1)
    %check for round trips -> q with errors to check -> !time=fdist ->
    %Total time div by total length of line(Ddist) Ddist*LengthBtw = time
    %weight of node :: apply (strech) Sefer süresi to 1548
    
    for j=locationsof_VALIDATED(indexLol,1):locationsof_VALIDATED(indexLol,2)
       sumsofLines(k)=sumsofLines(k)+DistanceVector_Validated(j);
    end
       k=k+1;
end
%%subB_VALID = DistanceVector_Validated(locationsof_VALIDATED(:,2),1);
XYcoordinatesof_VALID_stops=rowarradd(locationsof_VALID_lines,[XKOORDINATI,YKOORDINATI]);
StopsCodesof_VALID=rowarradd(locationsof_VALID_lines,DURAKKODU);%valid hatların geçtikleri durakların kodları
IDof_VALID=durak2ID(StopsCodesof_VALID);%convert durak kodu to ID
r10=find(IDof_VALID==-1);%finding if any stop not converted
totalnodes=13862;%# of all the stops
GraphMatrix=zeros(totalnodes);
DistanceVector_Validated=rowarradd(locationsof_VALID_lines,DistanceVector);
%sumsoflines gives total distance per stop so we  have to check time needed
%for going to from 1 stop to next
%time value is important
transferRows=zeros(size(arr));
for i=1:size(arr,1)
    transferRows(i,1)=A(arr(i),1);
    
end
speedofLines=sumsofLines./transferRows; %%km/dk
%locofValidated shows the start and stop row of lines at i, speedof Lines
%shows speed of the line at i
timeofDistances_VALIDATED = zeros(size(DistanceVector_Validated));
%%timeofDistances_VALIDATED =timeofDistances_VALIDATED -9;
for i=1:size(speedofLines,1)
    
    for j=locationsof_VALIDATED(i,1):locationsof_VALIDATED(i,2)
        timeofDistances_VALIDATED(j,1)=DistanceVector_Validated(j)/speedofLines(i);
    end
    
end
% rerroeToDV=find(timeofDistances_VALIDATED==-9);
startPoint=0;stopPoint=0;
for i=1:size(locationsof_VALIDATED,1)
    startPoint=locationsof_VALIDATED(i,1);
    stopPoint=locationsof_VALIDATED(i,2);
    for j=startPoint:(stopPoint-1)%not to include last stops
        if(GraphMatrix(IDof_VALID(j,1),IDof_VALID(j+1,1) )==0 || timeofDistances_VALIDATED(j,1) <= GraphMatrix(IDof_VALID(j,1),IDof_VALID(j+1,1) ) )
            GraphMatrix(IDof_VALID(j,1),IDof_VALID(j+1,1)) = timeofDistances_VALIDATED(j,1);
            %fprintf('done');
        end
    end
end
emptyrows=find(all(GraphMatrix ==0,2));
emptycols=find(all(GraphMatrix' ==0,2));
emptynodes=intersect(emptyrows,emptycols);
allRowandCol=1:size(GraphMatrix,1);allRowandCol=allRowandCol';
allRowandCol(emptynodes,:)=[];%% displays ID of the nodes
GraphMatrix(emptynodes,:)=[];GraphMatrix(:,emptynodes)=[];
G=digraph(GraphMatrix);

plot(G);
timeofwalkmin=zeros(100,1);
distancebtween=timeofwalkmin;
% for i=1:100
% randorg=randi(13862,1,1);
% randdest=randi(13862,1,1);
% lonorg=X(randorg);latorg=Y(randorg);
% londes=X(randdest);latdes=Y(randdest);
% distancebtween(i)=distance(lonorg,londes,latorg,latdes);
% origin=latorg+"%2C"+lonorg;
% destination=latdes+"%2C"+londes;
% url1= "https://maps.googleapis.com/maps/api/directions/json?origin="+origin+"&destination="+destination+"&mode=walking&key= %% key"";
% value2=jsondecode(urlread(url1));
% timeofwalkmin(i)=value2.routes.legs.duration.value/60;
% 
% end
speedavg=[speedavg,distancebtween./timeofwalkmin];
mean(mean(speedavg)) %%0.0613 km per minute ,4.5-4.8 km per hour is accepted by google maps as human walking speed(non regarding slopes) so 0.08-0.075 km per, normal walking speed is 0.13-0.14 
yourlon=input("\nEnter your Longtitude(boylam)\n");
yourlat=input("\nEnter your Latitude(enlem)\n");
t=90;
[subXmax subXmin]=geographicalInterval(yourlon,t,'lon');%boylam
[subYmax subYmin]=geographicalInterval(yourlat,t,'enlem');%enlem
rapproximate=find(X<=subXmax & X>=subXmin & Y<=subYmax & Y>=subYmin);
plot(yourlon,yourlat,'blackx');hold on;
plot(X(rapproximate),Y(rapproximate),'ro');hold on;
plot(X(setdiff(1:size(X,1),rapproximate)),Y(setdiff(1:size(X,1),rapproximate)),'b.');
temp_near_stopsANDspenttime=zeros(size(rapproximate,1),2);
temp_near_stopsANDspenttime(:,1)=rapproximate;
temp_near_stopsANDspenttime(:,2)=timespend(yourlon,X(rapproximate),yourlat,Y(rapproximate));
temp_near_stopsANDspenttime=sortrows(temp_near_stopsANDspenttime,2);
reach_times_stops =999+zeros(size(X));%minimum time to get to stop with the id of row number
%%HATKODU 1B, YON D, SIRANO, DURAKKODU
IDKODU=durak2ID(DURAKKODU);
%%find(IDKODU==-1)

