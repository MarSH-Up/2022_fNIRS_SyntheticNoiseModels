function [HemoNoises] = Neurofeedback_PhysiologicalNoise(FreqSD, FreqMean, ResolutionStep, timestamps)

%Variables to ADD the noises to the models
HemoNoisesHbO = zeros(2, length(timestamps));
HemoNoisesHHb = zeros(2, length(timestamps));

%Calculation of the operative ranges to use
Initial =  FreqMean - 2 * FreqSD;
Ending = FreqMean + 2 * FreqSD + ResolutionStep;
Calsize =  ((Ending - Initial)/ResolutionStep) + 1;
FrequencySet = linspace(Initial, Ending, Calsize);

%LINSPACE CHECk
amplitudeScaling = 1;
for i = 1:Calsize
   
    %Random Amplitude
    A = 0;
    %Agregar una gaussiana centrada en la media de disperción 
    A = amplitudeScaling;
   
    %Random phase
    theta = 0;
    theta = 2 * pi * rand(1) - pi;
    
    %Fundamental signal
    tmpSin = A * sin(2 * pi * FrequencySet(1,i) * timestamps + theta);
    HemoNoisesHbO = HemoNoisesHbO  + tmpSin;
    HemoNoisesHHb  = HemoNoisesHHb  + (-1/3) * tmpSin;

end

HemoNoises = zeros(4,length(timestamps));
HemoNoises(1,:) = HemoNoisesHbO(1,:);
HemoNoises(2,:) = HemoNoisesHbO(2,:);
HemoNoises(3,:) = HemoNoisesHHb(1,:);
HemoNoises(4,:) = HemoNoisesHHb(2,:);
