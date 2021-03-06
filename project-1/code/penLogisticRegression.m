function beta = penLogisticRegression(y,tX,alpha,lambda, maxIter)
%penLogisticRegression - penalized logistic regression using gradient descent
%
%       beta = penLogisticRegression(y,tX,alpha,lambda)
if ~exist('maxIter', 'var')
    maxIter = 1000;
end

[N,D]=size(tX);
beta = zeros(D,1);
for i = 1:maxIter
    gradient = (-tX'*(y - sigmoid(tX*beta))+lambda*beta)/N;
    if norm(gradient) < 1e-6
        fprintf('finished early\n');
        return;
    end
    H = computeHessian(tX,beta)+eye(length(beta))*lambda/length(y);
    tmp = H\gradient;
    beta = beta-alpha*tmp;
end
end