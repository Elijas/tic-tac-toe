function [grad_est] = nnGradientCheck(nn_params, nn_lsizes, X, y, lambda)

epsilon = 0.001;
grad_est = zeros(length(nn_params),1);
for i=1:length(nn_params)
    PLUS_nn_params = MINUS_nn_params = nn_params;

    PLUS_nn_params(i) += epsilon;
    MINUS_nn_params(i) -= epsilon;
    
    PLUS_cost = nnCostFunction_selective(PLUS_nn_params, nn_lsizes, X, y, lambda);
    MINUS_cost = nnCostFunction_selective(MINUS_nn_params, nn_lsizes, X, y, lambda);
    
    grad_est(i) = ( PLUS_cost - MINUS_cost ) / (2*epsilon);
end

endfunction

