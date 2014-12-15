function gameFlag = gameEngine_run(gameCount, player1_name, player2_name)

if (isequal(player1_name, "playerAI")), player1 = @(gameState, playerMarker) playerAI(gameState, playerMarker);
    else if (isequal(player1_name, "playerRandom")), player1 = @(gameState, playerMarker) playerRandom(gameState, playerMarker); 
    else if (isequal(player1_name, "playerHuman")), player1 = @(gameState, playerMarker) playerHuman(gameState, playerMarker); 
else, printf("Error: Incorrect Player 1's name: %s\n", player1_name), gameFlag=-2; end end end
if (isequal(player2_name, "playerAI")), player2 = @(gameState, playerMarker) playerAI(gameState, playerMarker);
    else if (isequal(player2_name, "playerRandom")), player2 = @(gameState, playerMarker) playerRandom(gameState, playerMarker); 
    else if (isequal(player2_name, "playerHuman")), player2 = @(gameState, playerMarker) playerHuman(gameState, playerMarker); 
else printf("Error: Incorrect Player 2's name: %s\n", player2_name), gameFlag=-2; end end end

%if (isequal(player1_name, "playerAI")), 

gameStatistics = [0;0;0]; % Player 1 wins, Player 2 wins, ties
gameStatistics_errors = 0;
gameStatistics_history = [];

for i=1:gameCount
    printf("%d\r",i); if exist('OCTAVE_VERSION'), fflush(stdout); end
    gameResult = gameEngine_oneGame(player1, player2);
    
    if (gameResult == 1), gameStatistics(1)++;
    else if (gameResult == 2), gameStatistics(2)++;
    else if (gameResult == -1), gameStatistics(3)++;
    else, gameStatistics_errors++; end end end
    gameStatistics_history = [gameStatistics_history gameStatistics];
end

printf("%s: %d, %s: %d, ties: %d\n", player1_name, gameStatistics(1), player2_name, gameStatistics(2), gameStatistics(3)); if gameStatistics_errors, printf("[Errors: %d]\n", gameStatistics_errors), end;
close all;hold on;
gameStatistics_history ./= ones(3, 1) * sum(gameStatistics_history, 1);
plot(gameStatistics_history(1,:), 'r')
plot(gameStatistics_history(2,:), 'b')
plot(gameStatistics_history(3,:), 'k')
legend(player1_name, player2_name, 'ties')
xlabel('Games')

endfunction
