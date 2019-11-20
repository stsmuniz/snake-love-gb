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
    
    love.graphics.setColor(colorConvert({15, 56, 15}))
    love.graphics.setFont(startFont)
    love.graphics.printf("Press enter to start\nPress C for credits", 197, love.graphics.getHeight() - 150, 555, "center")
end

function start_keypressed(key)
    if key == "return" then
        love.audio.stop()
        state = gameStates.running
    elseif key == "c" then
        state = gameStates.credits
    end
end
