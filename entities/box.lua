local box = {}
box.__index = box

-- TODO: Generalize into actual box (and not floor)

function box.new(xPos)
	local self = setmetatable({}, box)
	self.size = vector.new(love.graphics.getWidth(), 20)
	self.pos = vector.new(0, xPos)

	return self
end

function box:update() end

function box:canStandOn() return true end

function box:draw()
	love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return box