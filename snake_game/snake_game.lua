-- snake_game.lua
---@diagnostic disable: undefined-global

local SnakeGame = {}
SnakeGame.__index = SnakeGame

local GRID_SIZE = 20
local BOARD_WIDTH = 30
local BOARD_HEIGHT = 20
local MOVE_INTERVAL = 0.15

function SnakeGame:new()
    local game = {
        snake = {
            { x = 10, y = 10 }
        },
        direction = { x = 1, y = 0 },
        food = { x = 15, y = 15 },
        score = 0,
        gameOver = false,
        timer = 0
    }
    return setmetatable(game, SnakeGame)
end

function SnakeGame:update(dt)
    if self.gameOver then return end

    self.timer = self.timer + dt
    if self.timer < MOVE_INTERVAL then return end
    self.timer = 0

    -- Move snake by copying head and shifting
    local head = self.snake[1]
    local newHead = {
        x = head.x + self.direction.x,
        y = head.y + self.direction.y
    }

    -- Check wall collision
    if newHead.x < 0 or newHead.x >= BOARD_WIDTH or newHead.y < 0 or newHead.y >= BOARD_HEIGHT then
        self.gameOver = true
        return
    end

    -- Check self collision
    for _, segment in ipairs(self.snake) do
        if segment.x == newHead.x and segment.y == newHead.y then
            self.gameOver = true
            return
        end
    end

    -- Insert new head
    table.insert(self.snake, 1, newHead)

    -- Food eaten?
    if newHead.x == self.food.x and newHead.y == self.food.y then
        self.score = self.score + 1
        self:spawnFood()
    else
        table.remove(self.snake) -- remove tail
    end
end

function SnakeGame:spawnFood()
    local valid = false
    local x, y

    while not valid do
        x = love.math.random(0, BOARD_WIDTH - 1)
        y = love.math.random(0, BOARD_HEIGHT - 1)
        valid = true
        for _, segment in ipairs(self.snake) do
            if segment.x == x and segment.y == y then
                valid = false
                break
            end
        end
    end

    self.food = { x = x, y = y }
end

function SnakeGame:draw()
    -- Draw snake
    for _, segment in ipairs(self.snake) do
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", segment.x * GRID_SIZE, segment.y * GRID_SIZE, GRID_SIZE - 1, GRID_SIZE - 1)
    end

    -- Draw food
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.food.x * GRID_SIZE, self.food.y * GRID_SIZE, GRID_SIZE - 1, GRID_SIZE - 1)

    -- Draw score
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. self.score, 10, 10)

    -- Game over
    if self.gameOver then
        love.graphics.printf("Game Over! Press ESC to return to Menu", 0, love.graphics.getHeight() / 2,
            love.graphics.getWidth(), "center")
    end
end

function SnakeGame:changeDirection(dx, dy)
    -- Prevent reversing into itself
    if self.direction.x == -dx and self.direction.y == -dy then return end
    self.direction = { x = dx, y = dy }
end

return SnakeGame
