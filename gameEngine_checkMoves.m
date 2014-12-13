function [gameState_new gameContinues] = gameEngine_checkMoves(gameState, gameState_new, playerTurn, classes)
gameContinues = 0;

printf("player %d: ",playerTurn),gameState_new

%Checks whether legal moves were made
if sum((gameState != gameState_new)(:)) != 1
    printf('Illegal move: No moves or more than one move is made!\n')
    gameContinues = -2;
end
if gameState_new(find(gameState != gameState_new)) != classes(playerTurn)
    printf('Illegal move: Played not as yourself!\n')
    gameContinues = -2;
end
if gameContinues!=0, return, end

%Checks whether terminal state is reached
% Win conditions
for c=classes
    for i=1:3
        if gameState_new(i,:)(:) == ones(3,1) * c, gameContinues = find(classes==c); break, end
        if gameState_new(:,i)(:) == ones(3,1) * c, gameContinues = find(classes==c); break, end
    end
    if gameState_new(find(eye(3)))(:) == ones(3,1) * c, gameContinues = find(classes==c); break, end
    if gameState_new(find(flipud(eye(3))))(:) == ones(3,1) * c, gameContinues = find(classes==c); break, end
end
% Tie Conditions
if sum((gameState_new==0)(:))==0, gameContinues = -1; end

if gameContinues>0, printf('Game ended: Player %d has won!\n', gameContinues), end
if gameContinues<0, printf('Game ended: A Tie!\n'), end

endfunction
