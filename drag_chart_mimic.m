%script to obtain numeric representation of graphical aero drag, and engine thrust charts

figure(2);
im=imread('drag2_WATobtained.png');
imshow(im);

% % % chart line mimic (with two terminal reference points!)
[v,cd]=ginput();

 
save('cd_data','v','cd');

Mach=330; %[m/s]
chart_vel=4.5*Mach; %right side of velocity span from chart

load('cd_data');

%translation
v=v-v(1)-20; %velocity bias -20[m/s] to match chart peak to v=330[m/s]
cd=abs(cd-cd(1)); %reference point cd(1)=0
%scaling
v=v*chart_vel/(v(end)-v(1));
scale_cd=(0.34-0.2)/(cd(end)-cd(1)); %scaling to reference points difference
cd=cd*scale_cd+0.2; %biasing by reference offset

figure(1);plot(v,cd)
% 
%
cd=cd(2:end-1);v=v(2:end-1); %elimination of reference points
Tt=chart_vel*0.05;
%interpolation
%-------------------
[v_uni,i_uni,i_redn]=unique(v);
cd_uni=(cd(i_uni));

v_uni_int=linspace(v_uni(1),v_uni(end),chart_vel)';
cd_uni_int=interp1(v_uni,cd_uni,v_uni_int);
%-------------------
%chart approximation 
dc2_pp=spline(v_uni_int,smooth(cd_uni_int,100*(v_uni(end)-v_uni(1))/chart_vel));

figure(2);
v_cd=[v_uni_int,cd_uni_int]; %data encapsulation
plot(v_cd(:,1),v_cd(:,2),'.',[-Tt;v_cd(:,1)],ppval(dc2_pp,[-Tt;v_cd(:,1)]));

save('v_cd','dc2_pp','v_cd');