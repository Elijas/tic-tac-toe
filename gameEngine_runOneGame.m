function gameFlag = gameEngine_runOneGame(player1_name, player2_name)
gameFlag = 0; % 0 means the game goes on (no terminal state is reached), -2 for errors, -1 for a tie, positive numbers for a player number that won the game

if (isequal(player1_name, "player_AI"))
player1 = @(gameState, playerMarker) player_AI(gameState, playerMarker);
else if (isequal(player1_name, "player_Random"))
player1 = @(gameState, playerMarker) player_Random(gameState, playerMarker); 
else if (isequal(player1_name, "player_Human"))
player1 = @(gameState, playerMarker) player_Human(gameState, playerMarker); 
else printf("Error: Incorrect Player 1's name: %s\n", player1_name), gameFlag=-2;
end end end
if (isequal(player2_name, "player_AI"))
player2 = @(gameState, playerMarker) player_AI(gameState, playerMarker);
else if (isequal(player2_name, "player_Random"))
player2 = @(gameState, playerMarker) player_Random(gameState, playerMarker); 
else if (isequal(player2_name, "player_Human"))
player2 = @(gameState, playerMarker) player_Human(gameState, playerMarker); 
else printf("Error: Incorrect Player 2's name: %s\n", player2_name), gameFlag=-2;
end end end

gameState = zeros(3,3);
playerMarkers = [1, 2]; % Changed values to this vector must be copied by hand to file "player_AI.m" (didn't automatically pass them for convenience)
playerTurn = 1;

while gameFlag==0
    if playerTurn==1
        [gameState, gameFlag] = gameEngine_checkState(gameState, player1(gameState, playerMarkers(1)), playerTurn, playerMarkers);
    else, if playerTurn==2
        [gameState, gameFlag] = gameEngine_checkState(gameState, player2(gameState, playerMarkers(2)), playerTurn, playerMarkers);
    end, end
    
    if ++playerTurn>2, playerTurn=1; end
end

endfunction
