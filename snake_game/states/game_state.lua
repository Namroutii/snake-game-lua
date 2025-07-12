local GameState = {}
local SnakeGame = require("snake_game")

local snake = nil

function GameState:enter()
    snake = SnakeGame:new()
end

function GameState:update(dt)
    if snake then
        snake:update(dt)
    end
end

function GameState:draw()
    if snake then
        snake:draw()
    end
end

function GameState:keypressed(key)
    if key == "escape" then
        require("gamestate"):switch("menu")
    elseif snake then
        if key == "up" then
            snake:changeDirection(0, -1)
        elseif key == "down" then
            snake:changeDirection(0, 1)
        elseif key == "left" then
            snake:changeDirection(-1, 0)
        elseif key == "right" then
            snake:changeDirection(1, 0)
        end
    end
end

function GameState:changeDirection(dx, dy)
    if snake then
        snake:changeDirection(dx, dy)
    end
end

return GameState
