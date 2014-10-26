-- Pleae excuse the java-ism

local IMG_SMALL_DESK = love.graphics.newImage("graphics/smallDesk.png")
local IMG_BIG_DESK = love.graphics.newImage("graphics/bigDesk.png")
local IMG_BIG_DESK_WITH_COMP = love.graphics.newImage("graphics/bigDeskWithComp.png")

local entityHelpers = {}

function deskPart(x, y, image)
	return box.new{
		x=x, y=y,
		width=image:getWidth(),
		height=image:getHeight(),
		drawing=image
	}
end

function entityHelpers.addRandomDeskPair(options)
	local actualMax = math.random(options.minAmount, options.maxAmount)
	for i=1, actualMax, 1 do
		entityHelpers.addDeskPairOnFloor(options.floor)
	end
end

function entityHelpers.addDeskPairOnFloor(floor)
	
	local smallPart = deskPart(400, 400, IMG_SMALL_DESK)
	placeOnFloor(smallPart, floor)
	
	local bigPart = deskPart(0, 0, IMG_BIG_DESK)
	placeOnFloor(bigPart, floor)
	
	smallPart.pos.x = math.random( 0, love.graphics.getWidth() - (smallPart.size.x + bigPart.size.x) )
	bigPart.pos.x = smallPart.pos.x + smallPart.size.x
	
	table.insert(entities, smallPart)
	table.insert(entities, bigPart)
end

function placeOnFloor(object, floor)
	object.pos.y = floor.pos.y - object.size.y
end

return entityHelpers