local helpers = {}

function helpers.inherit(a,b) --let's a inherit from b
	setmetatable(a,b)
	b.__index = b
end

-- expects vector types
function helpers.boxesIntersect(pos1, size1, pos2, size2)
	return
		pos1.x < pos2.x + size2.x and
		pos2.x < pos1.x + size1.x and
		pos1.y < pos2.y + size2.y and
		pos2.y < pos1.y + size1.y
end

function helpers.limit(value, min, max)
	local v = value
	
	if value < min then v = min end
	if value > max then v = max end
	
	return v
end

function helpers.withinX(a, b)
	return
		a.pos.x + a.size.x > b.pos.x and
		a.pos.x < b.pos.x + b.size.x
end

function helpers.isAbove(a, b)
	return a.pos.y + a.size.y < b.pos.y + b.size.y
end

return helpers