function onScriptStart()
    if ReadValueString(0, 3) ~= 'SMN' then
        CancelScript()
    end
end

function onScriptCancel()
    SetScreenText('')
end

function onScriptUpdate()
    local p1 = 0x8154B804

    local rng
    local region = ReadValue8(0x80000003)
    if region == 0x45 then -- E
        rng = ReadValue32(0x80429F44)
    else
        if region == 0x4A then -- J
            rng = ReadValue32(0x80429C64)
	else -- Other region
            rng = -1
        end
    end

    local text = ''
    
    text = text .. '\n--  Level  --'
    text = text .. string.format('\nLevel Timer : %.5f', ReadValue32(0x80D25BF8) / 4096 + 1)
    text = text .. string.format('\nSprite Counter : %.0f', ReadValue32(0x80429450))

    text = text .. '\n\n--  Mario  --'
    text = text .. string.format('\nX,Y Position  : (%.4f, %.4f)', ReadValueFloat(p1 + 0x00AC), ReadValueFloat(p1 + 0x00B0))
    text = text .. string.format('\nX,Y Displaced : (%.4f, %.4f)', ReadValueFloat(p1 + 0x00C4), ReadValueFloat(p1 + 0x00C8))
    text = text .. string.format('\nX,Y Speed     : (%.4f, %.4f)', ReadValueFloat(p1 + 0x010C), ReadValueFloat(p1 + 0x00EC))
    text = text .. string.format('\nX,Y Accel     : (%.4f, %.4f)', ReadValueFloat(p1 + 0x011C), ReadValueFloat(p1 + 0x0114))

    text = text .. string.format('\nTwirl Timer   : %.0f', ReadValue32(p1 + 0x27C8))
    text = text .. string.format('\nSlide Timer   : %.0f', ReadValue32(p1 + 0x1A18))
    text = text .. string.format('\nSpin Timer    : %.0f', ReadValue32(p1 + 0x17C4))
    text = text .. string.format('\nAction Timer  : %.0f', ReadValue32(p1 + 0x1A18))
    text = text .. string.format('\nStar Timer    : %.0f', ReadValue32(p1 + 0x1070))
    text = text .. string.format('\nStored Jump   : %.0f', ReadValue32(p1 + 0x1564))

    text = text .. '\n\n--     RNG     --'
    text = text .. '\nRNG Value     : ' .. string.upper(string.format('%x', rng))

    SetScreenText(text)
end
