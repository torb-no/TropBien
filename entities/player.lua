local player, o = {}, {}

local ACCELECARTION = 400
local TOP_VELOCITY = 150
local FALL_ACCELERATION = 60
local TERMINAL_VELOCITY = 100

function player.new(x,y)
	o.pos = vector.new(x, y) -- position
	o.vel = vector.new(0, 0) -- velocity
	o.acc = vector.new(0, 0) -- acceleration
	o.size = vector.new(20, 60) -- width and height
	o.isPlayer = true
	
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
	
	-- velocity
	self.vel = self.vel + self.acc * SPD * dt
	self.vel.x = helpers.limit(self.vel.x, -TOP_VELOCITY, TOP_VELOCITY)
	self.vel.y = helpers.limit(self.vel.y, -999999999, TERMINAL_VELOCITY)
	
	-- position
	self.pos = self.pos + self.vel * SPD * dt
	
	-- collision detection
	for i,v in ipairs(entities) do
		if not v.isPlayer then
			print(helpers.isAbove(self, v))
			if v:canStandOn() and helpers.withinX(self, v) and helpers.isAbove(self, v) then
				self.pos.y = helpers.limit(self.pos.y, -999, v.pos.y - self.size.y)
			end
		end
	end
	
	o.acc = o.acc * 0
end

function o:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return player