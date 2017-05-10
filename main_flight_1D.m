clear all; close all;
global M_start;
global tim_thr_mass_drag_dc;

% DATA_WEX:
% -masa startowa rakiety w zakresie 1.5-3kg
% -ubytek paliwa jednego silnika 0.16kg
% -srednica 122mm
% -IC obliczony 290Ns
% save('DATA_WEX','mline','peakH','dragH','speedH') - command for
% comparision

% DATA_HYB:
% -masa startowa rakiety w zakresie 3.3-6kg
% -ubytek paliwa 1.3kg
% -srednica 125mm
% -IC obliczony 1600Ns
% save('DATA_HYB','mline','peakH','dragH','speedH') - command for
% comparision


%--------------
M0_start=1;
M_end=3;
len=3;
%--------------
for r=1:len


        veh_masses=linspace(M0_start,M_end,len);
        M_start=veh_masses(r);
        
        clearvars -except M_start r peakH dragH speedH M0_start M_end len tim_thr_mass_drag_dc      
        tim_thr_mass_drag_dc=[];
        
        %detection of peak height (v=0 crossing)
        opt=odeset('Events',@event_cross);
        
        %params for ode45 (forced piecewise execution) - in order to get 
        %denser resolution on sharp edges of chart
        %----------------
        v_i(1)=0;               %initial velocity for following step
        t_i(1)=0;               %initial time
        T_total=40+0.1;         %total time of motion to compute
        N_step=20;              %number of forced intervals
        t_e(1)=T_total/N_step;  %interval ending moment
        %----------------
        %progress indicator
        disp(['M_start= ' num2str(M_start) 'kg']);
        
        
        dens=10;            %interval timespan density
        tr=[];vr=[];        %temp vars
        for i=1:N_step
            %--------------
            t_span=linspace(t_i(i),t_e(i),dens);
            [t,v]=ode45(@dvdt,t_span,v_i(i),opt);
            %--------------
            %initials preparation for another interval
            t_i(i+1)=t(end);                %--- time borders for specific intervals
            t_e(i+1)=t_e(i)+T_total/N_step; %--- 
            v_i(i+1)=(v(end));              %initial vel. for each interval
            %total additive time result and vel.result
            tr=[tr;t];
            vr=[vr;v];

%             T{i}(:,:)=[t,v];
        end

        %overall computed v(t)
        [t,i_uni,i_redun]=unique(tr);
        v=vr(i_uni);
        %v(t) polynomial approximation
        % ppv=pchip(t,v);
        % pd=fnder(ppv,1);
        % pi=fnint(ppv,1);
        
        
        %--------------------
        total_steps=N_step*dens;
        T_interv=T_total/total_steps;
        query_time=linspace(t_i(1),t_e(end),total_steps);

        v_int=@(T)interp1(t,v,T);
        v_diff=@(T,T_interv) diff(v_int(T))./T_interv; %veh.acceleration

        alt(1)=0;   %initial altitude
        for i=1:length(query_time)-2
           alt(i+1)=alt(i)+integral(v_int,query_time(i),query_time(i+1));%alt. vector
        end
        %--------------------
        
        %sorting according to time, to preserve monotonicity swapped by
        %ode45
        [timeline,ind,~]=unique(tim_thr_mass_drag_dc(:,1));
        thrust=smooth((tim_thr_mass_drag_dc(ind,2)));
        mass=smooth((tim_thr_mass_drag_dc(ind,3)));
        drag=smooth((tim_thr_mass_drag_dc(ind,4)));
        dc=smooth((tim_thr_mass_drag_dc(ind,5)));
        
        
        thr=@(T) interp1(timeline,thrust,T);
        IC=integral(thr,timeline(1),timeline(end))
        peakH(r)=max(alt);
        dragH(r)=max(drag);
        speedH(r)=max(v);
end
%%comparison plotting
%--------------------------------
if len>1
    figure(999);
    mline=linspace(M0_start,M_end,len);
    [Axx,hn1,hn2]=plotyy([mline' mline'],[peakH' dragH'],mline',speedH');
    set(gca,'XMinorGrid','on', 'YMinorGrid','on');
    set(hn1,'Marker','.');
    set(hn2,'Marker','.');
    title('Peak height & drag vs starting mass (wessex engine)');
    axes(Axx(1));
    xlabel('mass start [kg]'); ylabel('drag [N]; peak height [m]');
    axes(Axx(2));
    ylabel('peak speed [m/s2]');
end
%--------------------------------
%%regular plotting
plot_data;
