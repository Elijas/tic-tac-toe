function gameState = playerAI_learn(gameResult, playerNo)

if playerNo == 1
    global player1_nn_lsizes
    global player1_nn_params
    global player1_nn_lambda
    global player1_nn_options
    global player1_nn_alpha
    global player1_lastGameHistory
    global player1_learningCurve
    [J grad] = nnCostFunction(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(:,1:player1_nn_lsizes(1)), player1_lastGameHistory(:,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
    player1_learningCurve = [player1_learningCurve J];
    
    if (gameResult == playerNo) alpha_coef = 1;
    else if (gameResult == -1) alpha_coef = 1;
    else alpha_coef = -1; end end

    player1_nn_params -= (alpha_coef * player1_nn_alpha) * grad;
    player1_lastGameHistory = [];
else if playerNo == 2
    global player2_nn_lsizes
    global player2_nn_params
    global player2_nn_lambda
    global player2_nn_options
    global player2_nn_alpha
    global player2_lastGameHistory
    global player2_learningCurve
    [J grad] = nnCostFunction(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(:,1:player2_nn_lsizes(1)), player2_lastGameHistory(:,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
    player2_learningCurve = [player2_learningCurve J];

    if (gameResult == playerNo) alpha_coef = 1;
    else if (gameResult == -1) alpha_coef = 1;
    else alpha_coef = -1; end end

    player2_nn_params -= (alpha_coef * player2_nn_alpha) * grad;
    player2_lastGameHistory = [];
end end

endfunction

