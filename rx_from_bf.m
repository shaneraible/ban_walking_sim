%
function rx = rx_from_bf(frequency, transmitPower, totalDistance, angle, BMI)
    % A statistical path loss model for medical implant communication channels
    % Kamran Sayrafian-Pour; Wen-Bin Yang; John Hagedorn; Judith Terrill; Kamya Yekeh Yazdandoost
    % ieee
    % Path loss for deep tissue implant from 
    ntissue = 6.29;
    nfreespace = 2;
    
    % Visceral fat thickness measured by ultrasonography can estimate not only visceral obesity but also risks of cardiovascular and metabolic diseases
    % Soo Kyung Kim,  Hae Jin Kim,  Kyu Yeon Hur,  Sung Hee Choi,  Chul Woo Ahn, Sung Kil Lim,  Kyung Rae Kim,  Hyun Chul Lee,  Kap Bum Huh, Bong Soo Cha
    % average visceral fat thickness given BMI
    avgBMI = (23.2 + 24.7 + 27)/3;
    avgThickness = (36.2 + 53.3 + 75.8)/3;
    BMIThickRatio = avgThickness/avgBMI;
    
    tissueThickness = BMIThickRatio * BMI;
        
    %angle = 0, all transmission through tissue 
    %angle = 90, transmission through tissueThickness mm tissue
    theta = 90 - abs(angle);
    if theta == 90
        pathTissueDistance = totalDistance;
    elseif tissueThickness/cosd(theta) > totalDistance
        pathTissueDistance = totalDistance;
    else
        pathTissueDistance = tissueThickness/cosd(theta);
    end
    
    pathTissueDistance = (pathTissueDistance + normrnd(5, 5)) / 1000 ; %mm to m
    
    freeSpaceDistance = (totalDistance - pathTissueDistance)/1000;
    
    %Path loss (dB)= 20 log (f) + 10 n log (d) + Constant
    tissuePathLoss = 20*log(frequency) + 10*ntissue*log(pathTissueDistance) - 147.56; %dB
    freeSpacePathLoss = 20*log(frequency) + 10*nfreespace*log(freeSpaceDistance) - 147.56; %dB
    
    pathloss = tissuePathLoss + freeSpacePathLoss;
    rx = transmitPower - pathloss;
end