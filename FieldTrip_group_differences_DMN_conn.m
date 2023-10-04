%list of P50 intra-DMN conn files as of 6/7/21:
datafiles = {'1422_00.conn'; '1439_00.conn'; '1441_00.conn'; '1444_00.conn'; '1445_00.conn'; '1446_00.conn'; '1447_00.conn'; '1449_00.conn';'1450_00.conn'; '1452_00.conn';'1453_00.conn';'1455_00.conn';'1456_00.conn';'1457_00.conn';'1458_00.conn';'1467_00.conn';'1468_00.conn';'1469_00.conn';'1470_00.conn';'1471_00.conn';'1472_00.conn';'1474_00.conn';'1475_00.conn';'1477_00.conn';'1479_00.conn';'1480_00.conn';'1482_00.conn';'1483_00.conn';'1485_00.conn';'1487_00.conn';'1488_00.conn';'1489_00.conn';'1491_00.conn';'1492_00.conn';'1493_00.conn';'1495_00.conn';'1496_00.conn';'1497_00.conn';'1500_00.conn';'1501_00.conn';'1502_00.conn';'1504_00.conn';'1513_00.conn';'1514_00.conn';'1516_00.conn';'1520_00.conn';'1522_00.conn';'1523_00.conn';'1527_00.conn';'1531_00.conn';'1533_00.conn';'1555_00.conn';'8001_00.conn';'8007_00.conn';'8027_00.conn';'8028_00.conn';'8052_00.conn';'8057_00.conn';'8062_00.conn';'8064_00.conn';'8069_00.conn';'8083_00.conn';'8085_00.conn';'8086_00.conn';'8098_00.conn';'8104_00.conn';'8106_00.conn';'8110_00.conn';'8115_00.conn';'8116_00.conn';'8119_00.conn';'8129_00.conn';'8133_00.conn';'8138_00.conn';'8140_00.conn';'8145_00.conn';'8126_00.conn'};
%% read conn data
for subj=1:length(datafiles)
        tmp=readBESAconn(datafiles{subj});
        %%
        data = [];
        data.dimord = 'chan_chan_freq_time';
        data.cohspctrm = tmp.Data;
        data.time    = [-6000:50:3000]/1000;% time in seconds
        data.freq    = [2:1:40];
        data.label = {'PCC' 'mPFC' 'LAG' 'RAG' 'LLatT' 'RLatT'};

        %%
        tmp1=squeeze(data.cohspctrm(2,1,:,:));
        tmp2=squeeze(data.cohspctrm(3,1,:,:));
        tmp3=squeeze(data.cohspctrm(3,2,:,:));
        tmp4=squeeze(data.cohspctrm(4,1,:,:));
        tmp5=squeeze(data.cohspctrm(4,2,:,:));
        tmp6=squeeze(data.cohspctrm(4,3,:,:));
        tmp7=squeeze(data.cohspctrm(5,1,:,:));
        tmp8=squeeze(data.cohspctrm(5,2,:,:));
        tmp9=squeeze(data.cohspctrm(5,3,:,:));
        tmp10=squeeze(data.cohspctrm(5,4,:,:));
        tmp11=squeeze(data.cohspctrm(6,1,:,:));
        tmp12=squeeze(data.cohspctrm(6,2,:,:));
        tmp13=squeeze(data.cohspctrm(6,3,:,:));
        tmp14=squeeze(data.cohspctrm(6,4,:,:));
        tmp15=squeeze(data.cohspctrm(6,5,:,:));
        tmp={tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8 tmp9 tmp10 tmp11 tmp12 tmp13 tmp14 tmp15};
        for i=1:15
        tfdata(i,:,:) = tmp{i};
        end
        datatf = [];
        datatf.dimord = 'chan_freq_time';
        datatf.powspctrm = tfdata;
        datatf.time    = data.time;% time in seconds
        datatf.freq    = data.freq;
        datatf.label = {'mPFC-PCC' 'LAG-PCC' 'LAG-mPFC' 'RAG-PCC' 'RAG-mPFC' 'RAG-LAG' 'LLatT-PCC' 'LLatT-mPFC' 'LLatT-LAG'...
            'LLatT-RAG' 'RLatT-PCC' 'RLatT-mPFC' 'RLatT-LAG' 'RLatT-RAG' 'RLatT-LLatT'};
        alldata{subj}=datatf;
end
%% take the abs of coherenece
for i=1:length(alldata)
    alldata{i}.powspctrm=abs(alldata{i}.powspctrm);
