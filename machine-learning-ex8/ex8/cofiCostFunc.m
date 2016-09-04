function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

% UNVECTORIZED
% for i = 1:size(X, 1)
%     x_i = X(i, :);
%     for j = 1:size(Theta, 1)
%         if R(i, j) == 0
%             continue
%         end
%         theta_j = Theta(j, :);
%         J = J + (x_i * theta_j' - Y(i, j))^2;
%     end
% end
% 
% J = J / 2;

% Vectorized cost J
J = 1/2 * sum(sum(((X * Theta' - Y) .^ 2) .* R))

% Compute the gradients
X_grad = ((X * Theta' - Y) .* R) * Theta;
Theta_grad = ((X * Theta' - Y) .* R)' * X;

% Regularize the cost J
% theta_inner_sum = (sum(Theta * Theta'));

J = J + lambda/2 * ( sum(theta_inner_sum(1:end)) + sum(sum(X * X'))  );   
reg1 = 0;
for i = 1:num_movies
    for k = 1:num_features
        reg1 = reg1 + X(i, k)^2;
    end
end
reg1 = reg1 * lambda / 2;

reg2 = 0;
for j = 1:num_users
    for k = 1:num_features
        reg2 = reg2 + Theta(j, k)^2;
    end
end
reg2 = reg2 * lambda / 2;

J = J + reg1 + reg2;


% Regularize gradient
X_grad = X_grad + lambda * X;
Theta_grad = Theta_grad + lambda * Theta;
% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
