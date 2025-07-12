---@diagnostic disable: undefined-global

local MenuState = {}

function MenuState:enter()
    print("Entered Menu State")
end

function MenuState:update(dt)
    -- No dynamic updates for the menu (yet)
end

function MenuState:draw()
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.printf("SNAKE GAME", 0, love.graphics.getHeight() / 2 - 40, love.graphics.getWidth(), "center")
    love.graphics.printf("Press [Enter] to Start", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
end

function MenuState:keypressed(key)
    if key == "return" or key == "enter" then
        require("gamestate"):switch("playing")
    elseif key == "escape" then
        love.event.quit()
    end
end

return MenuState
