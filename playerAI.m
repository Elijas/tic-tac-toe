function gameState = playerAI(gameState, playerNo)

if sum((gameState==0)(:))==0, return, end %Sanity check (don't enter an endless loop if there is no way out)
while true
    r=round(rand*(length(gameState(:))-1)+1);
    if gameState(r)==0
        gameState(r)=playerNo;
        break
    end
end

endfunction

