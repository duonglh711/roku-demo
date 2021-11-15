' ********** Copyright 2020 Roku Corp.  All Rights Reserved. **********

' entry point of  MainScene
' Note that we need to import this file in MainScene.xml using relative path.
sub Init()
    m.button = m.top.findNode("button")
    m.top.setFocus(true)
    info = CreateObject("roDeviceInfo")
    displaySize = info.GetDisplaySize()
    m.width = displaySize.w
    m.height = displaySize.h
    m.button.translation = [m.width/2 - m.button.width/2 , m.height/2 - m.button.height/2]
end sub

function OnkeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "OK"
            m.button.translation = [Rnd(m.width - m.button.width), Rnd(m.height - m.button.height) ]
        end if
    end if
end function