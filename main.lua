require('gamestate')
require('game')
require('splash')
require('start')
require('credits')
require('running')
require('game_over')
moonshine = require 'moonshine'

function love.load()
    effect = moonshine(moonshine.effects.dmg)
        .chain(moonshine.effects.scanlines)
    effect.scanlines.width = 1
    effect.scanlines.opacity = 0.25
    love.window.setPosition(300, 0, 1)
    frame = love.graphics.newImage("assets/gb_overlay.png")
    interval = 20
    add_egg()
    love.graphics.setDefaultFilter("none")
end

function love.draw()
    effect(function()
        love.graphics.setColor(colorConvert({255, 255, 255}))
        love.graphics.rectangle("fill", 193, 98, 560, 504)

        if state == gameStates.splash then
            splash_draw()
        elseif state == gameStates.start then
            start_draw()
        elseif state == gameStates.credits then
            credits_draw()
        elseif state == gameStates.running then
            game_draw()
        elseif state == gameStates.game_over then
            game_over_draw()
        end
    end)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(frame, 0, 0)
    --love.graphics.setColor(colorConvert({255, 0, 0}))
    --love.graphics.rectangle("fill", 193, 98, 160 * 3.5, 144 * 3.5)
end

function love.update(dt)
    if state == gameStates.splash then
        splash_update(dt)
    elseif state == gameStates.start then
        start_update(dt)
    elseif state == gameStates.running then
        interval = interval - 1
        if interval < 0 then
            game_update(dt)
            interval = 20
        end
    end
end

function love.keypressed(key)
    
    if state == gameStates.start then
        start_keypressed(key)
    elseif state == gameStates.running then
        game_keypressed(key)
    elseif state == gameStates.credits then
        credits_keypressed(key)
    elseif state == gameStates.game_over then
        game_over_keypressed(key)
    end
        
    if key == "escape" then
        love.event.quit()
    elseif key == "p" and state == gameStates.pause then
        state = gameStates.running
    end
end