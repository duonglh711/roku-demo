sub init()
    videocontent = createObject("RoSGNode", "ContentNode")
    videocontent.title = "Example Video"
    videocontent.streamformat = "mp4"
    videocontent.url = "pkg:/images/big+stream+trimmed.mp4"

    m.video = m.top.findNode("exampleVideo")
    m.video.content = videocontent

    m.video.setFocus(true)
    m.video.control = "play"

  end sub

  function OnkeyEvent(key as String, press as Boolean) as Boolean
    result = true
    if key = "OK"
        ?"before: " m.video.control
        if m.video.state = "playing"
            m.video.control = "pause"

            m.top.findNode("contentLabel").text = "Pause"
            m.top.findNode("durationLabel").visible = "true"
            m.top.findNode("positionLabel").visible = "true"
            m.top.findNode("rectangleDuration").visible = "true"
            m.top.findNode("rectanglePosition").visible = "true"
            m.top.findNode("rectanglePosition").translation = [cint(m.video.position*1200.0/m.video.duration) + 40, 595]
            m.top.findNode("durationLabel").text = "Duration: " + m.video.duration.toStr() + " seconds"
            m.top.findNode("positionLabel").text = "Position: " + m.video.position.toStr() + " seconds"
            
        end if
        if m.video.state = "paused"
            m.video.control = "resume"
            m.top.findNode("contentLabel").text = "Playing"
            m.top.findNode("durationLabel").visible = "false"
            m.top.findNode("positionLabel").visible = "false"
            m.top.findNode("rectangleDuration").visible = "false"
            m.top.findNode("rectanglePosition").visible = "false"
        end if
        ?"after: " m.video.control
    end if
    return result
end function