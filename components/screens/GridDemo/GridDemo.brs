sub Init()
    info = CreateObject("roDeviceInfo")
    displaySize = info.GetDisplaySize()
    width = displaySize.w
    height = displaySize.h
    m.widthItem = width / m.top.numColumns
    m.heightItem = height / m.top.numRows
    onContentChange()
end sub


function decToHex (dec as integer) as string
	hexTab = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	hex = ""
	while dec > 0
		hex = hexTab [dec mod 16] + hex
		dec = dec / 16
	end while
	if hex = "" return "0" else return hex
end function


sub onContentChange()
    rows = CreateObject("roSGNode", "ContentNode")
    for i = 0 to m.top.numRows - 1
        for j = 0 to m.top.numColumns - 1
            item = CreateObject("roSGNode", "Rectangle")
            item.width = m.widthItem - 10
            item.height = m.heightItem - 10
            item.color = "#"+decToHex(rnd(16777215))
            item.translation = [i*m.widthItem, j*m.heightItem]
            m.top.appendChild(item)
        end for
    end for
end sub 
