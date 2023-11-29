import "CoreLibs/graphics"

import "words.lua"

local gfx <const> = playdate.graphics
local dply <const> = playdate.display

local words = MyWords()

function MyShuffle(a)
    local z = {}
    for i = #a, 1, -1 do
        local j = math.random(i)
        a[i], a[j] = a[j], a[i]
        table.insert(z, a[i])
    end
    return z
end

words = MyShuffle(words)

local scrambled = {}

function MyScrambled(w, p)
    local s = {}
    for key, value in pairs(w) do
        if #value <= p then
            local a = ""
            for i = 1, #value do
                a = a .. "-"
            end
            table.insert(s, a)
        else
            local b = {}
            for i = 1, #value do
                b[i] = i
            end
            b = MyShuffle(b)
            local c = value
            for i = 1, p do
                c = string.sub(c, 0, b[i]-1) .. "-" .. string.sub(c, b[i]+1)
            end
            table.insert(s, c)
        end
    end
    return s
end

scrambled = MyScrambled(words, 3)

local pos = 1
local width  = 200
local height = 120
local flip = false

function playdate.update() 

    gfx.clear()

    dply.setScale(2)

    local w,h = gfx.getTextSize(words[pos])

    local mfw = math.floor((width / 2) - (w / 2))
    local mfh = math.floor((height / 2) - (h / 2))

	if flip == true then
    	gfx.drawText(words[pos], mfw, mfh)
	else
		gfx.drawText(scrambled[pos], mfw, mfh)
	end

end

function playdate.leftButtonDown()
    pos = pos - 1
    if pos == 0 then
        pos = #words
    end
end

function playdate.rightButtonDown()
    pos = pos + 1
    if pos == (#words + 1) then
        pos = 1
    end
end

function playdate.BButtonDown()
	flip = true
	--print(flip)
end

function playdate.BButtonUp()
	flip = false
	--print(flip)
end
