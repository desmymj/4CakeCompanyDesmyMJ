

-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Desmy Michaelis-Joseph
-- Date: 4/25/18
-- Description: This is the splash screen of the game. It displays the 
-- company logo that fades in and fades out along with the company name
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local CompanyLogo 
local CompanyLogoText

-- Sounds
local DramaticSounds = audio.loadSound("Sounds/DUN DUN DUUUUN!!! (Dramatic Sound Effect).mp3")
local DramaticSoundsChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- Fades in the company Logo and Name
local function FadeIn()
    transition.to(CompanyLogoText, {time = 1000, alpha = 1})
    transition.to(CompanyLogo, {time = 1000, alpha = 1})
end


-- Fades out the company logo
local function FadeOut()
    transition.to(CompanyLogo, {time = 1000, alpha = 0})
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be greenish blue
    display.setDefault("background", 0.25, 1, 0.76)

    -- Create the company logo
    CompanyLogo = display.newImageRect("Images/CompanyLogoTristan.png",400,400)
    CompanyLogo.x = display.contentWidth/2
    CompanyLogo.y = display.contentHeight/2
    CompanyLogo.alpha = 0

    -- create the text
    CompanyLogoText = display.newText("4 Cake Company",525,700,Arial,70)
    CompanyLogoText:setTextColor(1 , 0, 1)
    CompanyLogoText.alpha = 0

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( CompanyLogo )
    sceneGroup:insert( CompanyLogoText )
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        DramaticSoundsChannel = audio.play( DramaticSounds )

        -- calls the function to fade in
        FadeIn()

        -- calls the function to fade out after 3 seconds
        timer.performWithDelay(3000,FadeOut)

         -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 4000, gotoMainMenu)        
    end             

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the Dramatic sounds channel for this screen
        audio.stop(DramaticSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene