-- gamestate.lua
local GameState = {}
GameState.__index = GameState

function GameState:new()
    local state = {
        current = "menu",
        states = {
            menu = require("states.menu_state"),
            playing = require("states.game_state")
        }
    }
    return setmetatable(state, GameState)
end

function GameState:switch(newState)
    local newStateModule = self.states[newState]
    if newStateModule then
        if newStateModule.enter then
            newStateModule:enter()
        end
        self.current = newState
    else
        error("Invalid game state: " .. tostring(newState))
    end
end

function GameState:update(dt)
    if self.states[self.current] and self.states[self.current].update then
        self.states[self.current]:update(dt)
    end
end

function GameState:draw()
    if self.states[self.current] and self.states[self.current].draw then
        self.states[self.current]:draw()
    end
end

return GameState
