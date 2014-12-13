function gameState_new = player_Random(gameState, class)
gameState_new=gameState;

for i=1:length(gameState(:))
    r=round(rand*(length(gameState(:))-1)+1);
    if gameState(r)==0
        gameState_new(r)=class;
        break
    end
end

endfunction

