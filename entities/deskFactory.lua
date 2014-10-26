-- Pleae excuse the java-ism

local IMG_SMALL_DESK = love.graphics.newImage("graphics/smallDesk.png")
local IMG_BIG_DESK = love.graphics.newImage("graphics/bigDesk.png")
local IMG_BIG_DESK_WITH_COMP = love.graphics.newImage("graphics/bigDeskWithComp.png")

local deskFactory = {}

function deskPart(x, y, image)
	return box.new{
		x=x, y=y,
		width=image:getWidth(),
		height=image:getHeight(),
		drawing=image
	}
end

function deskFactory.deskPairAtLocation(x, y)
	return deskPart(x, y, IMG_SMALL_DESK)
end

return deskFactory