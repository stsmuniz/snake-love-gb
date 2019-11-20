local snakeX = 10
local snakeY = 10

local dirX = 0
local dirY = 0

local SIZE = 25

local eggX = 200
local eggY = 150

local minPosX = 200
local minPosY = 150
local maxPosX = 750
local maxPosY = 600

local gameOverTimer = 0
local killSoundPlayed = false

local tail = {}
local tail_length = 0

local introPlayed = false

local egg = love.graphics.newImage("assets/egg_sprite.png")

score = 0
hiScore = 0

if love.filesystem.getInfo("snake_hiscore.txt") then
    hiScore = tonumber(love.filesystem.read("snake_hiscore.txt"), 10)
end

up = false
down = false
left = false
right = false

function add_egg()
    eggX = love.math.random(minPosX / SIZE, (maxPosX / SIZE) - 1)
    eggY = love.math.random(minPosY / SIZE, (maxPosY / SIZE) - 1)
    
    for _,v in ipairs(tail) do
        if v[1] == eggX and v[2] == eggY then
            add_egg()
        end
    end
end

local gameStartMusic = love.audio.newSource('assets/game_start.mp3', 'stream')
local walkSound = love.audio.newSource('assets/walk.mp3', 'static')
local collectSound = love.audio.newSource('assets/collect.mp3', 'static')
local killSound = love.audio.newSource('assets/kill.mp3', 'static')

function game_draw()
    
    for _,v in ipairs(tail) do
        love.graphics.setColor(0.33, 0.33, 0.33) -- snake tail
        love.graphics.rectangle("fill", v[1] * SIZE, v[2] * SIZE, SIZE, SIZE, SIZE / 2, SIZE / 2)
    end
    
    love.graphics.setColor({0, 0, 0}) -- snake head
    love.graphics.rectangle("fill", snakeX * SIZE, snakeY * SIZE, SIZE, SIZE, SIZE / 3, SIZE / 3)
    
    love.graphics.setColor(1, 1, 1) -- egg
    love.graphics.draw(egg, eggX * SIZE, eggY * SIZE)
    
    love.graphics.setColor(colorConvert({15, 56, 15}))
    love.graphics.rectangle("line", 196, 148, 554, 452)
    
    love.graphics.printf("Score: " .. score, 200, 125, 250, "left")
    love.graphics.printf("Hi: " .. hiScore, 450, 125, 250, "left")
        
    if up == false and down == false and left == false and right == false and killSoundPlayed == false then
        love.graphics.printf("Press any arrow to move", 197, love.graphics.getHeight() / 2, 555, "center")
    end
end

function game_update(dt)
    
    if introPlayed == false then
        gameStartMusic:setLooping(false)
        gameStartMusic:play()
        introPlayed = true
    end
        
    if up and dirY == 0 then
        dirX, dirY = 0, -1;
    elseif down and dirY == 0 then
        dirX, dirY = 0, 1;
    elseif left and dirX == 0 then
        dirX, dirY = -1, 0;
    elseif right and dirX == 0 then
        dirX, dirY = 1, 0;
    end
    
    if (up or down or left or right) and (dirX ~= 0 or dirY ~= 0) then
        walkSound:stop()
        walkSound:play()
    end
    
    local oldX, oldY = snakeX, snakeY
    
    snakeX = snakeX + dirX
    snakeY = snakeY + dirY
    
    if snakeX == eggX and snakeY == eggY then
        collectSound:stop()
        collectSound:play()
        add_egg()
        tail_length = tail_length + 1
        score = score + 1
        table.insert(tail, {0, 0})
    end
    
    if snakeX < 8 then
        snakeX = (maxPosX / SIZE) - 1
    elseif snakeX > (maxPosX / SIZE) - 1 then
        snakeX = 8
    elseif snakeY < 6 then
        snakeY = (maxPosY / SIZE) - 1
    elseif snakeY > (maxPosY / SIZE) - 1 then
        snakeY = 6
    end
    
    if tail_length > 0 and killSoundPlayed == false then
        for _,v in ipairs(tail) do
            local x, y = v[1], v[2]
            v[1], v[2] = oldX, oldY
            oldX, oldY = x, y
        end
    end
    
    for _, v in ipairs(tail) do
        if snakeX == v[1] and snakeY == v[2] then
            if killSoundPlayed == false then
                killSound:setLooping(false)
                killSound:play()
                killSoundPlayed = true
            end
            dirX, dirY = 0, 0
            up, down, left, right = false, false, false, false
            gameOverTimer = gameOverTimer + 25 * dt
            
            if gameOverTimer > 3 and killSoundPlayed then
                state = gameStates.game_over
            end
        end
    end
end


function colorConvert(colors)
    for i,color in ipairs(colors) do
        colors[i] = colors[i] / 255
    end
    return colors
end

function game_keypressed(key)
    if key == "left" and state == gameStates.running then
        left = true; right = false; up = false; down = false
    elseif key == "right" and state == gameStates.running then
        left = false; right = true; up = false; down = false
    elseif key == "up" and state == gameStates.running then
        left = false; right = false; up = true; down = false
    elseif key == "down" and state == gameStates.running then
        left = false; right = false; up = false; down = true
    elseif key == "p" and state == gameStates.running then
        state = gameStates.pause
    elseif key == "g" and state == gameStates.running then
        state = gameStates.game_over
    elseif key == "f2" then
        love.filesystem.remove("snake_hiscore.txt")
        love.event.quit("restart")
    end
end

function game_restart()
    if score > hiScore then
        love.filesystem.write("snake_hiscore.txt", score)
    end
    
    score = 0
    hiScore = 0
    
    if love.filesystem.getInfo("snake_hiscore.txt") then
        hiScore = tonumber(love.filesystem.read("snake_hiscore.txt"), 10)
    end
    
    love.audio.stop()
    snakeX, snakeY = 10, 10
    dirX, dirY = 0, 0
    up, down, left, right = false, false, false, false
    tail = {}
    tail_length = 0
    state = gameStates.start
    add_egg()
end

