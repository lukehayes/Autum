local Game = require("F.Game")
local Color = require("F.Color")
local Math = require("F.Math")

local grid_width  = 10
local grid_height = 10


function GridCreate(x,y)
	local grid = {}
	for xx = 1, x, 1 do
		local row = {}
		for yy = 1, y, 1 do
			local cell   = {}
			if(OneIn(10)) then
				cell.x       = xx
				cell.y       = yy
				cell.tx      = xx * (Game.tile_size * Game.tile_scale)
				cell.ty      = yy * (Game.tile_size * Game.tile_scale)
				cell.width   = Game.tile_scale * Game.tile_size
				cell.height  = Game.tile_scale * Game.tile_size
				cell.style   = 'fill'
			else
				cell.x       = xx
				cell.y       = yy
				cell.tx      = xx * (Game.tile_size * Game.tile_scale)
				cell.ty      = yy * (Game.tile_size * Game.tile_scale)
				cell.width   = Game.tile_scale * Game.tile_size
				cell.height  = Game.tile_scale * Game.tile_size
				cell.style   = 'line'
			end
			table.insert(row,cell)
		end
			table.insert(grid, row)
	end
	return grid
end


local grid = GridCreate(grid_width, grid_height)
local px, py = 5,5

Game.events:emit("preload")

function love.load()
	Game.events:emit("load")
end

function love.update(dt)
	Game.events:emit("preupdate")

	Game.events:emit("postupdate")
end

function love.draw()
	Game.events:emit("prerender")

	for _, row in ipairs(grid) do
		for _, cell in ipairs(row) do
			love.graphics.rectangle(
				cell.style,
				cell.tx,
				cell.ty,
				cell.width,
				cell.height
			)
		end
	end


	love.graphics.rectangle(
		'fill',
		Game.tile_size * px,
		Game.tile_size * py,
		Game.tile_size,
		Game.tile_size
	)

	Game.events:emit("postrender")
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then
		Game.events:emit("space_pressed")
	end

	-- Player movement
	if key == "w" then
		if py >= 2 then
			py = py - 1
		end
	end

	if key == "s" then
		if py < grid_height then 
			py = py + 1
		end
	end

	if key == "a" then
		if px >= 2 then
			px = px - 1
		end
	end

	if key == "d" then
		if px < grid_width then 
			px = px + 1
		end
	end

	-- End Player movement

	if key == "escape" then
		love.event.quit()
	end
end
