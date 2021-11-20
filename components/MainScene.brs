sub init()
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.video = m.videoPlayer.findNode("exampleVideo")
    m.zoomRowList = m.top.findNode("zoomRowList")

    info = CreateObject("roDeviceInfo")
    displaySize = info.GetDisplaySize()
    m.width = displaySize.w
    m.height = displaySize.h

    m.zoomRowList.setFields({
        translation: [30, cint(m.height*.3)],  'because scale video to 0.3
        itemComponentName: "RowListItem",
    })

    m.zoomRowList.observeField("rowItemFocused", "onItemFocused")
    m.zoomRowList.observeField("rowSelected", "onRowSelected")

    m.readerTask = createObject("roSGNode", "ReaderTask")
    m.readerTask.observeField("content", "getListItem")
    m.readerTask.control = "RUN"

    m.zoomRowList.visible = false
    m.zoomRowList.setFocus(true)
    m.previewVideo = true

    m.fullScreenVideoAnimation = m.top.findNode("fullScreenVideoAnimation")
    m.minimizeVideoAnimation = m.top.findNode("minimizeVideoAnimation")
    m.top.findNode("translationVideoFullScreen").keyValue=[ [cint(m.width - m.width*.3), 0], [0, 0]]
    m.top.findNode("translationVideoMinimize").keyValue=[ [0, 0], [cint(m.width - m.width*.3), 0]]
    m.minimizeVideoAnimation.control = "start"
end sub

sub getListItem()
    if m.readerTask.content=invalid
        print "invalid readerTask.content"
    else
        m.zoomRowList.content = m.readerTask.content
        m.zoomRowList.visible = true
    end if
end sub

sub onRowSelected()
    ? "onRowSelected is: " m.zoomRowList.rowSelected 
    m.previewVideo = false
    m.fullScreenVideoAnimation.control = "start"
    m.videoPlayer.setFocus(true)
end sub

sub onItemFocused()
    ? "rowItemFocused is: " + m.zoomRowList.rowItemFocused[0].toStr() + " " + m.zoomRowList.rowItemFocused[1].toStr()    
    if m.previewVideo = false
        m.minimizeVideoAnimation.control = "start"
        m.previewVideo = true
    end if
end sub