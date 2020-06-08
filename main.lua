
function love.load()

    love.window.setMode( 320, 240)
    require("menu")
    table.insert(menu.buttons, newButton("Start Game", function() print("Starting Gameing") end))
    table.insert(menu.buttons, newButton("Load Game", function() print("Load Game") end))
    table.insert(menu.buttons, newButton("Settings", function() print("Setting") end))
    table.insert(menu.buttons, newButton("Exit", function() love.event.quit(0) end))

    ShowMenu()
end 

function love.update(dt)
    UpdateMenu()
end 

function love.draw()
    DrawMenu()
end 