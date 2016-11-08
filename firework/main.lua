function love.load()

	part_list = {}
	
	base_x = 400
	base_y = 200
	
	g = 100
end

function love.update( dt )
	len = #part_list

	part = {}

	mx , my = love.mouse.getPosition( )

	base_x = base_x + dt * (mx - base_x )
	base_y = base_y + dt * (my - base_y )

	part.x = base_x
	part.y = base_y

	part.vx = love.math.random( -100 , 100 )
	part.vy = love.math.random( -100 , 0 )

	col = {}
	
	col.r = love.math.random( 255 )
	col.g = love.math.random( 255 )
	col.b = love.math.random( 255 )
	col.a = 100

	part.color = col
	
	part_list[ len + 1 ] = part


	for i = len , 1 , -1 do
		part = part_list[ i ]
		part.x = part.x + part.vx * dt
		part.y = part.y + part.vy * dt

		part.vy = part.vy + g * dt

		if part.y > 550 then
			table.remove( part_list , i )
		end
	end
end

function love.draw()
	for index , part in pairs( part_list ) do
		col = part.color

		love.graphics.setColor( col.r , col.g , col.b , col.a )
		love.graphics.circle( "fill" , part.x , part.y , 4 )
	end
end

