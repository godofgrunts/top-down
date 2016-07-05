player = {}

function player.load()
  player.width = 50
  player.height = 50
  player.x = 5
  player.y = 5
  player.xvel = 0
  player.yvel = 0
  player.friction = 9.5
  player.speed = 2250
end

function player.draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
end

function player.physics(dt)
  player.x = player.x + player.xvel * dt
  player.y = player.y + player.yvel * dt
  player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1))
  player.yvel = player.yvel * (1 - math.min(dt*player.friction, 1))
end

function player.boundary()
  if player.x < 0 then
    player.x = 0
    player.xvel = 0
  end
  if player.y < 0 then
    player.y = 0
    player.yvel = 0
  end
  if player.x + player.width > screenWidth then
    player.x = screenWidth - player.width
    player.xvel = 0
  end
  if player.y + player.height > screenHeight then
    player.y = screenHeight - player.height
    player.yvel = 0
  end
end

function player.move(dt)
  if love.keyboard.isDown('d') and player.xvel < player.speed then
    player.xvel = player.xvel + player.speed * dt
  end
  if love.keyboard.isDown('a') and player.xvel > -player.speed then
    player.xvel = player.xvel - player.speed * dt
  end
  if love.keyboard.isDown('s') and player.yvel < player.speed then
    player.yvel = player.yvel + player.speed * dt
  end
  if love.keyboard.isDown('w') and player.yvel > -player.speed then
    player.yvel = player.yvel - player.speed * dt
  end
end

function player.shoot(key)
  if key == 'up' then
    bullet.spawn(player.x + player.width / 2 - bullet.width / 2, player.y - bullet.height, 'up')
  end
  if key == 'down' then
    bullet.spawn(player.x + player.width / 2 - bullet.width / 2, player.y + player.height, 'down')
  end
  if key == 'left' then
    bullet.spawn(player.x - bullet.width, player.y + player.height / 2, 'left')
  end
  if key == 'right' then
    bullet.spawn(player.x + player.width, player.y + player.height / 2, 'right')
    end
end

--Parent Functions
function DRAW_PLAYER()
  player.draw()
end

function UPDATE_PLAYER(dt)
  player.physics(dt)
  player.boundary()
  player.move(dt)
end
