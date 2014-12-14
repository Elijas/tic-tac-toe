function gameFlag = gameEngine_run(gameCount, player1_name, player2_name)

if (isequal(player1_name, "playerAI")), player1 = @(gameState, playerNo) playerAI(gameState, playerNo);
    else if (isequal(player1_name, "playerRandom")), player1 = @(gameState, playerNo) playerRandom(gameState, playerNo); 
    else if (isequal(player1_name, "playerHuman")), player1 = @(gameState, playerNo) playerHuman(gameState, playerNo); 
    else if (isequal(player1_name, "playerBoring")), player1 = @(gameState, playerNo) playerBoring(gameState, playerNo);
else, printf("Error: Incorrect Player 1's name: %s\n", player1_name), gameFlag=-2; end end end end
if (isequal(player2_name, "playerAI")), player2 = @(gameState, playerNo) playerAI(gameState, playerNo);
    else if (isequal(player2_name, "playerRandom")), player2 = @(gameState, playerNo) playerRandom(gameState, playerNo); 
    else if (isequal(player2_name, "playerHuman")), player2 = @(gameState, playerNo) playerHuman(gameState, playerNo); 
    else if (isequal(player2_name, "playerBoring")), player2 = @(gameState, playerNo) playerBoring(gameState, playerNo);
else printf("Error: Incorrect Player 2's name: %s\n", player2_name), gameFlag=-2; end end end end

if isequal(player1_name, "playerAI"), playerAI_initialize(1); end
if isequal(player2_name, "playerAI"), playerAI_initialize(2); end


gameStatistics = [0;0;0]; % Player 1 wins, Player 2 wins, ties
gameStatistics_errors = 0;
gameStatistics_results = [];

for i=1:gameCount
    printf("%d\r",i); if exist('OCTAVE_VERSION'), fflush(stdout); end
    gameResult = gameEngine_oneGame(player1, player2);
    
    if isequal(player1_name, "playerAI"), playerAI_learn(gameResult, 1); end
    if isequal(player2_name, "playerAI"), playerAI_learn(gameResult, 2); end
    
    if gameResult == 1, gameStatistics(1)++;
    else if gameResult == 2, gameStatistics(2)++;
    else if gameResult == -1, gameStatistics(3)++;
    else, gameStatistics_errors++; end end end
    gameStatistics_results = [gameStatistics_results gameStatistics];
end


close all;
fig=1;

if isequal(player1_name, "playerAI"),
    global player1_nn_params
    global player1_nn_lsize
    save playerAI_1_knowledge player1_nn_params player1_nn_lsize
    global player1_learningCurve
    figure(fig++);
    plot(player1_learningCurve);
end
if isequal(player2_name, "playerAI"), 
    global player2_nn_params
    global player2_nn_lsize
    save playerAI_2_knowledge player2_nn_params player2_nn_lsize
    global player2_learningCurve
    figure(fig++);
    plot(player2_learningCurve);
end

printf("%s: %d, %s: %d, ties: %d\n", player1_name, gameStatistics(1), player2_name, gameStatistics(2), gameStatistics(3)); if gameStatistics_errors, printf("[Errors: %d]\n", gameStatistics_errors), end;

figure(fig++);
subplot(1,2,1);hold on;
plot(gameStatistics_results(1,:), 'r')
plot(gameStatistics_results(2,:), 'g')
plot(gameStatistics_results(3,:), 'k')
legend(player1_name, player2_name, 'ties')
xlabel('Games played')
ylabel('Games won')

subplot(1,2,2);hold on;
gameStatistics_results ./= ones(3, 1) * sum(gameStatistics_results, 1);
plot(gameStatistics_results(1,:), 'r')
plot(gameStatistics_results(2,:), 'g')
plot(gameStatistics_results(3,:), 'k')
legend(player1_name, player2_name, 'ties')
xlabel('Games played')
ylabel('Fraction of games won')

endfunction

