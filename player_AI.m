function gameState = player_AI(gameState, playerMarker)

playerMarkers = [1, 2];

nn_input = (zeros(size(gameState)) + (gameState==playerMarkers(find(playerMarkers==playerMarker))) - (gameState==playerMarkers(playerMarkers!=playerMarker)) )(:)';
%nn_input = [(gameState==playerMarkers(find(playerMarkers==playerMarker)))(:); (gameState==playerMarkers(playerMarkers!=playerMarker))(:)]';
nn_lsizes = [length(nn_input) length(gameState(:))];
    
[moveChoice, moveChoice] = max((gameState(:)'==0) .* nnFeedForward(nnInitParams(nn_lsizes), nn_lsizes, nn_input));
gameState(moveChoice) = playerMarker;

endfunction
