function supervisedLearning
addpath('playerAI')

load('LEARNING_INPUT')
load('LEARNING_OUTPUT')
LEARNING_OUTPUT = LEARNING_INPUT != LEARNING_OUTPUT;

nn_lsizes = [9 400 400 9];
nn_lambda = .0001;

if nn_lsizes(1)==9, LEARNING_INPUT = (LEARNING_INPUT==2) - (LEARNING_INPUT==1);
else if nn_lsizes(1)==18, LEARNING_INPUT = [(LEARNING_INPUT==2) (LEARNING_INPUT==1)];
else if nn_lsizes(1)==27, LEARNING_INPUT = [(LEARNING_INPUT==2) (LEARNING_INPUT==1) (LEARNING_INPUT==0)]; end end end

nn_options = optimset('MaxIter', 150);
%nn_params = fmincg(@(p) nnCostFunction(p, nn_lsizes, LEARNING_INPUT, LEARNING_OUTPUT, nn_lambda), nnInitParams(nn_lsizes), nn_options);

nn_params = nnInitParams(nn_lsizes);
nn_alpha = .01;
for a=1:1
    for b=1:size(LEARNING_INPUT,1)
        printf('%d\r', b); if exist('OCTAVE_VERSION'), fflush(stdout); end
        [J grad] = nnCostFunction(nn_params, nn_lsizes, LEARNING_INPUT(b,:), LEARNING_OUTPUT(b,:), nn_lambda);
        nn_params -= nn_alpha * grad;
    end
end

save playerAI/knowledge/K nn_lsizes nn_params
endfunction

