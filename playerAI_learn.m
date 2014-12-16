function gameState = playerAI_learn(gameResult, playerNo)
if playerNo == 1
    global player1_nn_lsizes
    global player1_nn_params
    global player1_nn_lambda
    global player1_nn_alpha
    global player1_nn_alpha_coef_win
    global player1_nn_alpha_coef_tie
    global player1_nn_alpha_coef_loss
    global player1_nn_coef_alphaDepthWeighing_linear
    global player1_nn_coef_alphaDepthWeighing_exponential
    global AIlearn_totalIterations;
    global AIlearn_currIteration;
    global player1_nn_coef_alphaGradualDecrease_final
    global player1_nn_coef_alphaGradualDecrease_startAfterGameCountFraction
    global player1_nn_useSelectiveBackProp
    global player1_totalWins;
    global player1_learningCurve
    global player1_lastGameHistory
    
    if (player1_totalWins == 0) player1_nn_params=nnInitParams(player1_nn_lsizes); end

    lastGameMoves = size(player1_lastGameHistory, 1);
    % Get learning rate coefficients
    a_coef = player1_nn_alpha;
    if (gameResult == playerNo) a_coef *= player1_nn_alpha_coef_win;
    else if (gameResult == -1) a_coef *= player1_nn_alpha_coef_tie;
    else a_coef *= player1_nn_alpha_coef_loss; end end
    
    if (player1_nn_coef_alphaGradualDecrease_final != 1 && AIlearn_currIteration/AIlearn_totalIterations > player1_nn_coef_alphaGradualDecrease_startAfterGameCountFraction) 
        a_coef *= linspace(1,player1_nn_coef_alphaGradualDecrease_final,AIlearn_totalIterations*(1-player1_nn_coef_alphaGradualDecrease_startAfterGameCountFraction)+1)(AIlearn_currIteration-player1_nn_coef_alphaGradualDecrease_startAfterGameCountFraction*AIlearn_currIteration)
    end

    if (player1_nn_coef_alphaDepthWeighing_linear)
        a_coefs = a_coef * linspace( player1_nn_coef_alphaDepthWeighing_linear, 1, lastGameMoves);
    else if (player1_nn_coef_alphaDepthWeighing_exponential)
        a_coefs = a_coef * logspace( player1_nn_coef_alphaDepthWeighing_exponential, 0, lastGameMoves);
    end end

    % Get gradients and learn
    if (player1_nn_coef_alphaDepthWeighing_linear || player1_nn_coef_alphaDepthWeighing_exponential)
        for mv=1:lastGameMoves
            if player1_nn_useSelectiveBackProp
                [J grad] = nnCostFunction_selective(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(mv,1:player1_nn_lsizes(1)), player1_lastGameHistory(mv,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
            else
                [J grad] = nnCostFunction(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(mv,1:player1_nn_lsizes(1)), player1_lastGameHistory(mv,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
            end
            
            player1_nn_params -= a_coefs(mv) * grad;
            player1_learningCurve = [player1_learningCurve J];
        end
    else
        if player1_nn_useSelectiveBackProp
            [J grad] = nnCostFunction_selective(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(:,1:player1_nn_lsizes(1)), player1_lastGameHistory(:,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
        else
            [J grad] = nnCostFunction(player1_nn_params, player1_nn_lsizes, player1_lastGameHistory(:,1:player1_nn_lsizes(1)), player1_lastGameHistory(:,player1_nn_lsizes(1)+1:end), player1_nn_lambda);
        end
        
        player1_nn_params -= a_coef * grad;
        player1_learningCurve = [player1_learningCurve J];
    end

    player1_lastGameHistory = [];
else if playerNo == 2
    global player2_nn_lsizes
    global player2_nn_params
    global player2_nn_lambda
    global player2_nn_alpha
    global player2_nn_alpha_coef_win
    global player2_nn_alpha_coef_tie
    global player2_nn_alpha_coef_loss
    global player2_nn_coef_alphaDepthWeighing_linear
    global player2_nn_coef_alphaDepthWeighing_exponential
    global AIlearn_totalIterations;
    global AIlearn_currIteration;
    global player2_nn_coef_alphaGradualDecrease_final
    global player2_nn_coef_alphaGradualDecrease_startAfterGameCountFraction
    global player2_nn_useSelectiveBackProp
    global player2_totalWins;
    global player2_learningCurve
    global player2_lastGameHistory
    
    if (player2_totalWins == 0) player2_nn_params=nnInitParams(player2_nn_lsizes); end

    lastGameMoves = size(player2_lastGameHistory, 1);
    % Get learning rate coefficients
    a_coef = player2_nn_alpha;
    if (gameResult == playerNo) a_coef *= player2_nn_alpha_coef_win;
    else if (gameResult == -1) a_coef *= player2_nn_alpha_coef_tie;
    else a_coef *= player2_nn_alpha_coef_loss; end end
    
    if (player2_nn_coef_alphaGradualDecrease_final != 1 && AIlearn_currIteration/AIlearn_totalIterations > player2_nn_coef_alphaGradualDecrease_startAfterGameCountFraction) 
        a_coef *= linspace(1,player2_nn_coef_alphaGradualDecrease_final,AIlearn_totalIterations*(1-player2_nn_coef_alphaGradualDecrease_startAfterGameCountFraction)+1)(AIlearn_currIteration-player2_nn_coef_alphaGradualDecrease_startAfterGameCountFraction*AIlearn_currIteration)
    end

    if (player2_nn_coef_alphaDepthWeighing_linear)
        a_coefs = a_coef * linspace( player2_nn_coef_alphaDepthWeighing_linear, 1, lastGameMoves);
    else if (player2_nn_coef_alphaDepthWeighing_exponential)
        a_coefs = a_coef * logspace( player2_nn_coef_alphaDepthWeighing_exponential, 0, lastGameMoves);
    end end

    % Get gradients and learn
    if (player2_nn_coef_alphaDepthWeighing_linear || player2_nn_coef_alphaDepthWeighing_exponential)
        for mv=1:lastGameMoves
            if player2_nn_useSelectiveBackProp
                [J grad] = nnCostFunction_selective(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(mv,1:player2_nn_lsizes(1)), player2_lastGameHistory(mv,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
            else
                [J grad] = nnCostFunction(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(mv,1:player2_nn_lsizes(1)), player2_lastGameHistory(mv,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
            end
            
            player2_nn_params -= a_coefs(mv) * grad;
            player2_learningCurve = [player2_learningCurve J];
        end
    else
        if player2_nn_useSelectiveBackProp
            [J grad] = nnCostFunction_selective(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(:,1:player2_nn_lsizes(1)), player2_lastGameHistory(:,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
        else
            [J grad] = nnCostFunction(player2_nn_params, player2_nn_lsizes, player2_lastGameHistory(:,1:player2_nn_lsizes(1)), player2_lastGameHistory(:,player2_nn_lsizes(1)+1:end), player2_nn_lambda);
        end
        
        player2_nn_params -= a_coef * grad;
        player2_learningCurve = [player2_learningCurve J];
    end

    player2_lastGameHistory = [];
end end
endfunction

