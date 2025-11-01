local Game = require "F.Game"


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
