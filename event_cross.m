function [value,isterminal,direction] = event_cross(t,v)
%peak height detection
value = v(1); % detect v = 0
isterminal = 1; % stop the integration
direction = -1;
