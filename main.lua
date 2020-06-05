BUTTON_HEIGHT = 64 
WINDOW_WIDTH = love.graphics.getWidth() 
WINDOW_HEIGHT = love.graphics.getHeight() 

local 
function newButton(text,fn)
    return{
        text = text, 
        fn = fn, 
        now = false, 
        last = false, 
        baseColor = {0.4,0.4,0.5, 1.0},
        hotColor = {0.8,0.8,0.9,1.0},
        currentColor = {}
    }
end 

local buttons = {} 
local font = nil  


function love.load()
    font = love.graphics.newFont(32)
    table.insert(buttons, newButton("Start Game", function() print("Starting Gameing") end))
    table.insert(buttons, newButton("Load Game", function() print("Load Game") end))
    table.insert(buttons, newButton("Settings", function() print("Setting") end))
    table.insert(buttons, newButton("Exit", function() love.event.quit(0) end))
end 

function love.update(dt)

end 

function love.draw()
    local BUTTON_WIDTH = WINDOW_WIDTH * (1/3)
    local margin = 16
    local total_height = (BUTTON_HEIGHT + margin) * #buttons

    for i, button in ipairs(buttons) do 
        button.last = button.now 

        local x = (WINDOW_WIDTH/2) - (BUTTON_WIDTH/2) 
        local y = (WINDOW_HEIGHT/2) - (total_height/2) + ((BUTTON_HEIGHT + margin) * i)

        local mx, my = love.mouse.getPosition() 
        local hot = mx > x and mx < x + BUTTON_WIDTH and my > y and my < y + BUTTON_HEIGHT
    
        button.currentColor = button.baseColor

        if hot then button.currentColor = button.hotColor end 
        
        button.now = love.mouse.isDown(1)

        if button.now and not button.last and hot then button.fn() end 

        love.graphics.setColor(unpack(button.currentColor))
        love.graphics.rectangle("fill", x, y, BUTTON_WIDTH, BUTTON_HEIGHT)
        love.graphics.setColor(0,0,0,1)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)
        love.graphics.print(button.text, font,(WINDOW_WIDTH * 0.5) - textW * 0.5,(y + textH * 0.5 ) )

     end 

end 