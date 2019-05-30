local physics = require "physics"


physics.start()




physics.setGravity( 0, 0 )
local backGroup=display.newGroup( )
local mainGroup=display.newGroup( )

local background=display.newImageRect( backGroup, "s.jpg",720,1280 )
background.x=display.contentCenterX
background.y=display.contentCenterY

local block_1 = display.newRect(280, 390, 40, 280)
local block_2 = display.newRect(280, 50, 40, 150)

local block_3 = display.newRect(400, 430, 40, 280)
local block_4 = display.newRect(400, 70, 40, 190)

local block_5 = display.newRect(520, 470, 40, 280)
local block_6 = display.newRect(520, 100, 40, 250)
block_6:setFillColor(0.3,0.7,0.9)

local block_7 = display.newRect(640, 510, 40, 280)
local block_8 = display.newRect(640, 120, 40, 290)

local bird = display.newRect(40, 200, 20, 20)
bird:setFillColor(0.5,0.7,0.9)
physics.addBody(block_1, "static")
physics.addBody(block_2, "static")
physics.addBody(block_3, "static")
physics.addBody(block_4, "static")
physics.addBody(block_5, "static")
physics.addBody(block_6, "static")
physics.addBody(block_7, "static")
physics.addBody(block_8, "static")
bird.ID = "Bird"
block_1.ID = "Crash"
block_2.ID = "Crash"
block_3.ID = "Crash"
block_4.ID = "Crash"
block_5.ID = "Crash"
block_6.ID = "Crash"
block_7.ID = "Crash"
block_8.ID = "Crash"
local function onLocalCollision (self, event)
  if(event.phase == "began") then
    if(self.ID == "Bird" and event.other.ID == "Crash") then
      bird:removeEventListener("collision", bird)
  Runtime:removeEventListener("enterFrame", onUpdate)
  -- bird:removeEventListener("touch", dragShip)
  local text = display.newText("End", 160, 100, font, 32)
  text:setFillColor(0,0,0)
    end
  end
end

local speed = 0.7
local function onUpdate (event)
  block_1.x = block_1.x - speed
  block_2.x = block_1.x - speed

  block_3.x = block_3.x - speed
  block_4.x = block_3.x - speed

  block_5.x = block_5.x - speed
  block_6.x = block_5.x - speed

  block_7.x = block_7.x - speed
  block_8.x = block_7.x - speed

--÷òîáû áëîêè ãåíåðèðîâàëèñü

  if(block_1.x <= -20) then
    block_1.x = block_7.x + 120
  elseif(block_3.x <= -20) then
    block_3.x = block_1.x + 120
  elseif(block_5.x <= -20) then
    block_5.x = block_3.x + 120
  elseif(block_7.x <= -20) then
    block_7.x = block_5.x + 120
  end

end
local function fireLaser()

    local newLaser = display.newImageRect( mainGroup, "s.jpg",10,10 )
    physics.addBody( newLaser, "dynamic", { isSensor=true } )
    newLaser.isBullet = true
    newLaser.myName = "laser"




    newLaser.x = bird.x
    newLaser.y = bird.y
    newLaser:toBack()--опускает вниз

    transition.to( newLaser, { y=40, time=500,
        onComplete = function()
         display.remove( newLaser ) --если прилетел - удалить 
    end
    } )--что должно двигаться и куда
end


physics.addBody( bird,{radius=0,inSensor=true})
bird.myname="bird"

local function dragShip( event )

    local ship = event.target--цель ивента
    local phase = event.phase--проверяем фазу ивента 4 фазы касания

    if ( phase == "began" ) then
        -- Set touch focus on the ship
        display.currentStage:setFocus( ship )
        -- Store initial offset position
        bird.touchOffsetX = event.x - bird.x
        bird.touchOffsetY = event.y - bird.y
        --event.x - откуда началось ship.x - где корабль
    elseif ( phase == "moved" ) then
        -- Move the ship to the new touch position
        bird.x = event.x - bird.touchOffsetX
        bird.y = event.y - bird.touchOffsetY

    elseif ( phase == "ended" or  phase == "cancelled" ) then
        -- Release touch focus on the ship
        display.currentStage:setFocus( nil )
    end

    return true  -- Prevents touch propagation to underlying objects
end
bird:addEventListener( "tap", fireLaser )




bird.collision = onLocalCollision
bird:addEventListener("collision", bird)

Runtime:addEventListener("enterFrame", onUpdate)

bird:addEventListener("touch", dragShip)
