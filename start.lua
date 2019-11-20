local logo = love.graphics.newImage("assets/logo_startscreen.png")
local startFont = love.graphics.newFont("assets/d8bitmage.otf", 20)
local titleMusic = love.audio.newSource('assets/title_music.mp3', 'stream')

function start_update(dt)
end

function start_draw()
    titleMusic:setLooping(true)
    titleMusic:play()
    love.graphics.draw(
        logo,
        (love.graphics.getWidth() / 2) - (logo:getWidth() / 2),
        (love.graphics.getHeight() / 2) - (logo:getHeight() / 2)
    )
    
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(startFont)
    love.graphics.printf("Press Enter to start\nPress C for credits", 197, love.graphics.getHeight() - 175, 555, "center")
    love.graphics.printf("@stsmuniz 2019", 197, love.graphics.getHeight() - 125, 555, "center")
end

function start_keypressed(key)
    if key == "return" then
        love.audio.stop()
        state = gameStates.running
    elseif key == "c" then
        state = gameStates.credits
    end
end
