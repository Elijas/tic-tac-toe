function gameFlag = gameEngine_oneGame(player1, player2)
gameFlag = 0; % 0 means the game goes on (no terminal state is reached yet), -2 for errors, -1 for a tie, positive numbers for a player number that won the game

gameState = zeros(3,3);
playerNo_current = 1;



sub_gameFlag = -1;
if 1
    while true
        if (sub_gameFlag != 0), sub_gameFlag = 0;sub_gameState = zeros(3,3);sub_playerNo_current = 1; end
        if sub_playerNo_current==1
            [sub_gameState, sub_gameFlag] = gameEngine_checkTerminal(sub_gameState, playerRandom(sub_gameState, 1), sub_playerNo_current);
        else, if sub_playerNo_current==2 
            [sub_gameState, sub_gameFlag] = gameEngine_checkTerminal(sub_gameState, playerRandom(sub_gameState, 2), sub_playerNo_current);
        end end
        sub_moveNo = sum(0<sub_gameState(:));
        if ++sub_playerNo_current>2, sub_playerNo_current=1; end
        if( sub_gameFlag==0 && sub_moveNo==7)    

            [gS, flag1] = gameEngine_checkTerminal(sub_gameState, playerRandom(sub_gameState, 2), 2);
            do
                gS2=[];
                [gS2, flag2] = gameEngine_checkTerminal(sub_gameState, playerRandom(sub_gameState, 2), 2);
            until (!isequal(gS,gS2))

            
            if ((flag1==2 || flag2==2) && !((flag1==2 && flag2==2)))

                gameState = sub_gameState;
                playerNo_current = 2;
                break;
            end
        end
    end
else if 0
    r=round(-.5+rand*(-1e-2+ 2));
    if r==0, gameState = [2 1 1;2 1 2; 0 0 1]; 
    else if r==1, gameState = [1 2 1;2 0 0; 1 2 2]; 
    end end
    playerNo_current = 2;
else
    r=round(-.5+rand*(-1e-2+ 6));
    gS1 = [2 1 1;2 1 2; 0 0 1]; gS2 = [1 2 1;2 0 0; 1 2 2];
    if r==0, gameState = gS1; 
    else if r==1, gameState = gS2;
    else if r==2, gameState = flipud(gS1); 
    else if r==3, gameState = flipud(gS2); 
    else if r==4, gameState = fliplr(gS1); 
    else if r==5, gameState = fliplr(gS2); 
    end end end end end end
    playerNo_current = 2;
end end

while gameFlag==0
    if playerNo_current==1
        [gameState, gameFlag] = gameEngine_checkTerminal(gameState, player1(gameState, 1), playerNo_current);
    else, if playerNo_current==2
        [gameState, gameFlag] = gameEngine_checkTerminal(gameState, player2(gameState, 2), playerNo_current);
    end, end
    
    if ++playerNo_current>2, playerNo_current=1; end
end
endfunction

