function gameState = playerHuman(gameState, playerMarker)

disp(gameState)

inputMap = [7 8 9; 4 5 6; 1 2 3];
do
    moveChoice = input('Your move: ');
until (gameState(find(inputMap==moveChoice)) == 0)
gameState(find(inputMap==moveChoice)) = playerMarker;

endfunction

