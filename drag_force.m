clear all; close all;
load('dc2_pp.mat');

d_offset=0;
DC=@(v)ppval(dc2_pp,v)+d_offset;
% DC=@(v)0.9;

Cdref=0.1;

fi=125*1e-3;%srednica korpusu rakiety
S=pi()*(fi/2)^2;

s=@(v)DC(abs(v))*1.168/2*S;
drag=@(v) s(v).*(v.^2);

v_l=linspace(0,250,1000);
figure(1);
subplot(211);
[ax,h1,h2]=plotyy([v_l; v_l],[drag(v_l); Cdref.*drag(v_l)./DC(v_l)],v_l,DC(v_l));
legend('drag coefficient','drag unit force');
set(gca, 'XMinorGrid','on', 'YMinorGrid','on','XMinorTick','on', 'YMinorTick','on')
axes(ax(1));
title(['Frontal drag force fi=125mm (with model Cd and reference Cd=' num2str(Cdref) ') vs velocity']);xlabel('velocity [m/s]');ylabel('drag [N]');
axes(ax(2));
ylabel('Cd');


perc=abs((drag(v_l) - Cdref.*drag(v_l)./DC(v_l)))./drag(v_l).*100;
% perc=abs(ones(1,length(v_l))-ones(1,length(v_l))./DC(v_l))*100;
subplot(212);plot(v_l,perc);
title('Percentage part of Cd contributing to frontal drag - also error');xlabel('velocity [m/s]');ylabel('[%]');
set(gca, 'XMinorGrid','on', 'YMinorGrid','on','XMinorTick','on', 'YMinorTick','on')


