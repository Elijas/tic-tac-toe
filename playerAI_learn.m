function gameState = playerAI_learn

%{
global playerMarkers

nn_input = (zeros(size(gameState)) + (gameState==playerMarkers(find(playerMarkers==playerMarker))) - (gameState==playerMarkers(playerMarkers!=playerMarker)) )(:)';
%nn_input = [(gameState==playerMarkers(find(playerMarkers==playerMarker)))(:); (gameState==playerMarkers(playerMarkers!=playerMarker))(:)]';
nn_lsizes = [length(nn_input) length(gameState(:))];
    
[moveChoice, moveChoice] = max((gameState(:)'==0) .* nnFeedForward(nnInitParams(nn_lsizes), nn_lsizes, nn_input));
gameState(moveChoice) = playerMarker;


% Experiment 4: Large Neural Network
sFirst = size(X,2);     % Units in the first layer
sLast = max(y);         % Units in the last layer
yExp = eye(sLast)(y,:); % Expand yExp to binaryExp vectors (to prepare for NN learning)
yExp_test = eye(sLast)(y_test,:);

nn_lambda = .5;
nn_options = optimset('MaxIter', 10000);
printf("# Experiment No.4: Training a Large NN\n")
printf("Training...  (lambda = %g, iteration limit = %d)\n", nn_lambda, nn_options.MaxIter);
nn_lsizes = [sFirst 8 8 8 8 sLast];
nn_lsizes = nn_lsizes(find(nn_lsizes)); % Eliminates zeros in the vector
    
nn_params = fmincg(@(p) nnCostFunction(p, nn_lsizes, X, yExp, nn_lambda), nnInitParams(nn_lsizes), nn_options);
    
accuracyExp = mean(  (  yExp==round(nnFeedForward(nn_params, nn_lsizes, X))  )(:)  );
accuracyExp_test = mean(  (  yExp_test==round(nnFeedForward(nn_params, nn_lsizes, X_test))  )(:)  );
printf(" %d", nn_lsizes), printf("\t| %10.2f%% | %10.2f%%\n", accuracyExp*100, accuracyExp_test*100);


%}
endfunction
