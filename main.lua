
function love.load()
    font = love.graphics.newFont(32)
    require("menu")



    table.insert(menu.buttons, newButton("Start Game", function() print("Starting Gameing") end))
    table.insert(menu.buttons, newButton("Load Game", function() print("Load Game") end))
    table.insert(menu.buttons, newButton("Settings", function() print("Setting") end))
    table.insert(menu.buttons, newButton("Exit", function() love.event.quit(0) end))
end 

function love.update(dt)
    UpdateMenu()
end 

function love.draw()
    DrawMenu()
end 