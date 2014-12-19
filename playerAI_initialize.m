function gameState = playerAI_initialize
addpath('playerAI')
global nn_lsizes
global nn_params
global nn_alpha
global nn_lambda
global learningCurve
nn_lsizes = [27 9];
nn_params = nnInitParams(nn_lsizes);
load('playerAI/knowledge/K2')
nn_alpha = 0;
nn_lambda = 0;
learningCurve=[];
endfunction

