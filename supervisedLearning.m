function supervisedLearning
addpath('playerAI')

load('LEARNING_INPUT')
load('LEARNING_OUTPUT')
LEARNING_OUTPUT = LEARNING_INPUT != LEARNING_OUTPUT;

nn_lsizes = [45 60 9];
nn_lambda = .0001;

if nn_lsizes(1)==9, LEARNING_INPUT = (LEARNING_INPUT==2) - (LEARNING_INPUT==1);
else if nn_lsizes(1)==18, LEARNING_INPUT = [(LEARNING_INPUT==2) (LEARNING_INPUT==1)];
else if nn_lsizes(1)==27, LEARNING_INPUT = [(LEARNING_INPUT==2) (LEARNING_INPUT==1) (LEARNING_INPUT==0)]; 
else if nn_lsizes(1)==45
    features = (LEARNING_INPUT==2) - (LEARNING_INPUT==1);

    extra_features = [];
    for a=1:8
        for b=(a+1):9
            extra_features = [extra_features, ((features(:,a)==features(:,b)&features(:,a)==2) - (features(:,a)==features(:,b)&features(:,a)==1))];
        end
    end

    LEARNING_INPUT = [features extra_features];
end end end end

nn_options = optimset('MaxIter', 10000);
nn_params = fmincg(@(p) nnCostFunction(p, nn_lsizes, LEARNING_INPUT, LEARNING_OUTPUT, nn_lambda), nnInitParams(nn_lsizes), nn_options);

%{
nn_params = nnInitParams(nn_lsizes);
nn_alpha = .0001;
for a=1:10
    for b=1:size(LEARNING_INPUT,1)
        printf('%d %d \r', a, b); if exist('OCTAVE_VERSION'), fflush(stdout); end
        [J grad] = nnCostFunction(nn_params, nn_lsizes, LEARNING_INPUT(b,:), LEARNING_OUTPUT(b,:), nn_lambda);
        nn_params -= nn_alpha * grad;
    end
end
%}

save playerAI/knowledge/K2 nn_lsizes nn_params
endfunction

