local player, o = {}, {}

local ACCELECARTION = 700
local JUMP_ACC = -20000
local TOP_VELOCITY = 500
local FALL_ACCELERATION = 400
local TERMINAL_VELOCITY = 150
local FRICTION = 500
local IMAGE = love.graphics.newImage("graphics/walk/Hat_man1.png")

function player.new(options)
	o.pos = vector.new(options.x, options.y) -- position
	o.vel = vector.new(0, 0) -- velocity
	o.acc = vector.new(0, 0) -- acceleration
	o.size = vector.new(IMAGE:getWidth(), IMAGE:getHeight()) -- width and height
	o.canStandOn = false
	
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
	self.vel.y = helpers.limit(self.vel.y, -999999999, TERMINAL_VELOCITY)
	
	-- position
	self.pos = self.pos + self.vel * SPD * dt
	
	-- collision detection: objects that canStandOn = true
	for i,v in ipairs(entities) do
		if v.canStandOn then
			if helpers.withinX(self, v) and helpers.isAbove(self, v) then
				self.pos.y = helpers.limit(self.pos.y, -999, v.pos.y - self.size.y)
			end
		end
	end
	
	-- collision detection: walls
	self.pos.x = helpers.limit( self.pos.x, 0, love.graphics.getWidth() - self.size.y )
	
	
	o.acc = o.acc * 0
end

function o:jump()
	self.acc.y = JUMP_ACC
end

function o:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(IMAGE, self.pos.x, self.pos.y)
	-- love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return player