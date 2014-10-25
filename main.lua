-- Globals
require "constants"
helpers = require "lib/helpers"
vector = require "lib/vector"
entities = {}
mode = 0

local player = require "entities/player"
local box = require "entities/box"

function love.load()
	table.insert(entities, player.new(100, 300))
	table.insert(entities, box.new(love.graphics.getHeight() - 20))
	table.insert(entities, box.new(love.graphics.getHeight() / 2))
end

function love.update(dt)
	for i,v in ipairs(entities) do
		v:update(dt)
	end
end

function love.draw()
	for i,v in ipairs(entities) do
		v:draw()
	end
end