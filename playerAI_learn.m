function gameState = playerAI_learn(gameResult, playerNo)
if playerNo == 1
    global player1_nn_lsizes
    global player1_nn_params
    global player1_nn_lambda
    global player1_nn_alpha
    global player1_nn_alpha_coef_win
    global player1_nn_alpha_coef_tie
    global player1_nn_alpha_coef_loss
    global player1_nn_useSelectiveBackProp
    global player1_learningCurve
    global player1_lastGameHistory

    % Get gradients
    if player1_nn_useSelectiveBackProp
        [J grad] = nnCostFunction_selective(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(:,1:player1_nn_lsizes(1)), player1_lastGameHistory(:,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
    else
        [J grad] = nnCostFunction(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(:,1:player1_nn_lsizes(1)), player1_lastGameHistory(:,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
    end

    % Get learning rate
    if (gameResult == playerNo) a_coef = player1_nn_alpha_coef_win;
    else if (gameResult == -1) a_coef = player1_nn_alpha_coef_tie;
    else a_coef = player1_nn_alpha_coef_loss; end end

    % Update parameters with the learning-rate-adjusted gradients
    player1_nn_params -= (player1_nn_alpha * a_coef) * grad;

    % Update data structures (since one game has ended)
    player1_lastGameHistory = [];
    player1_learningCurve = [player1_learningCurve J];
else if playerNo == 2
    global player2_nn_lsizes
    global player2_nn_params
    global player2_nn_lambda
    global player2_nn_alpha
    global player2_nn_alpha_coef_win
    global player2_nn_alpha_coef_tie
    global player2_nn_alpha_coef_loss
    global player2_nn_useSelectiveBackProp
    global player2_learningCurve
    global player2_lastGameHistory

    % Get gradients
    if player2_nn_useSelectiveBackProp
        [J grad] = nnCostFunction_selective(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(:,1:player2_nn_lsizes(1)), player2_lastGameHistory(:,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
    else
        [J grad] = nnCostFunction(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(:,1:player2_nn_lsizes(1)), player2_lastGameHistory(:,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
    end

    % Get learning rate
    if (gameResult == playerNo) a_coef = player2_nn_alpha_coef_win;
    else if (gameResult == -1) a_coef = player2_nn_alpha_coef_tie;
    else a_coef = player2_nn_alpha_coef_loss; end end

    % Update parameters with the learning-rate-adjusted gradients
    player2_nn_params -= (player2_nn_alpha * a_coef) * grad;

    % Update data structures (since one game has ended)
    player2_lastGameHistory = [];
    player2_learningCurve = [player2_learningCurve J];
end end
endfunction

