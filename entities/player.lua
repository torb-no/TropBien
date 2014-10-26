local player, o = {}, {}

local ACCELECARTION = 700
local JUMP_ACC = -52000
local TOP_VELOCITY = 500
local FALL_ACCELERATION = 800
local FRICTION = 500
local TERMINAL_VELOCITY = 500
local IMAGE = love.graphics.newImage("graphics/walk/Hat_man1.png")

function player.new(options)
	o.pos = vector.new(options.x, options.y) -- position
	o.vel = vector.new(0, 0) -- velocity
	o.acc = vector.new(0, 0) -- acceleration
	o.size = vector.new(IMAGE:getWidth(), IMAGE:getHeight()) -- width and height
	o.isStanding = false
	
	return o
end

function o:update(dt)
	-- controls
	if love.keyboard.isDown("left") then
		self.acc.x = -ACCELECARTION
	elseif love.keyboard.isDown("right") then
		self.acc.x = ACCELECARTION
	end
	
	-- gravity
	self.acc.y = self.acc.y + FALL_ACCELERATION
	
	-- friction
	local friction = self.vel:clone()
	friction = friction * -1
	friction:normalize_inplace()
	friction = friction * FRICTION
	self.acc.x = self.acc.x + friction.x

	-- velocity
	self.vel = self.vel + self.acc * SPD * dt
	self.vel.x = helpers.limit(self.vel.x, -TOP_VELOCITY, TOP_VELOCITY)
	self.vel.y = helpers.limit(self.vel.y, -TOP_VELOCITY, TERMINAL_VELOCITY)
	
	-- position
	local newPos = self.pos + self.vel * SPD * dt
	
	self.isStanding = false
	-- collision detection: objects that canStandOn = true
	for i,v in ipairs(entities) do
		if v.isSolid then
			if helpers.boxesIntersect(newPos, self.size, v.pos, v.top.size) and self.pos.y <= v.pos.y - self.size.y then
				newPos.y = helpers.limit(newPos.y, -999, v.pos.y - self.size.y)
				self.isStanding = true
			end
		end
	end
	
	-- collision detection: walls
	newPos.x = helpers.limit( newPos.x, 0, love.graphics.getWidth() - self.size.y )
	
	self.pos = newPos
	
	o.acc = o.acc * 0
end

function o:jump()
	if self.isStanding then
		self.acc.y = JUMP_ACC
	end
end

function o:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(IMAGE, self.pos.x, self.pos.y)
end

return player