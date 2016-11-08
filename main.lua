-- The usual start point: we just create a table which will receive particles, record the position of our emitter and a value for the acceleration due to gravity

function love.load()

	part_list = {}
	
	base_x = 400
	base_y = 200
	
	g = 100
end

-- Lots going on here, as it should be!

function love.update( dt )
	
	-- Get the length of our list
	
	len = #part_list
	
	-- A table to contain our next particle

	part = {}

	-- Where is the mouse at the moment?
	
	mx , my = love.mouse.getPosition( )

	-- Move our emitter toward the mouse
	
	base_x = base_x + dt * (mx - base_x )
	base_y = base_y + dt * (my - base_y )

	-- Locate our new particle at the position of the emitter
	
	part.x = base_x
	part.y = base_y

	-- Create a random velocity for our new particle
	
	part.vx = love.math.random( -100 , 100 )
	part.vy = love.math.random( -100 , 0 )

	-- A table to contain our (random) choice of colour and alpha
	col = {}
	
	col.r = love.math.random( 255 )
	col.g = love.math.random( 255 )
	col.b = love.math.random( 255 )
	col.a = 100

	part.color = col
	
	-- Store our new particle in the list of particles
	
	part_list[ len + 1 ] = part

	-- Work _backwards_ through the list

	for i = len , 1 , -1 do
		
		-- Get our particle
		
		part = part_list[ i ]
		
		-- Move it according to the velocity - note the use of dt here
		
		part.x = part.x + part.vx * dt
		part.y = part.y + part.vy * dt
		
		-- Apply acceleration to the velocity
		
		part.vy = part.vy + g * dt

		-- Has it hit the ground?
		
		if part.y > 550 then
			
			-- If so then remove it
			
			table.remove( part_list , i )
		end
	end
end

-- The usual draw routine

function love.draw()
	
	-- This iterator is weird: it is pulling out the index and the value in sequence
	
	for index , part in pairs( part_list ) do
		
		-- Get the table containing the color and use it
		
		col = part.color

		love.graphics.setColor( col.r , col.g , col.b , col.a )
		
		-- Draw a circle where the particle is
		
		love.graphics.circle( "fill" , part.x , part.y , 4 )
	end
end

