local Game = require("F.Game")

local grid_width  = 20
local grid_height = 20


function GridCreate(x,y)
	local grid = {}
	for xx = 1, x, 1 do
		local row = {}
		for yy = 1, y, 1 do
			local cell  = {}
			cell.x      = xx * (Game.tile_size * Game.tile_scale)
			cell.y      = yy * (Game.tile_size * Game.tile_scale)
			cell.width  = Game.tile_scale * Game.tile_size
			cell.height = Game.tile_scale * Game.tile_size
			cell.style  = 'line'

			table.insert(row,cell)
		end
			table.insert(grid, row)
	end
	return grid
end


local grid = GridCreate(grid_width, grid_height)
local px, py = 5,5

function GridBlocks(grid)
	local blocks = {}
	local blockCount = love.math.random(3,40)

	for i = 1, blockCount, 1 do
		local bx = love.math.random(1, grid_width)
		local by = love.math.random(1, grid_height)
		local Block = {
			x = bx * (Game.tile_size * Game.tile_scale),
			y = by * (Game.tile_size * Game.tile_scale),
			width  = Game.tile_scale * Game.tile_size,
			height = Game.tile_scale * Game.tile_size,
			style = 'fill'
		}
		table.insert(blocks, Block)
	end
	return blocks
end

local blocks = GridBlocks(grid)

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
				cell.x,
				cell.y,
				cell.width,
				cell.height
			)
		end
	end

	for _, block in ipairs(blocks) do
			love.graphics.rectangle(
				block.style,
				block.x,
				block.y,
				block.width,
				block.height
			)
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
