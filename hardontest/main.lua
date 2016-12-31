HC = require 'HC'
player = { x = 400, y = 250, velx = 0, vely = 0, grounded = false }
--player = { x = 200, y = 710, vel.x = 0, vel.y = 0, grounded = false }

gravity = 0.015


function love.load()
    -- add a rectangle to the scene
    rect = HC.rectangle(200,400,400,20)

    -- add a circle to the scene
    ball = HC.circle(400,250,20)
    -- mouse:moveTo(love.mouse.getPosition())
end

function love.update(dt)
    if love.keyboard.isDown('left','a') then
        player.velx = -1
    elseif love.keyboard.isDown('right','d') then
        player.velx = 1
    end
    if player.vely < 10 then
        player.vely = player.vely + gravity
    end


    for shape,delta in pairs(HC.collisions(ball)) do
        if(delta.y < 0) then
            --gravity = -0.1
            player.grounded = true
            player.vely = 0.0
            if love.keyboard.isDown('w') then
                if player.grounded then
                    --gravity = 0
                    player.vely = -2.0
                    player.grounded = false
                end
            end
        end
    end
    player.x = player.x + player.velx
    player.y = player.y + player.vely
    -- move circle to mouse position
    ball:moveTo(player.x,player.y)

    -- I always start with an easy way to exit the game
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end



    -- if not player.grounded then
    --     --ball:moveTo(100,100)
    --     player.vely = player.vely + gravity*dt
    --     player.y = player.y + (player.vely*dt)
    -- end

    -- rotate rectangle
    -- rect:rotate(dt)

    -- check for collisions
    -- for shape, delta in pairs(HC.collisions(ball)) do
    --     text[#text+1] = string.format("Colliding. Separating vector = (%s,%s)",
    --                                   delta.x, delta.y)
    -- end
    --
    -- while #text > 40 do
    --     table.remove(text, 1)
    -- end
end

function love.draw()
    -- print messages
    -- for i = 1,#text do
    --     love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
    --     love.graphics.print(text[#text - (i-1)], 10, i * 15)
    -- end

    -- shapes can be drawn to the screen
    love.graphics.setColor(255,255,255)
    rect:draw('fill')
    ball:draw('fill')
end
