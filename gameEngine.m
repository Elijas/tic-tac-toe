function gameEngine

player1 = @(gameState, class) player_Random(gameState, class);
player2 = @(gameState, class) player_Random(gameState, class);
classes = ['X', 'O'];

gameState = zeros(3,3)
gameContinues = 0;
playerTurn = 1;

while gameContinues==0
    if playerTurn==1
        [gameState, gameContinues] = \
            gameEngine_checkMoves(gameState, player1(gameState, classes(1)), classes, playerTurn);
    end;
    if playerTurn==2
        [gameState, gameContinues] = \
            gameEngine_checkMoves(gameState, player2(gameState, classes(2)), classes, playerTurn);
    end;
    
    if ++playerTurn>2, playerTurn=1; end;
end

endfunction

