sub init()
    m.video = m.top.findNode("video")
    m.video.observeField("position", "onPositionChange")
    m.top.observeField("playerContent", "onPlayerContentChange")
    m.positionLabel = m.top.findNode("positionLabel")
    m.rectangleDuration = m.top.findNode("rectangleDuration")
    m.rectanglePosition = m.top.findNode("rectanglePosition")
    m.circlePosition = m.top.findNode("circlePosition")
    m.playIcon = m.top.findNode("playIcon")
    m.pauseIcon = m.top.findNode("pauseIcon")

    info = CreateObject("roDeviceInfo")
    displaySize = info.GetDisplaySize()
    m.width = displaySize.w
    m.height = displaySize.h
    m.rectangleDuration.setFields({
        width: m.width,
        height: 4,
        color: "#c2c2c2"
        translation: [0, m.height - 50]
    })
    m.rectanglePosition.setFields({
        height: 6,
        color: "#ff0000",
    })
    m.positionLabel.translation = [50, m.height - 30]
    m.positionLabel.font.size = 15
    m.rectanglePosition.translation = [0, m.rectangleDuration.translation[1] - cint(m.rectanglePosition.height / 2 - m.rectangleDuration.height / 2)]
    m.circlePosition.translation = [0, m.rectangleDuration.translation[1] - cint(m.circlePosition.height / 2 - m.rectangleDuration.height / 2)]
    m.playIcon.translation = [10, m.height - 40]
    m.pauseIcon.translation = [10, m.height - 40]
end sub

sub onPlayerContentChange(event)
    videoItem = event.getData()
    videocontent = createObject("RoSGNode", "ContentNode")
    videocontent.title = videoItem.title
    videocontent.streamformat = videoItem.videoType
    videocontent.url = videoItem.videoUrl
    m.video.content = videocontent
    m.video.control = "play"
end sub

sub onPositionChange()
    ' m.rectanglePosition.translation = [cint(m.video.position*m.rectangleDuration.width/m.video.duration), m.rectangleDuration.translation[1]-cint(m.rectanglePosition.height/2 - m.rectangleDuration.height/2)]
    m.rectanglePosition.width = cint(m.video.position * m.rectangleDuration.width / m.video.duration)
    m.circlePosition.translation = [m.rectanglePosition.width - cint(m.circlePosition.width / 2), m.circlePosition.translation[1]]

    m.positionLabel.text = timeToStr(m.video.position, m.video.duration)
end sub

function timeToStr(position as integer, duration as integer) as string
    positionDot = ":"
    if position mod 60 < 10 then positionDot = ":0"
    durationDot = ":"
    if duration mod 60 < 10 then durationDot = ":0"
    return (cint(position / 60)).toStr() + positionDot + (position mod 60).toStr() + "/" + (cint(duration / 60)).toStr() + durationDot + (duration mod 60).toStr()
end function

function OnkeyEvent(key as string, press as boolean) as boolean
    result = true
    ? "VideoPlayer key: " key " press: " press
    if press
        if key = "back"
            ? "back to zoomRowList"
            resumeVideo()
            m.top.getParent().findNode("zoomRowList").setFocus(true)
        end if
        if key = "OK"
            ?"before: " m.video.control
            if m.video.state = "playing" then pauseVideo()
            if m.video.state = "paused" then resumeVideo()
            ?"after: " m.video.control
        end if
    end if
    return result
end function

sub pauseVideo()
    m.playIcon.visible = false
    m.pauseIcon.visible = true
    m.video.control = "pause"
end sub

sub resumeVideo()
    m.playIcon.visible = true
    m.pauseIcon.visible = false
    m.video.control = "resume"
end sub
