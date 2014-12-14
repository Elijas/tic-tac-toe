function [gameState_new gameFlag] = gameEngine_checkTerminal(gameState, gameState_new, playerNo_current)
gameFlag = 0;

%DEBUG
%printf("player %d: ",playerNo_current),gameState_new

%Checks whether legal moves were made
if sum((gameState != gameState_new)(:)) != 1
    printf('Illegal move: No moves or more than one move is made!\n')
    gameFlag = -2;
end
if gameState_new(find(gameState != gameState_new)) != playerNo_current
    printf('Illegal move: Played not as yourself!\n')
    gameFlag = -2;
end
if gameFlag!=0, return, end

%Checks whether terminal state is reached
% Win conditions
for playerNo=1:2
    for i=1:3
        if gameState_new(i,:)(:) == ones(3,1) * playerNo, gameFlag = playerNo; break, end
        if gameState_new(:,i)(:) == ones(3,1) * playerNo, gameFlag = playerNo; break, end
    end
    if gameState_new(find(eye(3)))(:) == ones(3,1) * playerNo, gameFlag = playerNo; break, end
    if gameState_new(find(flipud(eye(3))))(:) == ones(3,1) * playerNo, gameFlag = playerNo; break, end
end
% Tie Conditions
if sum((gameState_new==0)(:))==0, gameFlag = -1; end

%DEBUG
%if gameFlag>0, printf('Game ended: Player %d has won!\n', gameFlag), end
%if gameFlag<0, printf('Game ended: Tie!\n'), end

endfunction
