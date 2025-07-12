-- components/renderer.lua
return function(color, size)
    return {
        color = color or { 1, 1, 1 },
        size = size or 20
    }
end
