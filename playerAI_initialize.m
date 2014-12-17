function gameState = playerAI_initialize
addpath('playerAI')
global nn_lsizes
global nn_params
global nn_alpha
global nn_lambda
nn_lsizes = [18 30 9];
nn_params = nnInitParams(nn_lsizes);
nn_alpha = .5;
nn_lambda = 0;
endfunction

