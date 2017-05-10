function dvdt = dvdt(t,v)

global M_start
global tim_thr_mass_drag_dc;

load('v_cd','dc2_pp'); %loading drag coefficient function as PP-coeffs
dc_pp=dc2_pp;
load('YY.mat') %loading specific engine char. as PP-ceoffs
engine_num=2;
M_fuel=0.16 * engine_num; %wessex engine 
% Mfuel=1.8; %for hybrid engine

g=9.87; %gravitational acc.


% multi=sqrt(5.5); %total impulse IC=250 to IC=1500 multiplicator
multi=1;    %normal mode
T=2.5*multi;%basic engine working time

%obtaining thrust and mass drop characteristics
if t<=T
     M_total= M_start - M_fuel/T*t;
     F_thr=@(T) interp1(YY(:,1)*multi,YY(:,2)*multi,T) *engine_num;
else
    F_thr=@(T) 0;
    M_total= M_start - M_fuel;
end
F_thrust=F_thr(t);

%%manual engine thrust and vhe. mass determination
% M_start=4.3;
% Mf1=M_start-3.52; Mf2=M_start-Mf1-3;  g=9.87;
% T1=4;
% T2=T1+6;
% %okreslenie ewolucji czasowych ciagu i masy
% if t<=T1
%     F_thrust=225;
%     M_total=M_start - Mf1/T1*t;
% elseif (t>T1) && (t<=T2)
%     F_thrust=100;
%     M_total=M_start - Mf1 - Mf2/T2*t;
% else
%     F_thrust=0;
%     M_total=M_start - Mf1 - Mf2;
% end



%aero drag coefficient
d_offset=0;
DC=@(v)ppval(dc_pp,abs(v))+d_offset;

fi=122*1e-3;%peak body diameter
head_area=pi()*(fi/2)^2;


%velocity versor
if isnan(v/abs(v))
    W=1;
else
    W=v/abs(v);
end
drag= W*(v^2) * DC(abs(v))*1.168/2*head_area;

%data vector passing out
tim_thr_mass_drag_dc=[tim_thr_mass_drag_dc;[t, F_thrust, M_total, drag,DC(v)]];

dvdt = F_thrust/M_total - drag/M_total - g;






