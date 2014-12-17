function gameState = playerAI_learn(gameResult)
global nn_lsizes
global nn_params
global nn_alpha
global nn_lambda
global gameStateHistory
global moveHistory
global learningCurve

[J grad] = nnCostFunction(nn_params, nn_lsizes, gameStateHistory, moveHistory, nn_lambda);

if (gameResult==2) ac = 1;
else if (gameResult==1) ac = -1;
else ac = 0;
end end

nn_params -= ac*nn_alpha * grad;

learningCurve = [learningCurve J];
gameStateHistory = moveHistory = [];
endfunction

