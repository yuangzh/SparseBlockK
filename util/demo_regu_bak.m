% 0.5 || Ax-b||_F^2 + lambda ||x||_0
clc;clear;close all;
addpath('util','solver','data');



lambdas = [0.01 0.1 1 10];
scales  = [0 0.1 0.01 0.001];
data_id = [1:4 11:14];



% lambdas = [0.1];
% scales  = [0.0];
% data_id = [14];
% time_c = 20;
% yscale = 1;


% lambdas = [1];
% scales  = [0.1];
% data_id = [1];
% time_c = 20;
% yscale = 0.8;


lambdas = [1];
scales  = [0];
data_id = [1];
time_c = 20;
yscale = 0.8;


% lambdas = [1];
% scales  = [0.01];
% data_id = [11];
% time_c = 10;
% yscale = 0.7;



% lambdas = [1];
% scales  = [0];
% data_id = [12];
% time_c = 20;
% yscale = 1.01;
 
% lambdas = [1];
% scales  = [0];
% data_id = [2];
% time_c = 20;
% yscale = 1;

 
% lambdas = [0.1];
% scales  = [0.01];
% data_id = [2];
% time_c = 20;
% yscale = 0.02;
 
% lambdas = [10];
% scales  = [0.01];
% data_id = [3];
% time_c = 10;


% lambdas = [0.10];
% scales  = [0.01];
% data_id = [4];
% time_c = 20;


