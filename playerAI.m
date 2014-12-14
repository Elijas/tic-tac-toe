function gameState = playerAI(gameState, playerNo)
if playerNo == 1
    global player1_nn_lsizes
    global player1_nn_params
    global player1_lastGameHistory

    if player1_nn_lsizes(1)==9, nn_input = (  zeros(size(gameState)) + (gameState==playerNo) - (gameState==3-playerNo)  )(:)';
    else if player1_nn_lsizes(1)==18, nn_input = [(gameState==playerNo)(:); (gameState!=playerNo)(:)]'; end end
    
    [moveChoice, moveChoice] = max((gameState(:)'==0) .* nnFeedForward(player1_nn_params, player1_nn_lsizes, nn_input));
    gameState(moveChoice) = playerNo;

    player1_lastGameHistory = [player1_lastGameHistory; nn_input, eye(9)(moveChoice,:)];
else if playerNo == 2
    global player2_nn_lsizes
    global player2_nn_params
    global player2_lastGameHistory

    if player2_nn_lsizes(1)==9, nn_input = (  zeros(size(gameState)) + (gameState==playerNo) - (gameState==3-playerNo)  )(:)';
    else if player2_nn_lsizes(1)==18, nn_input = [(gameState==playerNo)(:); (gameState!=playerNo)(:)]'; end end
    
    [moveChoice, moveChoice] = max((gameState(:)'==0) .* nnFeedForward(player2_nn_params, player2_nn_lsizes, nn_input));
    gameState(moveChoice) = playerNo;

    player2_lastGameHistory = [player2_lastGameHistory; nn_input, eye(9)(moveChoice,:)];
end end
endfunction

