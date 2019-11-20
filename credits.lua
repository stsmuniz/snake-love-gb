local logo = love.graphics.newImage("assets/logo_credits.png")
local creditsFont = love.graphics.newFont("assets/d8bitmage.otf", 25)

function credits_draw()
    love.graphics.draw(
        logo,
        (love.graphics.getWidth() / 2) - (logo:getWidth() / 2),
        125
    )
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(creditsFont)
    love.graphics.printf("Developed by @stsmuniz\n\nTitle Music by Eric Skiff\n\nGame Over Music by Alex McCulloch\n\nSounds and game start music by Little Robot Sound Factory", 197, 250, 555, "center")
    love.graphics.printf("Press any key to return to title", 197, love.graphics.getHeight() - 150, 555, "center")
end

function credits_keypressed(key)
    state = gameStates.start
end
