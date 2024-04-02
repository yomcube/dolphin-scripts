from dolphin import event, gui, memory

p1 = 0x8154b804

@event.on_frameadvance
def on_frame_advance():
    ps = memory.read_u32(p1 + 0x14E0)
    region = memory.read_u8(0x80000003)
    if region == 0x45: # E
        rng = memory.read_u32(0x80429F44)
    elif region == 0x4A: # J
        rng = memory.read_u32(0x80429C64)
    else:
        rng = -1
    
    text = ''
    text = text + '\n--  Level  --'
    text = text + '\nLevel Timer : {:.5f}'.format(memory.read_u32(0x80D25BF8) / 4096 + 1)
    text = text + '\nRNG Value   : ' + hex(rng)
    switchtimer = memory.read_u32(0x815E4338)
    if switchtimer != 0:
        text = text + '\nSwitch Timer : ' + hex(switchtimer)
    
    text = text + '\n\n--  Mario  --'
    text = text + '\nX,Y Position  : ({:.4f}, {:.4f})'.format(memory.read_f32(p1 + 0xAC ), memory.read_f32(p1 + 0xB0))
    text = text + '\nX,Y Displaced : ({:.4f}, {:.4f})'.format(memory.read_f32(p1 + 0xC4 ), memory.read_f32(p1 + 0xC8))
    text = text + '\nX,Y Speed     : ({:.4f}, {:.4f})'.format(memory.read_f32(p1 + 0x10C), memory.read_f32(p1 + 0xEC))
    text = text + '\nX,Y Accel     : ({:.4f}, {:.4f})'.format(memory.read_f32(p1 + 0x11C), memory.read_f32(p1 + 0x114))
    #text = text + '\nX Speed Cap   : {:.4f}'.format(memory.read_f32(p1 + 0x110))
    text = text + '\n Twirl Timer  : ' + str(memory.read_u32(p1 + 0x27C8))
    if ps == 5:
        text = text + '\n Slide Timer  : ' + str(memory.read_u32(p1 + 0x1A18))
    elif ps == 4:
        text = text + '\n Spin Timer   : ' + str(memory.read_u32(p1 + 0x17C4))
    text = text + '\n Action Timer : ' + str(memory.read_u32(p1 + 0x1A18))
    startimer = memory.read_u32(p1 + 0x1070)
    if startimer != 0:
        text = text + '\n Star Timer   : ' + str(startimer)
    text = text + '\n Stored Jump  : ' + str(memory.read_u32(p1 + 0x1564))
    pipe1 = memory.read_u8(p1 + 0x420)
    if pipe1 != 0:
        text = text + '\n Pipe Timer   : ' + str(pipe1)
    else:
        text = text + '\n Pipe Timer   : ' + str(memory.read_u8(p1 + 0x421))
    
    gui.draw_text((10, 10), 0xFF00FFFF, text)
