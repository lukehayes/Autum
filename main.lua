local Game = require("F.Game")
local Color = require("F.Color")
local Math = require("F.Math")

local grid_width  = 20
local grid_height = 20



function GridCreate(x,y)
	local grid = {}
	for xx = 1, x, 1 do
		local row = {}
		for yy = 1, y, 1 do
			local cell   = {}
			cell.x       = xx
			cell.y       = yy
			cell.tx      = xx * (Game.tile_size * Game.tile_scale)
			cell.ty      = yy * (Game.tile_size * Game.tile_scale)
			cell.width   = Game.tile_scale * Game.tile_size
			cell.height  = Game.tile_scale * Game.tile_size
			cell.style   = 'line'

			table.insert(row,cell)
		end
			table.insert(grid, row)
	end
	return grid
end


local grid = GridCreate(grid_width, grid_height)
local px, py = 5,5

function GridBlocks(w, h)
	local blocks = {}
	local hasBlock = love.math.random(0,1)

	for xx = 1, w, 1 do
		local row = {}
		for yy = 1, h, 1 do
			local bx = love.math.random(1, grid_width)
			local by = love.math.random(1, grid_height)
			local Block = {
				x = bx,
				y = by,
				tx = bx * (Game.tile_size * Game.tile_scale),
				ty = by * (Game.tile_size * Game.tile_scale),
				width  = Game.tile_scale * Game.tile_size,
				height = Game.tile_scale * Game.tile_size,
				style = 'fill'
			}
			table.insert(row,Block)
		end
			table.insert(blocks, row)
	end

	for i = 1, blockCount, 1 do
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
				cell.tx,
				cell.ty,
				cell.width,
				cell.height
			)
		end
	end

	DrawColor(255,0,0,255)
	for _, block in ipairs(blocks) do
			love.graphics.rectangle(
				block.style,
				block.tx,
				block.ty,
				block.width,
				block.height
			)
	end
	ResetDrawColor()

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
			local block = blocks[px + py]
			print(px,py, block.x, block.y)
			block.style = 'line'
		end
	end

	-- End Player movement

	if key == "escape" then
		love.event.quit()
	end
end
