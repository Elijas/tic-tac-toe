function gameState = playerAI_initialize(playerNo)
addpath('playerAI')
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

    player1_nn_lsizes = [18 50 9];
    player1_nn_params = nnInitParams(player1_nn_lsizes);
    %load('playerAI/knowledge/1_last')

    player1_nn_lambda = .003;
    player1_nn_alpha = 2;
    player1_nn_alpha_coef_win = 1;
    player1_nn_alpha_coef_tie = 0.1;
    player1_nn_alpha_coef_loss = 0;
    player1_nn_useSelectiveBackProp = false;

    player1_learningCurve = [];
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

    player2_nn_lsizes = [18 400 400 9];
    player2_nn_params = nnInitParams(player2_nn_lsizes);
    %load('playerAI/knowledge/2_last')

    player2_nn_lambda = .003;
    player2_nn_alpha = .01;
    player2_nn_alpha_coef_win = 1;
    player2_nn_alpha_coef_tie = 0;
    player2_nn_alpha_coef_loss = 0;
    player2_nn_useSelectiveBackProp = true;

    player2_learningCurve = [];
end end
endfunction

