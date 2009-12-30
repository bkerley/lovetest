function love.load()
   player = {
      x_pos = 400;
      y_pos = 300;
      x_del = 0;
      y_del = 0;
   }
   pi = 3.1415926535
   circle = 2.0 * pi
   joe = love.graphics.newImage("joe-grand.png")
   doakes = love.graphics.newImage("doakes_64x64.jpg")
   particles = love.graphics.newParticleSystem(joe, 1000)
   particles: setEmissionRate( 30 )
   particles: setLifetime( -1 )
   particles: setParticleLife( 10 )
   particles: setPosition(400, -100)
   particles: setSpeed(100)
   particles: setSpin(-2, 2)
   particles: setRotation(pi, circle)
   key = ""
   uni = 0

   key_dispatch = {
      left = function() player.x_del = math.max(player.x_del - 1, -4) end;
      right= function() player.x_del = math.min(player.x_del + 1,  4) end;
      up   = function() player.y_del = math.max(player.y_del - 1, -4) end;
      down = function() player.y_del = math.min(player.y_del + 1,  4) end
   }
end

function love.draw()
   love.graphics.print(string.format("key %u:%s",uni, key), 400, 300)
   love.graphics.draw(particles, 0, 0)
   love.graphics.draw(doakes, player.x_pos, player.y_pos)
end

function love.update(dt)
   particles: setDirection(math.random() * circle)
   particles: update(dt)
   player.x_pos = player.x_pos + player.x_del
   player.y_pos = player.y_pos + player.y_del
end

function love.keypressed(k, u)
   key = k
   uni = u
   dispatch = key_dispatch[key]
   if dispatch then dispatch() end
end