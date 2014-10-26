local box = {}
box.__index = box

function box.new(options)
	local self = setmetatable({}, box)
	self.size = vector.new(options.width, options.height)
	self.pos = vector.new(options.x, options.y)
	self.isSolid = true
	self.drawing = options.drawing
	
	self.top = {}
	self.top.size = vector.new(options.width, 1)
	self.top.pos = vector.new(options.x, options.y)

	return self
end

function box:update() end

function box:draw()
	if self.drawing then
		if self.drawing == "rectangle" then
			love.graphics.setColor(170, 121, 68)
			love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(self.drawing, self.pos.x, self.pos.y)
		end
	end
end

return box