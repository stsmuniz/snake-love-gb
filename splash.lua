local posY = 100
local splashFont = love.graphics.newFont("assets/d8bitmage.otf", 40)
local counter = 5
local timer = 0
local splashSound = love.audio.newSource('assets/gameboy_start_up.mp3', 'static')


function splash_update(dt)
    if posY < love.graphics.getHeight() / 2 then
        posY = posY + (75 * dt)
    elseif timer < counter then
        splashSound:play()
        timer = timer + 3.5 * dt
    else
        state = gameStates.start
    end
end

function splash_draw()
    love.graphics.setFont(splashFont)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("Stsmuniz™", 197, posY, 555, "center")
end
