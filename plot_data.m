figure(1);
subplot(311);
% [A,h1,h2] = plotyy(t,ppval(v_diff,t),t,ppval(ppv,t));
% [A,h1,h2] = plotyy(t,polyval(v_diff,t),t,polyval(pv,t));
  [A,h1,h2] = plotyy(query_time(1:end-1),v_diff(query_time,T_interv),query_time,v_int(query_time));hold on;
  legend('acc','speed');
axes(A(1));
title('acceleration vs velocity');
xlabel('time [s]')
ylabel('acc [m/s2]');
    set(gca, 'XMinorGrid','on', 'YMinorGrid','on','XMinorTick','on', 'YMinorTick','on')

axes(A(2));
ylabel('speed [m/s]');
% set(A(2),'Xtick',0:0.5:20,'Ytick',-60:20:120);
% set(h1,'Marker','.');
% set(h2,'Marker','.');

%--------------------------------
subplot(312);
[Ax,ha1,ha2]=plotyy([timeline; timeline],[thrust; drag], timeline,mass);
legend('thrust & drag', 'veh. mass');

title('engine vs total mass + drag char.'); 
axes(Ax(1));
xlabel('time [s]'); ylabel({'thrust [N]', 'drag[N]'});
ylim([min(drag) max(max(thrust(:),max(drag(:))))]);

set(gca, 'XMinorGrid','on', 'YMinorGrid','on','XMinorTick','on', 'YMinorTick','on')
axes(Ax(2));
xlabel('time [s]'); ylabel('vehicle mass [kg]')
% set(ha1,'Marker','.');
% set(ha2,'Marker','.');
%--------------------------------
subplot(313);
% plot(t,ppval(pi,t));
% plot(t,polyval(pi,t));
[Axs,hb1,hb2]=plotyy(query_time(1:length(alt)),alt,timeline,dc);hold on;
legend('altitude','drag coeff.');
title('altitude vs cd');
axes(Axs(1));
xlabel('time [s]');
ylabel('altitude [m]');
axes(Axs(2));
ylabel('cd');
    set(gca, 'XMinorGrid','on', 'YMinorGrid','on','XMinorTick','on', 'YMinorTick','on')
% set(hb1,'Marker','.');
% set(hb2,'Marker','.');