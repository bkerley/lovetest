function love.load()
   joe = love.graphics.newImage("joe-grand.png")
   particles = love.graphics.newParticleSystem(joe, 500)
   particles: setEmissionRate( 30 )
   particles: setLifetime( -1 )
   particles: setParticleLife( 3 )
   particles: setPosition(400, 300)
   particles: setSpeed(100)
   particles: setSpin(-2, 2)
end

function love.draw()
   love.graphics.print("Hello World", 400, 300)
   love.graphics.draw(particles, 0, 0)
end

function love.update(dt)
   particles: setDirection(math.random() * (3.1415926535 * 2))
   particles: update(dt)
end