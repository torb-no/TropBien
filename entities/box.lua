local box = {}
box.__index = box

function box.new(options)
	local self = setmetatable({}, box)
	self.size = vector.new(options.width, options.height)
	self.pos = vector.new(options.x, options.y)
	self.canStandOn = true

	return self
end

function box:update() end

function box:draw()
	love.graphics.setColor(255, 0, 0, 100)
	--love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return box