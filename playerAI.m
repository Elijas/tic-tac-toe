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
else if nn_lsizes(1)==27, nn_input = [(gameState==playerNo)(:); (gameState==3-playerNo)(:); (gameState==0)(:)]';
else if nn_lsizes(1)==45
    features = ((gameState==2) - (gameState==1))(:)';

    extra_features = [];
    for a=1:8
        for b=(a+1):9
            extra_features = [extra_features, ((features(:,a)==features(:,b)&features(:,a)==2) - (features(:,a)==features(:,b)&features(:,a)==1))];
        end
    end

    nn_input = [features extra_features];
end end end end

%disp(gameState),disp(reshape(nnFeedForward(nn_params, nn_lsizes, nn_input),3,3))

[move, move] = max((gameState(:)'==0) .* nnFeedForward(nn_params, nn_lsizes, nn_input));
gameState(move) = playerNo;

gameStateHistory = nn_input;
moveHistory = eye(9)(move,:);

endfunction

