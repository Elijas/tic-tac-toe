function gameState = playerAI_initialize(playerNo)

addpath('playerAI')

if playerNo == 1
    global player1_nn_lsizes
    global player1_nn_params
    global player1_nn_lambda
    global player1_nn_alpha
    %player1_nn_lsizes = [18 400 200 100 9];
    %player1_nn_params = nnInitParams(player1_nn_lsizes);
    load('playerAI_1_knowledge')
    player1_nn_lambda = .003;
    player1_nn_alpha = .01;
else if playerNo == 2
    global player2_nn_lsizes
    global player2_nn_params
    global player2_nn_lambda
    global player2_nn_alpha
    player2_nn_lsizes = [18 600 400 200 9];
    player2_nn_params = nnInitParams(player2_nn_lsizes);
    %load('playerAI_2_knowledge')
    player2_nn_lambda = .003;
    player2_nn_alpha = .01;
end end

endfunction

