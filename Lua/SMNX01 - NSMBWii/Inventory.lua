function onScriptStart()
    if ReadValueString(0, 3) ~= 'SMN' then
        CancelScript()
    end
end

function onScriptCancel()
    SetScreenText('')
end

function onScriptUpdate()
	local savefile = ReadValue8(0x80C7F7C6)
	local base = 0x80C7FE69 + (savefile * 0x980)
	local text = ''
	
	text = text .. "--  Inventory --"
	text = text .. string.format("\nMushrooms      : %d", ReadValue8(base + 0))
	text = text .. string.format("\nFire Flowers   : %d", ReadValue8(base + 1))
	text = text .. string.format("\nPropellers     : %d", ReadValue8(base + 2))
	text = text .. string.format("\nIce Flowers    : %d", ReadValue8(base + 3))
	text = text .. string.format("\nPenguin Suits  : %d", ReadValue8(base + 4))
	text = text .. string.format("\nMini Mushrooms : %d", ReadValue8(base + 5))
	text = text .. string.format("\nStars          : %d", ReadValue8(base + 6))
	
	SetScreenText(text)
end
