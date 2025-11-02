local Game = require("F.Game")

local grid = {}


for x = 1, 11, 1 do
	local row = {}
	for y = 1, 11, 1 do
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

	Game.events:emit("postrender")
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then
		Game.events:emit("space_pressed")
	end

	if key == "escape" then
		love.event.quit()
	end
end
