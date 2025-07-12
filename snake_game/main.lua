---@diagnostic disable: undefined-global
local GameState = require("gamestate")
local gameState = GameState:new()

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()
end

function love.keypressed(key)
    if gameState.current == "playing" then
        local game = gameState.states.playing
        if key == "up" then
            game:changeDirection(0, -1)
        elseif key == "down" then
            game:changeDirection(0, 1)
        elseif key == "left" then
            game:changeDirection(-1, 0)
        elseif key == "right" then
            game:changeDirection(1, 0)
        elseif key == "escape" then
            gameState:switch("menu")
        end
    elseif gameState.current == "menu" then
        if key == "return" or key == "enter" then
            gameState:switch("playing")
        elseif key == "escape" then
            love.event.quit()
        end
    end
end
