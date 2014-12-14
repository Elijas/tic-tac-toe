function gameState = playerBoring(gameState, playerNo)

r = round(rand*8+1); % Let's make it a little less boring
for i=1:9
    i = mod(r+i,9)+1;
    if gameState(i)==0
        gameState(i)=playerNo;
        break
    end
end

endfunction

