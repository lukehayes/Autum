local Game = require("F.Game")



function GridCreate(x,y)
	local grid = {}
	for x = 1, x, 1 do
		local row = {}
		for y = 1, y, 1 do
			local cell = {}
			cell.x = Game.tile_size * x
			cell.y = Game.tile_size * y
			cell.width = Game.tile_scale * Game.tile_size
			cell.height = Game.tile_scale * Game.tile_size
			cell.style = 'line'

			table.insert(row,cell)
		end
			table.insert(grid, row)
	end
	return grid
end


local grid = GridCreate(11,11)
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
				cell.x,
				cell.y,
				cell.width,
				cell.height
			)
		end


			love.graphics.rectangle(
				'fill',
				Game.tile_size * px,
				Game.tile_size * py,
				Game.tile_size,
				Game.tile_size
			)

	end

	Game.events:emit("postrender")
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then
		Game.events:emit("space_pressed")
	end

	-- Player movement
	if key == "w" then
		py = py - 1
	end

	if key == "s" then
		py = py +1
	end

	if key == "a" then
		px = px - 1
	end

	if key == "d" then
		px = px +1
	end
	-- End Player movement

	if key == "escape" then
		love.event.quit()
	end
end