end
%% compute grand average for patients and controls
cfg = [];
%edited the indices below based on current subject file list (52 Sz; 25
%HC): 7/6/21
gasz = ft_freqgrandaverage(cfg,alldata{1:52});
gahc = ft_freqgrandaverage(cfg,alldata{53:77});
%plot averages within groups?
%cfg.xlim = [0 .75];
%cfg.ylim = [2 15];
%cfg.figure = 'gcf';
%cfg.zlim = [0 .1];    
%cfg.fontsize       = 16;
%figure;
%add this in for bl-adjusted
%cfg.zlim = [-1 1]; 
%hc plot- 
%for i=1:length(gahc.label)
%    cfg.channel = gahc.label{i};
%subplot(5,3,i); ft_singleplotTFR(cfg,gahc);
%end
%sz plot- 
%for i=1:length(gasz.label)
%    cfg.channel = gasz.label{i};
%subplot(5,3,i); ft_singleplotTFR(cfg,gasz);
%end


%% compute a difference
cfg = [];
cfg.operation = 'subtract';
cfg.parameter = 'powspctrm';
diff = ft_math(cfg,gahc,gasz);
%% plot to check
% plots group differences in coherence (difference in coherence based on absolute value of
% imaginary coherence from BESA-- difference values on right y-axis,
% frequency on left y-axis, time on x-axis (Plot 1)
cfg = [];
%cfg.xlim = [-6 3];
cfg.xlim = [-2 3];
cfg.ylim = [2 15];
cfg.figure = 'gcf';
cfg.zlim = [-.1 .1];    
cfg.fontsize       = 16;
figure;
for i=1:length(gahc.label)
    cfg.channel = gahc.label{i};
subplot(5,3,i); ft_singleplotTFR(cfg,diff);
end
%%
clear design
%HARD CODING TO SPECIFY NUMBER OF PATIENTS AND HC
SZsubj   = 52;
HCsubj = 25;
design = zeros(2,SZsubj+HCsubj);
for i = 1:SZsubj
  design(1,i) = i;
end
for i = 1:HCsubj
  design(1,SZsubj+i) = i;
end
% SZ will be 1, HC will be 2
% assigns groups to data matrix (second row)
design(2,1:SZsubj)        = 1;
design(2,SZsubj+1:SZsubj+HCsubj) = 2;

cfg                  = [];
%now coding to average across nodes: first all, then will specify just
%posterior, just anterior separately.
%full channel list: 
cfg.channel={'mPFC-PCC' 'LAG-PCC' 'LAG-mPFC' 'RAG-PCC' 'RAG-mPFC' 'RAG-LAG' 'LLatT-PCC' 'LLatT-mPFC' 'LLatT-LAG' 'LLatT-RAG' 'RLatT-PCC' 'RLatT-mPFC' 'RLatT-LAG' 'RLatT-RAG' 'RLatT-LLatT'};
%just anterior:
%cfg.channel={'LLatT-mPFC' 'RLatT-mPFC' 'RLatT-LLatT'};
%just posterior:
%cfg.channel={'RAG-LAG' 'LAG-PCC' 'RAG-PCC'};
%reducing amount of time looked at:
cfg.latency=[-2 2];
%specifying only 2-15 Hz
cfg.frequency = [2 15];
%blocking out for testing 10/15
%cfg.avgoverchan = 'yes';
cfg.spmversion = 'spm12';
cfg.method           = 'montecarlo';
cfg.statistic        = 'ft_statfun_indepsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.05;
cfg.numrandomization = 5000;
%cfg.numrandomization = 1000;
cfg.neighbours       = [];
cfg.design           = design;
%because I'm changing this to indepsamplesttest, commenting out uvar
%because I got the error "cfg.uvar should not exist for an independent
%samples statistic"
%cfg.uvar             = 1;
cfg.ivar             = 2;
%more hardcoding of subnum.
stat = ft_freqstatistics(cfg,alldata{1:52},alldata{53:77});
%% plots group differences- t-values on right y-axis, frequency on left y-axis, time on x-axis 
cfg = [];
cfg.parameter = 'stat';
cfg.figure = 'gcf';
cfg.maskparameter = 'mask';
cfg.maskstyle = 'outline';
cfg.fontsize       = 16;
cfg.zlim = [-3 3];
figure;
for i=1:length(gahc.label)
    cfg.channel = gahc.label{i};
subplot(5,3,i); ft_singleplotTFR(cfg,stat);
end
%ft_singleplotTFR(cfg,stat);
c = colorbar;
%% now apply baseline to the data and test again
for subj = 1:length(alldata)
 cfg = [];
    cfg.baseline =[-2 -.25];
    cfg.baselinetype = 'relchange';
      design(1,i) = i;
    alldata{subj}= ft_freqbaseline(cfg, alldata{subj});
end
%% extract data
for subj = 1:length(alldata)
 cfg = [];
    cfg.latency =[-2 -.25];% insert the latency from the t-test with the significant window.
    cfg.frequency = [8 12];% insert from stat cluster
    cfg.avgovertime = 'yes';
    cfg.avgoverfreq = 'yes';
    cfg.channel = {'the chan of interest from STAT'};% this can be one or more 
    cfg.avgoverchan = 'yes';
    
    tmp{subj}= ft_selectdata(cfg, alldata{subj});
    cohvalues(subj)=squeeze(tmp{subj}.powspctrm);
end
