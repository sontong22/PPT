
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

local function dragPaddle( event )

  local paddle = event.target
  local phase = event.phase

  if ( "began" == phase ) then
    -- Set touch focus on the ship
    display.currentStage:setFocus( paddle )
    -- Store initial offset position
    paddle.touchOffsetX = event.x - paddle.x
    paddle.touchOffsetY = event.y - paddle.y

  elseif ( "moved" == phase ) then
    -- Move the ship to the new touch position
    paddle.x = event.x - paddle.touchOffsetX
    paddle.y = event.y - paddle.touchOffsetY

  elseif ( "ended" == phase or "cancelled" == phase ) then
    -- Release touch focus on the ship
    display.currentStage:setFocus( nil )
  end

  return true -- Prevents touch propagation to underlying objects
end

local function onCollision( event )

  if ( event.phase == "began" ) then

    local obj1 = event.object1
    local obj2 = event.object2

    if ( ( obj1.myName == "paddle" and obj2.myName == "ball" ) or
    ( obj1.myName == "ball" and obj2.myName == "paddle" ) )
    then
      -- Remove both the laser and asteroid
      obj1.setLinearVelocity(80, - 20)
  --
  --
  -- elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
  --   ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
  --   then
  --     if ( died == false ) then
  --       died = true
  --
  --       -- Update lives
  --       lives = lives - 1
  --       livesText.text = "Lives: " .. lives
  --
  --       if ( lives == 0 ) then
  --         display.remove( ship )
  --       else
  --         ship.alpha = 0
  --         timer.performWithDelay( 1000, restoreShip )
  --       end
  --     end
    end
  end
end

local function gameLoop()

end

-- local function onCollision(event)
--
-- end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen

  physics.pause()

  -- Set up display groups
  backGroup = display.newGroup() -- Display group for the background image
  sceneGroup:insert( backGroup ) -- Insert into the scene's view group

  mainGroup = display.newGroup() -- Display group for the ship, asteroids, lasers, etc.
  sceneGroup:insert( mainGroup ) -- Insert into the scene's view group

  uiGroup = display.newGroup() -- Display group for UI objects like the score
  sceneGroup:insert( uiGroup ) -- Insert into the scene's view group

  -- Load assets
  local background = display.newImageRect( backGroup, "bg.png", 1380, 1380 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local table = display.newImageRect( mainGroup, "table.png", 1300, 670 )
  table.x = display.contentCenterX
  table.y = display.contentHeight * 0.65
  -- physics.addBody( table, "static", {radius = 650, friction = 0.05, bounce = 0.85} )

  local ball = display.newImageRect( mainGroup, "ball.png", 60, 60 )
  ball.x = display.contentCenterX
  ball.y = display.contentHeight * 0.3
  ball.alpha = 0.95
  physics.addBody( ball, "dynamic", {radius = 30, friction = 0.08, density = 0.2, bounce = 1, isSensor = true} )
  ball.myName = "ball"

  local scale = 0.6
  local paddle = display.newImageRect( mainGroup, "paddle.png", 392 * scale, 574 * scale )
  paddle.x = display.contentCenterX
  paddle.y = display.contentHeight * 0.65
  paddle.alpha = 0.95
  physics.addBody( paddle, "static", {radius = 200, friction = 0.08, bounce = 1} )
  paddle.myName = "paddle"


  paddle:addEventListener( "touch", dragPaddle )

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

  physics.start()
  physics.setGravity(0, 9.8)
  Runtime:addEventListener( "collision", onCollision )

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
