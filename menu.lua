menu = {} 
menu.show = false
menu.buttons = {}
menu.total_height  = 0 
menu.font = love.graphics.newFont(10)
menu.buttonssettings = {}
menu.buttonssettings.HEIGHT = 24
menu.buttonssettings.WIDTH =  love.graphics.getWidth()  * (1/3)
menu.buttonssettings.MARGIN_TOP = 8 
menu.buttonssettings.BASECOLOR = {0.4,0.4,0.5, 1.0}
menu.buttonssettings.HOVERCOLOR = {0.8,0.8,0.9,1.0}

menu.WINDOW = {}
menu.WINDOW.HEIGHT = love.graphics.getHeight()
menu.WINDOW.WIDTH = love.graphics.getWidth()

menu.totalitems = 0; 
menu.currentIndex = 1

menu.inputtype = "keyboard" 

function DrawMenu()
    if menu.show then 
        for i, button in ipairs(menu.buttons) do 
            love.graphics.setColor(unpack(button.currentColor))
            love.graphics.rectangle("fill", button.x, button.y, menu.buttonssettings.WIDTH, menu.buttonssettings.HEIGHT)
            love.graphics.setColor(0,0,0,1)
            love.graphics.print(button.text, menu.font,(menu.WINDOW.WIDTH * 0.5) - button.textWidth * 0.5,(button.y + button.textHeight * 0.5 ) )
        end 
    end 
end 

function ShowMenu()
    menu.show = true
end 

function HideMenu()
    menu.show = false
end

function UpdateMenu()
    menu.total_height = (menu.buttonssettings.HEIGHT + menu.buttonssettings.MARGIN_TOP) * #menu.buttons
    menu.totalitems = table.getn(menu.buttons) -1 

    for i, button in ipairs(menu.buttons) do 
        button.last = button.now 
        button.x = (menu.WINDOW.WIDTH/2) - (menu.buttonssettings.WIDTH/2) 
        button.y = (menu.WINDOW.HEIGHT/2.8) - (menu.total_height/2) + ((menu.buttonssettings.HEIGHT + menu.buttonssettings.MARGIN_TOP) * i)
        button.currentColor = menu.buttonssettings.BASECOLOR

        if menu.inputtype == "mouse" then 
            local mx, my = love.mouse.getPosition() 
            button.isHovering = mx > button.x and mx < button.x + menu.buttonssettings.WIDTH and my > button.y and my < button.y + menu.buttonssettings.HEIGHT
        end 

        if menu.inputtype == "keyboard" then 
            if i == menu.currentIndex then 
                button.isHovering = true;
            else 
                button.isHovering = false; 
            end 
        end 

        if button.isHovering then button.currentColor = menu.buttonssettings.HOVERCOLOR end 
        
        if menu.inputtype == "mouse" then 
            button.now = love.mouse.isDown(1)   

            if button.now and not button.last and button.isHovering then
                button.fn() 
            end 
        end 


     end 
end 

function love.keypressed( key )
    if key == "down" then 
        NextMenuItem()
    end 

    if key == "up"then 
        PrevMenuItem()
    end 

    if key == "space" and menu.inputtype == "keyboard" then 
        menu.buttons[menu.currentIndex].fn()
    end 
 end

function NextMenuItem()
    if menu.currentIndex <= menu.totalitems then
        menu.currentIndex = menu.currentIndex + 1 
    end
end 

function PrevMenuItem()
    if menu.currentIndex > 1  then
        menu.currentIndex = menu.currentIndex - 1 
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
        textWidth = menu.font:getWidth(text),
        textHeight = menu.font:getHeight(text)
    }
end 