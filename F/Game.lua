--[[
/************************************************* Game  ****************/
/*                                                                      */
/*              /\_/\           ___                                     */
/*             = o_o =_______    \ \  -LDH-                             */
/*              __^      __(  \.__) )                                   */
/*          (@)<_____>__(_____)____/                                    */
/*                                                                      */
/*                                                                      */
/*  Description:                                                        */
/*                                                                      */
/*  Global game state is stored in here.                                */
/*  -------------------------------------------------------------       */
/*  https://www.github.com/                                             */
/*                                                                      */
/*                                                                      */
/************************************************************************/
]]

local Events = require 'F.event.EventManager'

local Game = {}
Game.__index = Game
Game.screen_width, Game.screen_height = love.graphics.getDimensions()
Game.tile_size  = 16
Game.tile_scale = 4

Game.states = {
    playing   = 'playing',
    paused    = 'paused',
    main_menu = 'main_menu'
}

Game.current_state = Game.states['main_menu']

function Game.getCurrentState()
  return Game.current_state
end


Game.events = Events

return Game
