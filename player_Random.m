function gameState_new = player_Random(gameState, class)
gameState_new=gameState;

if sum((gameState==0)(:))==0, return, end %Sanity check (don't enter an endless loop if there is no way out)
while true
    r=round(rand*(length(gameState(:))-1)+1);
    if gameState(r)==0
        gameState_new(r)=class;
        break
    end
end

endfunction
