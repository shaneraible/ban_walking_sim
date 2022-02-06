% density = mass / volume

cube_dim = 0.1:0.001:0.8; %a bunch of cubes of different dimensions (units:meters)
dim = size(cube_dim);
dim = dim(2);
cube_vol = cube_dim.^3; %units: m^3

%assume constant electric field of 3.7 V/m
mag_electric_field = zeros(1, dim) + 5;

%human tissue densities
%https://bionumbers.hms.harvard.edu/bionumber.aspx?id=110245
%https://bionumbers.hms.harvard.edu/files/Density%20and%20mass%20of%20each%20organ-tissue.pdf
mass_g = linspace(100,2000, dim);
mass_kg = mass_g./1000;
density = mass_kg./cube_vol;

%human conductivity
%https://www.researchgate.net/publication/43148155_Effect_of_the_averaging_volume_and_algorithm_on_the_in_situ_electric_field_for_uniform_electric-_and_magnetic-field_exposures
conductivity = linspace(0.05,0.4,dim);


X = conductivity;
Y = density;
Z = conductivity .* (mag_electric_field.^2) ./ density;

f = figure;
f.Position = [100,100,1500,800];


subplot(1,3,1)
plot3(X,Y,Z);
xlabel('Conductivity (S/m)');
ylabel('Density (kg/m^3)');
zlabel('SAR (W/kg)');
grid on

subplot(1,3,2)
plot(Y,Z);
grid on
xlabel('Density (kg/m^3)');
ylabel('SAR (W/kg)');

subplot(1,3,3)
plot(X,Z);
grid on;
xlabel('Conductivity (S/m)');
ylabel('SAR (W/kg)');

%-----------------

const_conduct = zeros(1, dim) + (0.4+0.05)/2; %CC
const_density = zeros(1, dim) + 1.04; %CD
SAR_CC = const_conduct .* (mag_electric_field.^2) ./ density;
SAR_CD = conductivity .* (mag_electric_field.^2) ./ const_density;

f = figure;
f.Position = [100,200,1500,800];

subplot(1,2,1)
plot(Y,SAR_CC);
grid on
xlabel('Density (kg/m^3)');
ylabel('SAR (W/kg)');

subplot(1,2,2)
plot(X,SAR_CD);
grid on;
xlabel('Conductivity (S/m)');
ylabel('SAR (W/kg)');






