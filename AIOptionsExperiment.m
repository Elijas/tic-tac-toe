function AIOptionsExperiment()
addpath('playerAI')



player_opponent = @(gameState, playerNo) playerRandom(gameState, playerNo);
gameCount = 500;
gameCount_benchmark = 100;
opt_lsizes = [18 50 9;]';
opt_lambda = [0 .001 .01 .1 .5];
opt_alpha = [0 0.1 1 2 3];
opt_acwin = [1];
opt_actie = [0 .5];
opt_acloss = [0 -.1 -.5 -1];
opt_useSelective = [false true];
opt_AIplayerNo = [1];


iteration_current = 1;
iterations_total = size(opt_lsizes,2)*length(opt_lambda)*length(opt_alpha)*length(opt_acwin)*length(opt_actie)*length(opt_acloss)*length(opt_useSelective)*length(opt_AIplayerNo)
RESULTS = [];

global player1_nn_lsizes
global player1_nn_params
global player1_nn_lambda
global player1_nn_alpha
global player1_nn_alpha_coef_win
global player1_nn_alpha_coef_tie
global player1_nn_alpha_coef_loss
global player1_nn_useSelectiveBackProp
global player1_learningCurve
global player2_nn_lsizes
global player2_nn_params
global player2_nn_lambda
global player2_nn_alpha
global player2_nn_alpha_coef_win
global player2_nn_alpha_coef_tie
global player2_nn_alpha_coef_loss
global player2_nn_useSelectiveBackProp
global player2_learningCurve

lsizes_id = 0;
for lsizes = opt_lsizes;
    lsizes_id++;
    lsizes = lsizes';
    lsizes = lsizes(find(lsizes)); % Eliminates zeros in the vector
    for lambda = opt_lambda;
        for alpha = opt_alpha;
            for acwin = opt_acwin;
                for actie = opt_actie;
                    for acloss = opt_acloss;
                        for useSelective = opt_useSelective;
                            for AIplayerNo = opt_AIplayerNo;
                                if AIplayerNo == 1
                                    if iteration_current==1,tic,end
                                    printf("%f\r", iteration_current++/iterations_total*100.); if exist('OCTAVE_VERSION'), fflush(stdout); end
                                    player1 = @(gameState, playerNo) playerAI(gameState, playerNo);
                                    player2 = player_opponent;
                                    player1_nn_lsizes = lsizes;
                                    player1_nn_params = nnInitParams(player1_nn_lsizes);
                                    player1_nn_lambda = lambda;
                                    player1_nn_alpha = alpha;
                                    player1_nn_alpha_coef_win = acwin;
                                    player1_nn_alpha_coef_tie = actie;
                                    player1_nn_alpha_coef_loss = acloss;
                                    player1_nn_useSelectiveBackProp = useSelective;
                                    player1_learningCurve = [];

                                    for i=1:gameCount
                                        gameResult = gameEngine_oneGame(player1, player2);
                                        playerAI_learn(gameResult, AIplayerNo);
                                    end

                                    benchmarkStatistics = [0 0 0];
                                    for i=1:gameCount_benchmark
                                        gameResult = gameEngine_oneGame(player1, player2);
                                        if gameResult == AIplayerNo, benchmarkStatistics(1)++;
                                        else if gameResult == -1,    benchmarkStatistics(3)++;
                                        else,                        benchmarkStatistics(2)++; end end
                                    end

                                    RESULTS = [RESULTS; benchmarkStatistics lsizes_id lambda alpha acwin actie acloss useSelective AIplayerNo];
                                    if iteration_current==2,toc,end
                                else
                                    if iteration_current==1,tic,end
                                    printf("%f\r", iteration_current++/iterations_total*100.); if exist('OCTAVE_VERSION'), fflush(stdout); end
                                    player2 = @(gameState, playerNo) playerAI(gameState, playerNo);
                                    player1 = player_opponent;
                                    player2_nn_lsizes = lsizes;
                                    player2_nn_params = nnInitParams(player1_nn_lsizes);
                                    player2_nn_lambda = lambda;
                                    player2_nn_alpha = alpha;
                                    player2_nn_alpha_coef_win = acwin;
                                    player2_nn_alpha_coef_tie = actie;
                                    player2_nn_alpha_coef_loss = acloss;
                                    player2_nn_useSelectiveBackProp = useSelective;
                                    player2_learningCurve = [];

                                    for i=1:gameCount
                                        gameResult = gameEngine_oneGame(player1, player2);
                                        playerAI_learn(gameResult, AIplayerNo);
                                    end

                                    benchmarkStatistics = [0 0 0];
                                    for i=1:gameCount_benchmark
                                        gameResult = gameEngine_oneGame(player1, player2);
                                        if gameResult == AIplayerNo, benchmarkStatistics(1)++;
                                        else if gameResult == -1,    benchmarkStatistics(3)++;
                                        else,                        benchmarkStatistics(2)++; end end
                                    end

                                    RESULTS = [RESULTS; benchmarkStatistics lsizes_id lambda alpha acwin actie acloss useSelective AIplayerNo];
                                    if iteration_current==2,toc,end
                                end
                                save AIOptionsExperiment_RESULTS RESULTS
                            end
                        end
                    end
                end
            end
        end
    end
end


endfunction

