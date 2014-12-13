function gameState_new = player_Random(gameState, class)
gameState_new=gameState;

for i=1:length(gameState(:))
    if gameState(i)==0
        gameState_new(i)=class;
        break
    end
end

endfunction

