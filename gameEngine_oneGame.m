function gameFlag = gameEngine_oneGame(player1, player2)
gameFlag = 0; % 0 means the game goes on (no terminal state is reached), -2 for errors, -1 for a tie, positive numbers for a player number that won the game

gameState = zeros(3,3);
global playerMarkers;
playerMarkers = [1, 2];
playerTurn = 1;

while gameFlag==0
    if playerTurn==1
        [gameState, gameFlag] = gameEngine_checkState(gameState, player1(gameState, playerMarkers(1)), playerTurn);
    else, if playerTurn==2
        [gameState, gameFlag] = gameEngine_checkState(gameState, player2(gameState, playerMarkers(2)), playerTurn);
    end, end
    
    if ++playerTurn>2, playerTurn=1; end
end

endfunction
