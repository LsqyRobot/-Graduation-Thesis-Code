function [rx,ry,rz] = GetDesiredMotion(tspan)
eta=0.3;
x0=0.3;
y0=0.3;
z0=0.3;
rx = eta*cos(4*pi.*tspan).*cos(2*pi.*tspan) + x0;
ry = eta* cos(4*pi.*tspan).*sin(2*pi.*tspan) + y0;
rz = eta* cos(4*pi.*tspan).*sin(2*pi.*tspan) + z0;
end