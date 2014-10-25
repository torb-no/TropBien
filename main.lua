-- Globals
require "constants"
helpers = require "lib/helpers"
vector = require "lib/vector"
entities = {}
mode = 0

local player = require "entities/player"
local thePlayer = player.new{x=100, y=600}
local box = require "entities/box"
local background = love.graphics.newImage("graphics/background.png")

function love.load()
	table.insert(entities, thePlayer)
	
	-- floors
	table.insert(entities, box.new{x=0, y=251, width=love.graphics.getWidth(), height=26} )
	table.insert(entities, box.new{x=0, y=531, width=love.graphics.getWidth(), height=26} )
	table.insert(entities, box.new{x=0, y=811, width=love.graphics.getWidth(), height=26} )
	
	-- walls (outside viewport)
	table.insert(entities, box.new{x=-20, y=0, width=20, height=love.graphics.getHeight()})
	table.insert(entities, box.new{x=love.graphics.getWidth(), y=0, width=20, height=love.graphics.getHeight()})
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