sub Init()
    m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri= "pkg:/images/background.jpg"
    m.loadingIndicator = m.top.FindNode("loadingIndicator") ' store loadingIndicator node to m
    InitScreenStack()
    ShowGridScreen()
    RunContentTask()
end sub
