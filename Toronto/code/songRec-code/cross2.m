function [testE, trainE, prop] = cross2(train, social)
% evaluating algorithm running it on random datasets generated by
% splitDataFunction
% only weak test for now
p = randperm(100);
p = p(1:3);
hidden = [1]; %linspace(5, 100, 10);
lds = [0.001];
seeds = 1:1;
Ks = [3];
real = zeros(length(seeds),length(Ks));
for k=1:length(Ks)
K = Ks(k);
for mySeed=1:length(seeds);
fprintf('new seed\n');
setSeed(floor(mySeed*5 - 2));
for current=1:1
    [D N] = size(train);
    [usrEntr, artEntr] = find(train);
    entries = length(usrEntr);
    perm = randperm(entries);
    %idx = find(train);
    fprintf('starting %d fold\n', K);
    for i = 1:1
        [train_new, test_new] = splitDataFunction(train, 2*K, seeds(mySeed));
        fprintf('taking %f of data to train\n', full(sum(sum(train_new ~= 0))/sum(sum(train ~= 0))));
        % run some classifier
        prop(mySeed, k) = full(sum(sum(train_new ~= 0))/sum(sum(train ~= 0)));
        
        
        [err(i), sm] = estimateMeanPrediction(train_new, test_new)%
        err2(i) = estimateMeanPrediction(train_new, train_new)
        mp(i) = err(i)
        %sm
        [err(i), sm] = estimateMeanPrediction(train_new', test_new');
        %err2(i) = estimateMeanPrediction(train_new', train_new');
        mp2(i) = err(i)
        %sm
        %err(i) = p(current) * estimateNeighbourMean(train_new, social, test_new) ...
        %    + (1-p(current)) * estimateMeanPrediction(train_new, test_new);
        %err(i) = estimateSlopeOne(train_new, test_new);
        sp(i) = err(i);
        %err(i) = estimateSlopeOne(train_new', test_new');
        sp2(i) = err(i);
        %err(i) = estimateALS(train_new,test_new, 50, lds(current));
        al(i) = err(i);
        %err(i) = estimateALS(train_new',test_new', 50, lds(current));
        al2(i) = err(i);
        [err(i), sm] = estimateKNN(train_new, test_new, 7, lds(current), 30);
        kn(i) = err(i)
        %err(i) = estimateKNN(train_new', test_new', 7, lds(current), 35);
        kn2(i) = err(i);
        % err(i) = estimateCombiningAlgorithms(train_new, test_new, 50, 1e5);
        %fprintf('Mean Prediction: %f\nSlope one: %f\nAls: %f\nKNN prediction: %f\n', mp(i), sp(i), al(i), kn(i));
        %fprintf('error %f for lambda = %f\n', err(i), lds(current));
%        perm = circshift(perm, [0, Nk]);
    end
    %fprintf('Mean Prediction: %f %f\nSlope one: %f %f\nAls: %f %f\nKNN prediction: %f %f\n', ...
    %    mean(mp), mean(mp2), mean(sp), mean(sp2), mean(al), mean(al2), mean(kn), mean(kn2));
    testE(mySeed, k) = err(1);
    trainE(mySeed, k) = err2(1);
end
end
end