% 0.5 || Ax-b||_F^2 + lambda ||x||_0
clc;clear;close all;
addpath('util','solver','data');

data_id = [1 1  1     3 3 3    4 4 4     11 11 11    13 13 13    14 14 14];
lambdas = [1 10 50    1 10 50  1 10 50   1 10 50     1 10 50     1 10 50];

max_iter = 10000000;
time_c   = 50;

for iii = 1:length(lambdas)

    [A,b] = getdata( data_id(iii));
    
    randn('seed',0); rand('seed',0);
    lambda = lambdas(iii);  
    [m,d]=size(A);
    
    x0 = randn(d,1)*0;
    const = 0.5*b'*b;
    HandleObjSmooth    = @(x)computeObj(x,A,b);
    HandleObjNonSmooth = @(x)lambda*nnz(x(:));
    HandleProx = @(theta,a)computeprox(theta,a,lambda);
    
    
    if(d<m)
        [~,L] = laneig(A'*A,1,'AL');
    else
        [~,L] = laneig(A*A',1,'AL');
    end
    
    fprintf('proximal gradient\n');
    [x1, his1, ts1]= ProximalGradient_Constant_Stepsize(x0,HandleObjSmooth,HandleObjNonSmooth,HandleProx,L,max_iter,0,time_c); %norm(A'*A)

    fprintf('accerlated proximal gradient\n');
    [x2, his2, ts2]= AccerlatedProximalGradient_Constant_Stepsize(x0,HandleObjSmooth,HandleObjNonSmooth,HandleProx,L,max_iter,0,time_c); %norm(A'*A)
    
    fprintf('random coordinate descent\n');
    [x3, his3, ts3] = decomposition(x0,A'*A,-A'*b,const,lambda,[1;0],max_iter,0,time_c);

    fprintf('greedy coordinate descent\n');
    [x4, his4, ts4] = decomposition(x0,A'*A,-A'*b,const,lambda,[0;1],max_iter,0,time_c);
    
    fprintf('decomposition 0 12\n');
    [x5, his5, ts5] = decomposition(x0,A'*A,-A'*b,const,lambda,[0;12],max_iter,0,time_c);
    
    fprintf('decomposition 12 0\n');
    [x6, his6, ts6] = decomposition(x0,A'*A,-A'*b,const,lambda,[12;0],max_iter,0,time_c);

    fprintf('decomposition 10 2\n');
    [x7, his7, ts7] = decomposition(x0,A'*A,-A'*b,const,lambda,[10;2],max_iter,0,time_c);
    
    fprintf('index:%d, data:%d, lambda:%f, (m,d) = (%d %d)\n',iii,data_id(iii),lambda,m,d);

    fprintf('proximal:                  %f\n',min(his1));
    fprintf('acc proximal:              %f\n',min(his2));
    fprintf('random coordinate descent: %f\n',min(his3));
    fprintf('greedy coordinate descent: %f\n',min(his4));
    fprintf('decomposition (R0-G10):    %f\n',min(his5));
    fprintf('decomposition (R10-G0):    %f\n',min(his6));
    fprintf('decomposition (R10-G2):    %f\n',min(his7));
    
%     figure;
%     tot = inf;
%     his1 = his1(1:min(length(his1),tot));
%     his2 = his2(1:min(length(his2),tot));
%     his3 = his3(1:min(length(his3),tot));
%     his4 = his4(1:min(length(his4),tot));
%     his5 = his5(1:min(length(his5),tot));
%     his6 = his6(1:min(length(his6),tot));
%     his7 = his7(1:min(length(his7),tot));
%     his8 = his8(1:min(length(his8),tot));
%     his9 = his9(1:min(length(his9),tot));
%     
%     
%     
%     ts1 = ts1(1:min(length(ts1),tot));
%     ts2 = his2(1:min(length(ts2),tot));
%     ts3 = his3(1:min(length(ts3),tot));
%     ts4 = his4(1:min(length(ts4),tot));
%     ts5 = his5(1:min(length(ts5),tot));
%     ts6 = his6(1:min(length(ts6),tot));
%     ts7 = his7(1:min(length(ts7),tot));
%     ts8 = his8(1:min(length(ts8),tot));
%     ts9 = his9(1:min(length(ts9),tot));
%     ts10 = his10(1:min(length(ts10),tot));
%     
%     
% %     xData{1} =  [1:length(his1)]; xData{2} =  [1:length(his2)]; xData{3} =  [1:length(his3)]; xData{4} =  [1:length(his4)]; xData{5} =  [1:length(his5)]; xData{6} =  [1:length(his6)]; xData{7} =  [1:length(his7)]; xData{8} =  [1:length(his8)]; xData{9} =  [1:length(his9)];
%     xData{1} =  ts1(:); xData{2} =  ts2(:); xData{3} =  ts3(:); xData{4} =  ts4(:); xData{5} =  ts5(:); xData{6} = ts6(:); xData{7} = ts7(:); xData{8} =  ts8(:); xData{9} = ts9(:) ;
%     yData{1} = his1(:);    yData{2} = his2(:);    yData{3} = his3(:);    yData{4} = his4(:);    yData{5} = his5(:);    yData{6} = his6(:);    yData{7} = his7(:);    yData{8} = his8(:);    yData{9} = his9(:);
%     
%     
%     opt=loadopt;
%     
%     opt.xlabel = 'Time (seconds)';
%     opt.ylabel = 'Objective';
%     opt.lineWidth  = 4;
%     opt.LegendFontSize = 14;
%     
%     
%     opt.legend = {...
%         'PGM',...
%         'APGM',...
%         'RCDM',...
%         'GCDM',...
%         'DEC(R0G10)',...
%         'DEC(R10G0)',...
%         'DEC(R10G2)' };
%     opt.legendLoc = 'NorthEast';
%     opt.labelLines = 0;
%     opt.logScale=2;
%     prettyPlot(xData,yData,opt);
%     max_iter = length(his1);
%     hiss = [his1(:);his2(:);his3(:);his4(:);his5(:);his6(:);his7(:);his8(:);his9(:) ];
%     axis([min(ts1) max(ts9) min(his9) yscale*max(his9)])
%     set(gcf,'paperpositionmode','auto')
    
    
    
    One = [];
    One.data_id = data_id(iii);
    One.lambda = lambdas(iii);

    
    One.ts1 = ts1;
    One.ts2 = ts2;
    One.ts3 = ts3;
    One.ts4 = ts4;
    One.ts5 = ts5;
    One.ts6 = ts6;
    One.ts7 = ts7;

    
    
    One.his1 = his1;
    One.his2 = his2;
    One.his3 = his3;
    One.his4 = his4;
    One.his5 = his5;
    One.his6 = his6;
    One.his7 = his7;

    
    result{iii} = One;
    
    
end

save(mfilename,'result')

