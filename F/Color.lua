--[[
/************************************************* Color  ***************/
/*                                                                      */
/*              /\_/\           ___                                     */
/*             = o_o =_______    \ \  -LDH-                             */
/*              __^      __(  \.__) )                                   */
/*          (@)<_____>__(_____)____/                                    */
/*                                                                      */
/*                                                                      */
/*  Description:                                                        */
/*                                                                      */
/*  Color helpers.                                                      */
/*  -------------------------------------------------------------       */
/*  https://www.github.com/                                             */
/*                                                                      */
/*                                                                      */
/************************************************************************/
]]

function DrawColor(r,g,b,a)
	local rr = r or 255
	local gg = g or 255
	local bb = b or 255
	local aa = a or 255
	love.graphics.setColor(rr,gg,bb,aa)
end

function ResetDrawColor()
	love.graphics.setColor(255,255,255,255)
end
