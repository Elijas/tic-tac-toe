function gameFlag = gameEngine_oneGame(player1, player2)
gameFlag = 0; % 0 means the game goes on (no terminal state is reached yet), -2 for errors, -1 for a tie, positive numbers for a player number that won the game

gameState = zeros(3,3);
playerNo_current = 1;

while gameFlag==0
    if playerNo_current==1
        [gameState, gameFlag] = gameEngine_checkTerminal(gameState, player1(gameState, 1), playerNo_current);
    else, if playerNo_current==2
        [gameState, gameFlag] = gameEngine_checkTerminal(gameState, player2(gameState, 2), playerNo_current);
    end, end
    
    if ++playerNo_current>2, playerNo_current=1; end
end
endfunction

