menu = {} 
menu.buttonssettings = {}
menu.buttonssettings.HEIGHT = 64
menu.buttonssettings.WIDTH =  love.graphics.getWidth()  * (1/3)
menu.buttonssettings.MARGIN_TOP = 16 
menu.buttonssettings.BASECOLOR = {0.4,0.4,0.5, 1.0}
menu.buttonssettings.HOVERCOLOR = {0.8,0.8,0.9,1.0}
menu.buttons = {}
menu.total_height  = 0 
menu.WINDOW = {}
menu.WINDOW.HEIGHT = love.graphics.getHeight()
menu.WINDOW.WIDTH = love.graphics.getWidth()

function DrawMenu()
    for i, button in ipairs(menu.buttons) do 
        love.graphics.setColor(unpack(button.currentColor))
        love.graphics.rectangle("fill", button.x, button.y, menu.buttonssettings.WIDTH, menu.buttonssettings.HEIGHT)
        love.graphics.setColor(0,0,0,1)
        love.graphics.print(button.text, font,(menu.WINDOW.WIDTH * 0.5) - button.textW * 0.5,(button.y + button.textH * 0.5 ) )
     end 
end 

function UpdateMenu()
    menu.total_height = (menu.buttonssettings.HEIGHT + menu.buttonssettings.MARGIN_TOP) * #menu.buttons

    for i, button in ipairs(menu.buttons) do 
        button.last = button.now 
        button.x = (menu.WINDOW.WIDTH/2) - (menu.buttonssettings.WIDTH/2) 
        button.y = (menu.WINDOW.HEIGHT/2) - (menu.total_height/2) + ((menu.buttonssettings.HEIGHT + menu.buttonssettings.MARGIN_TOP) * i)
        button.currentColor = menu.buttonssettings.BASECOLOR

        local mx, my = love.mouse.getPosition() 
        button.isHovering = mx > button.x and mx < button.x + menu.buttonssettings.WIDTH and my > button.y and my < button.y + menu.buttonssettings.HEIGHT
        
        if button.isHovering then button.currentColor = menu.buttonssettings.HOVERCOLOR end 
        
        button.now = love.mouse.isDown(1)
        if button.now and not button.last and button.isHovering then button.fn() end      
     end 
end 

function newButton(text,fn)
    return{
        text = text, 
        fn = fn, 
        now = false, 
        last = false, 
        currentColor = {}, 
        x = 0, 
        y = 0, 
        isHovering = false,
        textW = font:getWidth(text),
        textH = font:getHeight(text)
    }
end 