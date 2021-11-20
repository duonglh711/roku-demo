sub init()
	m.top.functionName = "loadVideo"
end sub
			
sub loadVideo()
    sleep(500) 'delay 500ms to fake
	videocontent = createObject("RoSGNode", "ContentNode")
    videocontent.title = "Example Video"
    videocontent.streamformat = "mp4"
    videocontent.url = "pkg:/demodata/video/demo1.mp4"
    m.top.content = videocontent
end sub