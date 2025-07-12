-- highscore.lua
local HighScore = {}
function HighScore:save(score)
    -- Using Lua 5.4 'to-be-closed' variable for safe file handling
    local file <close> = io.open("highscore.txt", "w")

    if file then
        file:write(tostring(score))
        -- File automatically closes even if error occurs
    end
end

function HighScore:load()
    local file <close> = io.open("highscore.txt", "r")
    if file then
        local content = file:read("*a")
        return tonumber(content) or 0
    end
    return 0
end

return HighScore
