local gameOverFont = love.graphics.newFont("assets/d8bitmage.otf", 40)
local gameOverMusic = love.audio.newSource('assets/gameover_music.ogg', 'stream')
function game_over_draw()
    gameOverMusic:setLooping(true)
    gameOverMusic:play()
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(gameOverFont)
    love.graphics.printf("Game Over", 197, 200, 555, "center")
    love.graphics.printf("Final Score: " .. score, 197, 250, 555, "center")
    love.graphics.printf("Press Space to restart", 197, 300, 555, "center")
end

function game_over_keypressed(key)
    if key == "space" then
        game_restart()
    end
end
