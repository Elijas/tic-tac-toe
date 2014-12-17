function gameState = playerAI(gameState, playerNo)
global nn_lsizes
global nn_params
global nn_alpha
global nn_lambda
global gameStateHistory
global moveHistory


%moveNo = sum(0<gameState(:));
if nn_lsizes(1)==9, nn_input = ( zeros(size(gameState)) + (gameState==playerNo) - (gameState==3-playerNo) )(:)';
else if nn_lsizes(1)==18, nn_input = [(gameState==playerNo)(:); (gameState==3-playerNo)(:)]';
else if nn_lsizes(1)==27, nn_input = [(gameState==playerNo)(:); (gameState==3-playerNo)(:); (gameState==0)(:)]'; end end end

[move, move] = max((gameState(:)'==0) .* nnFeedForward(nn_params, nn_lsizes, nn_input));
gameState(move) = playerNo;

gameStateHistory = nn_input;
moveHistory = eye(9)(move,:);

endfunction

