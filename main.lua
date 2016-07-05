require "player"
require "bullet"
require "enemy"
require "boundingbox"
function love.load ()
  -- load player
  player.load()
  --
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  love.graphics.setBackgroundColor(150, 150, 150)
  enemy.spawn(500,300)
end

function love.keypressed(key)
  player.shoot(key)
end

function love.update (dt)
  -- from player.lua
  UPDATE_PLAYER(dt)
  -- from bullet.lua
  UPDATE_BULLET(dt)
  -- from enemy.lua
  UPDATE_ENEMY(dt)
end

function love.draw ()
  love.graphics.print("Enemy.timer is " .. enemy.timer)
  --love.graphics.print("spawnChance is " .. spawnChance, 0, 50)
  -- from player.lua
  DRAW_PLAYER()
  -- from bullet.lua
  DRAW_BULLET()
  -- from enemy.lua
  DRAW_ENEMY()

end
