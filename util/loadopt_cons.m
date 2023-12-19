function [options] = loadopt
options=[];

options.colors = loadcolor;
options.lineStyles=loadlinestyples;
options.markers=loadmarkers;
options.errorColors=loaderrorcolor;
options.markerSpacing=loadmarkerSpacing;


end


function lineStyles = loadlinestyples
lineStyles{1}='-.';
lineStyles{2}='-';
lineStyles{3}='-';
lineStyles{4}=':'; % solid
lineStyles{5}='-';
lineStyles{6}='-';
lineStyles{7}='-'; % dashdot
lineStyles{8}='-.'; % dashdot
lineStyles{9}='-'; % dotted
lineStyles{10}='-'; % dotted
end

function markers = loadmarkers
markers{1}='+';
markers{2}='o';
markers{3}='o';
markers{4}='o';
markers{5}='o';
markers{6}='o';
markers{7}='o';
% markers{3}='^';
% markers{4}='v';
%  markers{5}='*';
% markers{6}='+';
% markers{7}='.';
 markers{8}='o';
% markers{9}='p';
% markers{10}='d';
% markers{11}='<';
% markers{12}='>';
% markers{13}='h';
end



function [colors] = loaderrorcolor
colors = [
    0.75 0.75 1
    0.75 1 0.75
    1 0.75 0.75
    0.75 0.75 1
    0.75 1 0.75
    1 0.75 0.75
    0.30 0.5 0.75
    0.5 0.5 0.15
    0.6 0.5 0.05
    0.6 0.5 0.05
    ];
end

 


function [markerSpacing] = loadmarkerSpacing
markerSpacing = [...
    1 1;
    1 1;
    1 1;
    1 1;
    1 1;
    1 1;
    1 1;
    1 1;

    ];
end



function [colors] = loadcolor
pcolor=[];

pcolor.red      = [255,66,14]/256;    pcolor.red2     = [255,113,31]/256;   pcolor.red3     = [236,42,45]/256;
pcolor.blue     = [0,149,201]/256;    pcolor.blue2    = [114,214,238]/256;  pcolor.blue3    = [0,183,240]/256;  pcolor.blue4    = [0,192,192]/256;   pcolor.blue5    = [65,146,228]/256;
pcolor.green    = [0,170,77]/256;     pcolor.green2   = [81,157,28]/256;    pcolor.green3   = [36,178,76]/256;  pcolor.green4   = [192,192,0]/256;   pcolor.green5   = [76,181,60]/256;
pcolor.purple   = [143,76,178]/256;   pcolor.purple2  = [125,66,210]/256;
pcolor.crimson  = [192,52,148]/256;   pcolor.crimson2 = [245,147,202]/256; pcolor.crimson3  = [212,22,118]/256;
pcolor.orange   = [254,181,89]/256;   pcolor.orange2  = [255,129,0]/256;    pcolor.orange3  = [219,130,1]/256;
pcolor.gray     = [128,128,127]/256;
pcolor.yellow   = [255,204,51]/256;   pcolor.yellow2  = [248,235,46]/256;
pcolor.pink     = [255,130,160]/256;
pcolor.black     = [30,30,30]/256;
pcolor.def      = [256,256,230]/256;

colors  = [];

 colors{1}=pcolor.black  ;
 colors{2}=pcolor.purple; %crimson;
 colors{3}=pcolor.pink    ;   
 colors{4}=pcolor.crimson; 
 colors{5}=pcolor.blue ;%yellow ;
 colors{6}=pcolor.yellow ;
 colors{7}=pcolor.green3 ;
 colors{8}=pcolor.red  ;
 
%  colors{9}=pcolor.;

% colors2=invertlist(colors);
end
