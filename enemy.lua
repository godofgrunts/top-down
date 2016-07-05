enemy = {}

enemy.timer = 0
enemy.timerLim = love.math.random(3,5)
enemy.amount = love.math.random(1,4)
enemy.side = love.math.random(1,4)

function enemy.generate(dt)
  enemy.timer = enemy.timer + dt
  if enemy.timer > enemy.timerLim then
    for i=1,enemy.amount do
      if enemy.side == 1 then
        --left
        enemy.spawn(-50, screenHeight / 2 - enemy.width)
      end
      if enemy.side == 2 then
        --top
        enemy.spawn(screenWidth / 2 - enemy.width, -enemy.height)
      end
      if enemy.side == 3 then
        --right
        enemy.spawn(screenWidth, screenHeight / 2 - enemy.height)
      end
      if enemy.side == 4 then
        --bottom
        enemy.spawn(screenWidth / 2 - enemy.width, screenHeight)
      end
      enemy.side = love.math.random(1,4)
    end
    enemy.amount = love.math.random(1,4)
    enemy.timerLim = love.math.random(3,5)
    enemy.timer = 0
  end
end


enemy.width = 50
enemy.height = 50
enemy.speed = 1000
enemy.friction = 10

function enemy.bullet_collide()
  for i,v in ipairs(enemy) do
    for ia,va in ipairs(bullet) do
      if (CheckCollision(v.x, v.y, v.width, v.height, va.x, va.y, va.width, va.height)) then
        table.remove(enemy, i)
        table.remove(bullet, ia)
      end
    end
  end

end

function enemy.spawn(x,y)
  table.insert(enemy, {x = x, y = y, xvel = 0, yvel = 0, health = 2, width = enemy.width, height = enemy.height})
end

function enemy.draw()
    for i,v in ipairs(enemy) do
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', v.x, v.y, enemy.width, enemy.height)
    end
end

function enemy.physics(dt)
  for i,v in ipairs(enemy) do
    v.x = v.x + v.xvel * dt
    v.y = v.y + v.yvel * dt
    v.xvel = v.xvel * (1 - math.min(dt*enemy.friction, 1))
    v.yvel = v.yvel * (1 - math.min(dt*enemy.friction, 1))
  end
end

function enemy.AI(dt)
  for i,v in ipairs(enemy) do
    -- X axis
    if player.x + player.width / 2 < v.x + v.width / 2 then
      if v.xvel > -enemy.speed then
        v.xvel = v.xvel - enemy.speed * dt
      end
    end
    if player.x + player.width / 2 > v.x + v.width / 2 then
      if v.xvel < enemy.speed then
        v.xvel = v.xvel + enemy.speed * dt
      end
    end
    -- Y axis
    if player.y + player.height / 2 > v.y + v.height / 2 then
      if v.yvel < enemy.speed then
        v.yvel = v.yvel + enemy.speed * dt
      end
    end
    if player.y + player.height / 2 < v.y + v.height / 2 then
      if v.yvel > -enemy.speed then
        v.yvel = v.yvel - enemy.speed * dt
      end
    end
  end
end
--PARENT function
function DRAW_ENEMY()
  enemy.draw()
end
function UPDATE_ENEMY(dt)
  enemy.physics(dt)
  enemy.AI(dt)
  enemy.generate(dt)
  enemy.bullet_collide()
end
