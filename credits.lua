local logo = love.graphics.newImage("assets/logo_credits.png")
local creditsFont = love.graphics.newFont("assets/d8bitmage.otf", 25)

function credits_draw()
    love.graphics.draw(
        logo,
        (love.graphics.getWidth() / 2) - (logo:getWidth() / 2),
        125
    )
    love.graphics.setColor(colorConvert({15, 56, 15}))
    love.graphics.setFont(creditsFont)
    love.graphics.printf("Developed by @stsmuniz\n\nTitle Music by Eric Skiff, avaliable at https://ericskiff.com/music/\n\nGame Over Music by Alex McCulloch, avaliable at https://opengameart.org/content/gameboy-song-1", 197, 250, 555, "center")
    love.graphics.printf("Press any key to return to title", 197, love.graphics.getHeight() - 150, 555, "center")
end

function credits_keypressed(key)
    state = gameStates.start
end
