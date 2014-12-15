function gameState = playerRandom(gameState, playerMarker)

if sum((gameState==0)(:))==0, return, end %Sanity check (don't enter an endless loop if there is no way out)
while true
    r=round(rand*(length(gameState(:))-1)+1);
    if gameState(r)==0
        gameState(r)=playerMarker;
        break
    end
end

endfunction
