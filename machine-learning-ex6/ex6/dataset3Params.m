function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 0.01;
sigma = 0.01;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%


C_arr = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
Sigma_arr = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

C_final = 0;
Sigma_final = 0;
min_error = 1;

for i = 1:length(C_arr)
    C = C_arr(i);
    for j = 1:length(Sigma_arr)
        sigma = Sigma_arr(j);
        model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
%         visualizeBoundary(X, y, model);
        
%         fprintf('Program paused. Press enter to continue.\n');
%         pause;
        
        % Determine the predicted values
        predictions = svmPredict(model, Xval);
        error = mean(double(predictions ~= yval));
        
        if error <= min_error
            min_error = error;
            C_final = C;
            Sigma_final = sigma;
        end
    end
end

display('Min error found');
display(min_error);
C = C_final;
sigma = Sigma_final;




% =========================================================================

end
