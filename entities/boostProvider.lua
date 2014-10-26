local boostProvider = {}
boostProvider.__index = boostProvider

local IMAGE = love.graphics.newImage("graphics/coffemachine.png")

function boostProvider.new(x, y)
	local self = setmetatable({}, boostProvider)
	self.pos = vector.new(x, y)
	self.size = vector.new(love.graphics.getDimensions())
	self.isboostProvider = true
	self.energyPerBoost = 10
	
	return self
end

function boostProvider:giveBoostTo()
	
end

function boostProvider:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(IMAGE, self.pos.unpack())
end

return boostProvider