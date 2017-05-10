%vehicle performance ocmparision for different veh. masses, based on wessex
%vs hybrid engine

clear all;
load('DATA_WEX');


for i=1:2;
    amline{i}=mline';
    adragH{i}=dragH';
    aspeedH{i}=speedH';
    apeakH{i}=peakH';
    load('DATA_HYB');
end
figure(1);

s(1)=subplot(221);
[A1,a(1),a(2)]=plotyy(amline{1},adragH{1},amline{1},aspeedH{1});
axes(A1(1))
title('engine mass tot.=0.55kg; fuel=0.16kg');
legend('wessex IC=290Ns');
ylabel('peak drag [N]');
axes(A1(2))
set(gca, 'XMinorGrid','on', 'YMinorGrid','on')
set(a(1),'Marker','.');
set(a(2),'Marker','.');
% ylabel('peak speed [m/s]');

s(3)=subplot(223);
plot(amline{1},apeakH{1},amline{1},apeakH{1},'.');
set(gca, 'XMinorGrid','on', 'YMinorGrid','on')
ylabel('max height [m]');

s(2)=subplot(222);
[A2,a(1),a(2)]=plotyy(amline{2},adragH{2},amline{2},aspeedH{2});
axes(A2(1))
title('engine mass tot.=2.3kg; fuel=1.3kg');
legend('hybrid IC=1600Ns');
% ylabel('peak drag [N]');
axes(A2(2))
set(gca, 'XMinorGrid','on', 'YMinorGrid','on')
set(a(1),'Marker','.');
set(a(2),'Marker','.');
ylabel('peak speed [m/s]');

s(4)=subplot(224);
plot(amline{2},apeakH{2},amline{2},apeakH{2},'.');
set(gca, 'XMinorGrid','on', 'YMinorGrid','on')
% ylabel('max height [m]');

d=0.033;
b=0.05;

p=get(s(1),'pos');
p(3)=p(3)+d;
p(4)=p(4)+b;
set(s(1),'pos',p);

p=get(s(2),'pos');
p(1)=p(1)-d;
p(3)=p(3)+d;
p(4)=p(4)+b;
set(s(2),'pos',p);


p=get(s(3),'pos');
p(3)=p(3)+d;

p(4)=p(4)+b;
p(2)=p(2)+b;
set(s(3),'pos',p);

p=get(s(4),'pos');
p(1)=p(1)-d;
p(3)=p(3)+d;

p(4)=p(4)+b;
p(2)=p(2)+b;
set(s(4),'pos',p);

% 
% xlim([ min([amline{1};amline{2}]),  max([amline{1};amline{2}])  ]);
% ylim([ min(min([aspeedH{1};aspeedH{2}]) ,  min([apeakH{1};apeakH{2}]))  ,...
%        max(max([aspeedH{1};aspeedH{2}]) ,  max([apeakH{1};apeakH{2}]))]);