function love.load()
   player = {
      x_pos = 400;
      y_pos = 300;
      x_vel = 0;
      y_vel = 0;
      x_acc = 0;
      y_acc = 0;
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

   press_dispatch = {
      left = function() player.x_acc = -4 end;
      right= function() player.x_acc =  4 end;
      up   = function() player.y_acc = -4 end;
      down = function() player.y_acc =  4 end
   }

   release_dispatch = {
      left = function() player.x_acc = 0 end;
      right= function() player.x_acc = 0 end;
      up   = function() player.y_acc = 0 end;
      down = function() player.y_acc = 0 end
   }
end

function love.draw()
   love.graphics.draw(particles, 0, 0)
   love.graphics.print(string.format("key %s", key), 400, 300)
   love.graphics.draw(doakes, player.x_pos, player.y_pos)
end

function love.update(dt)
   particles: setDirection(math.random() * circle)
   particles: update(dt)
   
   player.x_vel = compute_velocity(player.x_vel, player.x_acc, dt)
   player.y_vel = compute_velocity(player.y_vel, player.y_acc, dt)
   
   player.x_pos = (player.x_pos + player.x_vel)
   player.y_pos = (player.y_pos + player.y_vel)
end

function love.keypressed(k, u)
   key = k
   dispatch = press_dispatch[k]
   if dispatch then dispatch() end
end

function love.keyreleased(k)
   dispatch = release_dispatch[k]
   if dispatch then dispatch() end
end

function compute_velocity(vel, acc, dt)
   if (vel <= 0 and acc < 0) then
      return math.max(-16, vel + (acc*dt))
   elseif ((vel < 0 and acc > 0) or (vel > 0 and acc < 0) or (acc == 0)) then
      return 0
   elseif (vel >= 0 and acc > 0) then
      return math.min( 16, vel + (acc*dt))
   end
end
   