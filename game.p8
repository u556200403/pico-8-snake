pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

-- snake for pico-8

-- game states
state="menu"

function _init()
    reset_game()
end

function reset_game()
    snake={{x=8,y=8}}
    dir={x=1,y=0}
    grow=0
    speed=15
    tick=0
    score=0
    game_over=false
    place_food()
end

function place_food()
    while true do
        food={x=flr(rnd(16)), y=flr(rnd(16))}
        local overlap=false
        for s in all(snake) do
            if s.x==food.x and s.y==food.y then
                overlap=true
                break
            end
        end
        if not overlap then break end
    end
end

function _update()
    if state=="menu" then
        if btnp(4) then
            state="game"
            reset_game()
        end
        return
    end

    if state=="gameover" then
        if btnp(4) then
            state="menu"
        end
        return
    end

    if btnp(⬅️) and dir.x~=1 then dir={x=-1,y=0}
    elseif btnp(➡️) and dir.x~=-1 then dir={x=1,y=0}
    elseif btnp(⬆️) and dir.y~=1 then dir={x=0,y=-1}
    elseif btnp(⬇️) and dir.y~=-1 then dir={x=0,y=1} end

    tick+=1
    if tick>=speed then
        tick=0
        move_snake()
    end
end

function move_snake()
    local head = snake[1]
    local newx = (head.x + dir.x) % 16
    local newy = (head.y + dir.y) % 16
    local new_head = {x=newx, y=newy}

    for s in all(snake) do
        if s.x == new_head.x and s.y == new_head.y then
            state = "gameover"
            return
        end
    end

    -- new head
    for i = #snake, 1, -1 do
        snake[i + 1] = snake[i]
    end
    snake[1] = new_head

    if new_head.x == food.x and new_head.y == food.y then
        score += 1
        grow += 1
        speed = max(2, speed - 1)
        place_food()
    elseif grow > 0 then
        grow -= 1
    else
        deli(snake, #snake)
    end
end

function _draw()
    cls()

    if state=="menu" then
        print("snake",48,40,11)
        print("press z to start",26,60,7)
        return
    elseif state=="gameover" then
        print("game over",38,40,8)
        print("score: "..score,44,52,7)
        print("z -back to menu",28,64,6)
        return
    end

    -- field
    rect(0,0,127,127,5)

    -- food
    rectfill(food.x*8,food.y*8,food.x*8+7,food.y*8+7,8)

    -- snake
    for s in all(snake) do
        rectfill(s.x*8,s.y*8,s.x*8+7,s.y*8+7,11)
    end

    -- score
    print("score: "..score,2,2,7)
end