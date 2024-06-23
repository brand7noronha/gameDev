--[[
    GD50 2018
    Pong Remake

    -- Ball Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a ball which will bounce back and forth between paddles
    and walls until it passes a left or right boundary of the screen,
    scoring a point for the opponent.
]]

Ball = Class {}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
end

--[[
    Expects a paddle as an argument and returns true or false, depending
    on whether their rectangles overlap.
]]
function Ball:collides(paddle)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    -- if the above aren't true, they're overlapping
    return true
end

--[[
    Places the ball in the middle of the screen, with an initial random velocity
    on both axes.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    Simply applies velocity to position, scaled by deltaTime.
]]
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

--[[
   Renders the ball's X and Y directional speeds on the display  
]]
function Ball:displaySpeed(font)
    -- draw ball's speed, i.e., its dx and dy
    love.graphics.setFont(font)
    love.graphics.setColor(235 / 255, 47 / 255, 49 / 255)
    love.graphics.print('y-speed: ' .. tostring(ball.dy), 30, VIRTUAL_HEIGHT / 3)
    love.graphics.print('x-speed: ' .. tostring(ball.dx), 30, (VIRTUAL_HEIGHT / 3) + 10)
end

--[[
   Renders the ball's X-axis and Y-axis on the display 
]]
function Ball:displayAxis(font)
    love.graphics.setFont(font)
    love.graphics.setColor(145 / 255, 6 / 255, 184 / 255)
    love.graphics.print('y-axis: ' .. tostring(ball.y), 30, VIRTUAL_HEIGHT / 3 + 20)
    love.graphics.print('x-axis: ' .. tostring(ball.x), 30, (VIRTUAL_HEIGHT / 3) + 30)
end