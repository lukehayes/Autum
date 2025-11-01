--[[
/************************************************* Event Manager  *******/
/*                                                                      */
/*              /\_/\           ___                                     */
/*             = o_o =_______    \ \  -LDH-                             */
/*              __^      __(  \.__) )                                   */
/*          (@)<_____>__(_____)____/                                    */
/*                                                                      */
/*                                                                      */
/*  Description:                                                        */
/*                                                                      */
/*  Event manager that can emit events for objects to listen for        */
/*  -------------------------------------------------------------       */
/*  https://www.github.com/                                             */
/*                                                                      */
/*                                                                      */
/************************************************************************/
]]

local EventManager = {
  events = {
    preload    = {},
    load       = {},
    postload   = {},

    preupdate  = {},
    update     = {},
    postupdate = {},

    prerender  = {},
    render     = {},
    postrender = {},
  }
}
EventManager.__index = EventManager


-- Listen for a particular event
function EventManager:listen(id, event, cb)
  if self.events[event] ~= nil then
    table.insert(self.events[event], id, cb)
    --table.insert(self.events[event], cb)
  else
    self.events[event] = {}
    table.insert(self.events[event], id, cb)
  end
end

-- Let all of the subcribers know that an event has happend.
function EventManager:emit(event)
  if self.events[event] then
    for id, fn in pairs(self.events[event]) do
      if type(fn) == 'function' then
        fn(id)
      end
    end
  end
end

return EventManager
