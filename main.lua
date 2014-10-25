-- Globals
require "constants"
helpers = require "lib/helpers"
vector = require "lib/vector"
entities = {}
mode = 0

local player = require "entities/player"
local thePlayer = player.new{ x=100, y=700 }
local box = require "entities/box"
local background = love.graphics.newImage("graphics/background.png")

function love.load()
	-- random seed for boxadding
	math.randomseed(os.time())
	
	-- add player
	table.insert(entities, thePlayer)
	
	-- add floors
	floor1 = box.new{ x=0, y=251, width=love.graphics.getWidth(), height=26 }
	table.insert(entities, floor1 )
	
	floor2 = box.new{ x=0, y=531, width=love.graphics.getWidth(), height=26 }
	table.insert(entities, floor2 )
	
	floor3 = box.new{ x=0, y=811, width=love.graphics.getWidth(), height=26 }
	table.insert(entities, floor3 )
	
	-- add some boxes
	addBoxesOn{floor=floor1, minAmount=2, maxAmount=12}
	addBoxesOn{floor=floor2, minAmount=2, maxAmount=12}
	addBoxesOn{floor=floor3, minAmount=2, maxAmount=12}

end

function addBoxesOn(options)
	local actualMax = math.random(options.minAmount, options.maxAmount)
	for i=1, actualMax, 1 do
		local params = {}
		
		params.drawing = "rectangle"
		
		params.width = math.random(50, 130)
		params.height = math.random(20, 90)
		
		params.x = math.random(0, love.graphics.getWidth() - params.width)
		params.y = options.floor.pos.y - params.height
		
		table.insert(entities, box.new(params))
	end
end

function love.update(dt)
	for i,v in ipairs(entities) do
		v:update(dt)
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(background, 0, 0)
	for i,v in ipairs(entities) do
		v:draw()
	end
end

function love.keypressed(key)
	if key == "escape" or key == "q" then
		love.event.quit()
	elseif key == " " then
		thePlayer:jump()
	end
end