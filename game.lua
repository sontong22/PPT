
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Initialize variables
local table
local gameLoopTimer

local backGroup
local mainGroup
local uiGroup

local function updateText()
    funText.text = "Lives: " .. lives
end

local function gameLoop()

end

local function onCollision(event)

end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()

	-- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

	uiGroup = display.newGroup()    -- Display group for UI objects like the score
	sceneGroup:insert( uiGroup )    -- Insert into the scene's view group

  -- Load assets
	local table = display.newImageRect( mainGroup, "table.png", 1300, 670 )
	table.x = display.contentCenterX
	table.y = display.contentHeight * 0.65
  physics.addBody( table, "dynamic", {radius = 650, friction = 0.05, bounce = 0.85} )
end


-- show()
function scene:show( event )

  local sceneGroup = self.view
	-- local phase = event.phase
  --
	-- if ( phase == "will" ) then
	-- 	-- Code here runs when the scene is still off screen (but is about to come on screen)
  --
	-- elseif ( phase == "did" ) then
	-- 	-- Code here runs when the scene is entirely on screen
  --
	-- end
end


-- hide()
function scene:hide( event )

  local sceneGroup = self.view
	-- local phase = event.phase
  --
	-- if ( phase == "will" ) then
	-- 	-- Code here runs when the scene is on screen (but is about to go off screen)
  --
	-- elseif ( phase == "did" ) then
	-- 	-- Code here runs immediately after the scene goes entirely off screen
  --
	-- end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