max_iter = inf;
for idata = 1:length(data_id)
    
    
    [A,b] = getdata( data_id(idata));
    
    for isetting = 1:length(scales)
        randn('seed',0); rand('seed',0);
        lambda = lambdas(isetting);
        scale = scales(isetting);
        
        [m,d]=size(A);
        
        x0 = randn(d,1)*scale;
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
        

        fprintf('fffff: %f\n',min(his1));
        fprintf('random coordinate descent\n');
        [x3, his3, ts3] = decomposition(x0,A'*A,-A'*b,const,lambda,[1;0],max_iter,0,time_c);
        fprintf('greedy coordinate descent\n');
        [x4, his4, ts4] = decomposition(x0,A'*A,-A'*b,const,lambda,[0;1],max_iter,0,time_c);
        
        fprintf('decomposition 0 3\n');
        [x5, his5, ts5] = decomposition(x0,A'*A,-A'*b,const,lambda,[0;6],max_iter,0,time_c);
        fprintf('decomposition 0 12\n');
        [x6, his6, ts6] = decomposition(x0,A'*A,-A'*b,const,lambda,[0;10],max_iter,0,time_c);
        
        fprintf('decomposition 3 0\n');
        [x7, his7, ts7] = decomposition(x0,A'*A,-A'*b,const,lambda,[6;0],max_iter,0,time_c);
        fprintf('decomposition 12 0\n');
        [x8, his8, ts8] = decomposition(x0,A'*A,-A'*b,const,lambda,[10;0],max_iter,0,time_c);
        
        fprintf('decomposition 11 1\n');
        [x9, his9, ts9] = decomposition(x0,A'*A,-A'*b,const,lambda,[10;1],max_iter,0,time_c);
        
        fprintf('data:%d, lambda:%f, scale:%f\n',data_id(idata),lambda,scale);
        fprintf('m:%d, d:%d\n',m,d);
        fprintf('proximal:                  %f\n',min(his1));
        fprintf('acc proximal:              %f\n',min(his2));
        fprintf('random coordinate descent: %f\n',min(his3));
        fprintf('greedy coordinate descent: %f\n',min(his4));
        
        fprintf('decomposition (R0-G5):     %f\n',min(his5));
        fprintf('decomposition (R0-G10):    %f\n',min(his6));
        fprintf('decomposition (R5-G0):     %f\n',min(his7));
        fprintf('decomposition (R10-G0):    %f\n',min(his8));
        
        fprintf('decomposition (R10-G1):    %f\n',min(his9));
        
        
        result{idata,isetting}.his1 = his1;
        result{idata,isetting}.ts1 = ts1;
        
        result{idata,isetting}.his2 = his2;
        result{idata,isetting}.ts2 = ts2;
        
        result{idata,isetting}.his3 = his3;
        result{idata,isetting}.ts3 = ts3;
        
        result{idata,isetting}.his4 = his4;
        result{idata,isetting}.ts4 = ts4;
        
        result{idata,isetting}.his5 = his5;
        result{idata,isetting}.ts5 = ts5;
        
        result{idata,isetting}.his6 = his6;
        result{idata,isetting}.ts6 = ts6;
        
        result{idata,isetting}.his7 = his7;
        result{idata,isetting}.ts7 = ts7;
        
        result{idata,isetting}.his8 = his8;
        result{idata,isetting}.ts8 = ts8;
        
        result{idata,isetting}.his9 = his9;
        result{idata,isetting}.ts9 = ts9;
        
       
        figure;
        
        
        tot = inf;
        his1 = his1(1:min(length(his1),tot));
        his2 = his2(1:min(length(his2),tot));
        his3 = his3(1:min(length(his3),tot));
        his4 = his4(1:min(length(his4),tot));
        his5 = his5(1:min(length(his5),tot));
        his6 = his6(1:min(length(his6),tot));
        his7 = his7(1:min(length(his7),tot));
        his8 = his8(1:min(length(his8),tot));
        his9 = his9(1:min(length(his9),tot));
        
        
        
        %             ts1 = ts1(1:min(length(ts1),tot));
        %             ts2 = his2(1:min(length(ts2),tot));
        %             ts3 = his3(1:min(length(ts3),tot));
        %             ts4 = his4(1:min(length(ts4),tot));
        %             ts5 = his5(1:min(length(ts5),tot));
        %             ts6 = his6(1:min(length(ts6),tot));
        %             ts7 = his7(1:min(length(ts7),tot));
        %             ts8 = his8(1:min(length(ts8),tot));
        %             ts9 = his9(1:min(length(ts9),tot));
        %             ts10 = his10(1:min(length(ts10),tot));
        
        
        xData{1} =  [1:length(his1)]; xData{2} =  [1:length(his2)]; xData{3} =  [1:length(his3)]; xData{4} =  [1:length(his4)]; xData{5} =  [1:length(his5)]; xData{6} =  [1:length(his6)]; xData{7} =  [1:length(his7)]; xData{8} =  [1:length(his8)]; xData{9} =  [1:length(his9)];
        xData{1} =  ts1(:); xData{2} =  ts2(:); xData{3} =  ts3(:); xData{4} =  ts4(:); xData{5} =  ts5(:); xData{6} = ts6(:); xData{7} = ts7(:); xData{8} =  ts8(:); xData{9} = ts9(:) ;
        yData{1} = his1(:);    yData{2} = his2(:);    yData{3} = his3(:);    yData{4} = his4(:);    yData{5} = his5(:);    yData{6} = his6(:);    yData{7} = his7(:);    yData{8} = his8(:);    yData{9} = his9(:);
        
        
        opt=loadopt;
        
        opt.xlabel = 'Time (seconds)';
        opt.ylabel = 'Objective';
        opt.lineWidth  = 4;
        opt.LegendFontSize = 16;
        
        
        opt.legend = {...
            'PGM',...
            'APGM',...
            'RCD',...
            'GCD',...
            'DEC(R0-G3)',...
            'DEC(R0-G12)',...
            'DEC(R3-G0)',...
            'DEC(R12-G0)',...
            'DEC(R11-G1)' };
        opt.legendLoc = 'NorthEast';
        opt.labelLines = 0;
        opt.logScale=2;
        prettyPlot(xData,yData,opt);
        max_iter = length(his1);
        hiss = [his1(:);his2(:);his3(:);his4(:);his5(:);his6(:);his7(:);his8(:);his9(:) ];
        axis([min(ts1) max(ts9) min(his9) yscale*max(his9)])
        
        fprintf('Method1: %f\n',min(his1));
        fprintf('Method2: %f\n',min(his2));
        fprintf('Method3: %f\n',min(his3));
        fprintf('Method4: %f\n',min(his4));
        fprintf('Method5: %f\n',min(his5));
        fprintf('Method6: %f\n',min(his6));
        fprintf('Method7: %f\n',min(his7));
        fprintf('Method8: %f\n',min(his8));
        fprintf('Method9: %f\n',min(his9));
        
        
        fprintf('\n');
        
        set(gcf,'paperpositionmode','auto')
        sss = sprintf('%d_%.2f_%.2f',data_id,scale,lambda);
     
  
sss(sss=='.')='o';
        
        print(sprintf('%s_%s.eps',mfilename,sss),'-depsc2','-loose');
   
    end
end




% save(sprintf('result\\regu_%s',mfilename),'result')

