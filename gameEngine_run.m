function gameFlag = gameEngine_run(player1_name, player2_name, gameCount=1)
if      (isequal(player1_name, "playerAI")), player1 = @(gameState, playerNo) playerAI(gameState, playerNo);
else if (isequal(player1_name, "playerRandom")), player1 = @(gameState, playerNo) playerRandom(gameState, playerNo); 
else if (isequal(player1_name, "playerHuman")), player1 = @(gameState, playerNo) playerHuman(gameState, playerNo); 
else if (isequal(player1_name, "playerBoring")), player1 = @(gameState, playerNo) playerBoring(gameState, playerNo);
else    printf("Error: Incorrect Player 1's name: %s\n", player1_name), gameFlag=-2; end end end end
if      (isequal(player2_name, "playerAI")), player2 = @(gameState, playerNo) playerAI(gameState, playerNo);
else if (isequal(player2_name, "playerRandom")), player2 = @(gameState, playerNo) playerRandom(gameState, playerNo); 
else if (isequal(player2_name, "playerHuman")), player2 = @(gameState, playerNo) playerHuman(gameState, playerNo); 
else if (isequal(player2_name, "playerBoring")), player2 = @(gameState, playerNo) playerBoring(gameState, playerNo);
else    printf("Error: Incorrect Player 2's name: %s\n", player2_name), gameFlag=-2; end end end end

global isAIPlaying
isAIPlaying = isequal(player1_name, "playerAI") || isequal(player2_name, "playerAI");
if isAIPlaying, playerAI_initialize; end

global isHumanPlaying % Will be used to turn on/off UI features
isHumanPlaying = isequal(player1_name, "playerHuman") || isequal(player2_name, "playerHuman");
if isHumanPlaying, printf("Instructions: Use your numpad to play\n"); end

gameStatistics = [0;0;0]; % Data stored: player1 wins, player2 wins, ties
gameStatistics_errors = 0; % Terminal states reached because of system/player failures (bugs)
gameStatistics_results = [];

for i=1:gameCount
    printf("%d\r",i); if exist('OCTAVE_VERSION'), fflush(stdout); end
    
    gameResult = gameEngine_oneGame(player1, player2);
    
    if isAIPlaying, playerAI_learn(gameResult); end
    
    if gameResult == 1, gameStatistics(1)++;
    else if gameResult == 2, gameStatistics(2)++;
    else if gameResult == -1, gameStatistics(3)++;
    else, gameStatistics_errors++; end end end
    gameStatistics_results = [gameStatistics_results gameStatistics];
end

if isAIPlaying
    global nn_lsizes
    global nn_params
    save playerAI/knowledge/last nn_lsizes nn_params
end

if !isHumanPlaying && gameCount>1
    close all;
    
    printf("%s: %d, %s: %d, ties: %d\n", player1_name, gameStatistics(1), player2_name, gameStatistics(2), gameStatistics(3));
    if gameStatistics_errors, printf("[Errors: %d]\n", gameStatistics_errors), end;
    
    subplot(2,2,1);
    hold on;
    plot(gameStatistics_results(1,:), 'r')
    plot(gameStatistics_results(2,:), 'g')
    plot(gameStatistics_results(3,:), 'k')
    legend(player1_name, player2_name, 'ties')
    xlabel('Games played')
    ylabel('Games won')
    
    gameStatistics_results ./= ones(3, 1) * sum(gameStatistics_results, 1);
    subplot(2,2,2);
    hold on;
    plot(gameStatistics_results(1,:), 'r')
    plot(gameStatistics_results(2,:), 'g')
    plot(gameStatistics_results(3,:), 'k')
    legend(player1_name, player2_name, 'ties')
    xlabel('Games played')
    ylabel('Fraction of games won')
    
    if isAIPlaying
        global learningCurve
        subplot(2,2,3:4);
        plot(learningCurve);
    end
end
endfunction

