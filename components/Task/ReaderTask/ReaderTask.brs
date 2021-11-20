sub init()
	m.top.functionName = "loadContent"
end sub
			
sub loadContent()
	m.top.content = createObject("roSGNode", "ContentNode")
	numRows = 9
	if m.top.content <> invalid
		next169Index = 0
		num169ContentItems = 16
		for i = 0 To numRows - 1
			row = CreateObject("rosgnode", "ContentNode")
			row.title = "MOVIE ROW " + i.toStr()
			numItems = 10
			for j = 0 To numItems - 1
				item = row.CreateChild("ContentNode")
				item.title = "Item " + j.ToStr()
				item.hdposterurl = "pkg:/DemoData/16x9/" + next169index.toStr() + ".jpeg"
				next169index = (next169index + 1) mod num169ContentItems
			end for
		m.top.content.appendChild(row)
		end for
	end if
end sub