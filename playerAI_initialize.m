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
    global player1_nn_coef_alphaDepthWeighing_linear
    global player1_nn_coef_alphaDepthWeighing_exponential
    global player1_nn_coef_alphaGradualDecrease_final
    global player1_nn_coef_alphaGradualDecrease_startAfterGameCountFraction
    global player1_nn_useSelectiveBackProp
    global player1_learningCurve

    player1_nn_lsizes = [27 100 100 9];
    player1_nn_params = nnInitParams(player1_nn_lsizes);
    load('playerAI/knowledge/1_80p')

    player1_nn_lambda = .1;
    player1_nn_alpha = 0;
    player1_nn_alpha_coef_win = 1;
    player1_nn_alpha_coef_tie = .01;
    player1_nn_alpha_coef_loss = -.5;
    player1_nn_coef_alphaDepthWeighing_linear = 0; %Positive nums (0 - off). Either this or the other one. They're mutually exclusive
    player1_nn_coef_alphaDepthWeighing_exponential = 0; %Negative nums (0 - off)
    player1_nn_alphaGradualDecrease_final = 1; % (1 - off)
    player1_nn_coef_alphaGradualDecrease_startAfterGameCountFraction = .5;
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
    global player2_nn_coef_alphaDepthWeighing_linear
    global player2_nn_coef_alphaDepthWeighing_exponential
    global player2_nn_coef_alphaGradualDecrease_final
    global player2_nn_coef_alphaGradualDecrease_startAfterGameCountFraction
    global player2_nn_useSelectiveBackProp
    global player2_learningCurve

    player2_nn_lsizes = [9 18 9];
    player2_nn_params = nnInitParams(player2_nn_lsizes);
    %load('playerAI/knowledge/2_last')

    player2_nn_lambda = 0;
    player2_nn_alpha = 2;
    player2_nn_alpha_coef_win = 1;
    player2_nn_alpha_coef_tie = 0;
    player2_nn_alpha_coef_loss = -1;
    player2_nn_coef_alphaDepthWeighing_linear = 0; %Positive nums (0 - off). Either this or the other one. They're mutually exclusive
    player2_nn_coef_alphaDepthWeighing_exponential = 0; %Negative nums (0 - off)
    player2_nn_alphaGradualDecrease_final = 1; % (1 - off)
    player2_nn_coef_alphaGradualDecrease_startAfterGameCountFraction = .3;
    player2_nn_useSelectiveBackProp = false;

    player2_learningCurve = [];
end end
endfunction

