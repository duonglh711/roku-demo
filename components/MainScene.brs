sub init()
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.video = m.videoPlayer.findNode("video")
    m.zoomRowList = m.top.findNode("zoomRowList")
    m.background = m.top.findNode("background")
    m.titleLabel = m.top.findNode("titleLabel")
    m.descriptionLabel = m.top.findNode("descriptionLabel")
    m.videoThumbnail = m.top.findNode("videoThumbnail")
    m.titleLabel.font.size=20
    m.descriptionLabel.font.size=15
    
    info = CreateObject("roDeviceInfo")
    displaySize = info.GetDisplaySize()
    m.width = displaySize.w
    m.height = displaySize.h

    m.titleLabel.width = cint(m.width - 180 - m.width*.3)
    m.descriptionLabel.width = cint(m.width - 180 - m.width*.3)

    m.zoomRowList.setFields({
        translation: [30, cint(m.height*.3)],  'because scale video to 0.3
        itemComponentName: "RowListItem",
    })

    m.zoomRowList.observeField("rowItemFocused", "onItemFocused")
    m.zoomRowList.observeField("rowSelected", "onRowSelected")

    m.mainLoaderTask = createObject("roSGNode", "MainLoaderTask")
    m.mainLoaderTask.observeField("content", "getListItem")
    m.mainLoaderTask.control = "RUN"

    m.zoomRowList.visible = false
    m.zoomRowList.setFocus(true)
    m.previewVideo = true

    m.fullScreenVideoAnimation = m.top.findNode("fullScreenVideoAnimation")
    m.minimizeVideoAnimation = m.top.findNode("minimizeVideoAnimation")
    m.top.findNode("translationVideoFullScreen").keyValue=[ [cint(m.width - m.width*.3), 0], [0, 0]]
    m.top.findNode("translationVideoMinimize").keyValue=[ [0, 0], [cint(m.width - m.width*.3), 0]]
    m.minimizeVideoAnimation.control = "start"
    m.background.width = m.width
    m.background.height = m.height
end sub

sub getListItem()
    if m.mainLoaderTask.content=invalid
        ? "invalid readerTask.content"
    else
        m.zoomRowList.content = m.mainLoaderTask.content
        m.zoomRowList.visible = true
    end if
end sub

sub onRowSelected()
    ? "onRowSelected is: " m.zoomRowList.rowSelected 
    m.previewVideo = false
    m.fullScreenVideoAnimation.control = "start"
    m.videoPlayer.setFocus(true)
end sub

sub onItemFocused(event)
    index = event.getData()
    ? "rowItemFocused is: " + index[0].toStr() + " " + index[1].toStr()    
    if m.previewVideo = false
        m.minimizeVideoAnimation.control = "start"
        m.previewVideo = true
    end if
    if m.lastItemFocused = invalid or m.lastItemFocused[0] <> index[0] or m.lastItemFocused[1] <> index[1]
        itemFocused = m.zoomRowList.content.getChild(index[0]).getChild(index[1])
        m.background.uri = itemFocused.hdposterurl
        m.titleLabel.text = itemFocused.title
        m.descriptionLabel.text = itemFocused.description
        m.videoThumbnail.uri = itemFocused.hdposterurl
        m.videoPlayer.playerContent = itemFocused
        m.lastItemFocused = index
    end if
end sub