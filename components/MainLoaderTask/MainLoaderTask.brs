sub init()
	m.top.functionName = "getContent"
end sub


sub getContent()
	rsp = ReadAsciiFile("pkg:/mockdata/mockdata.json")
	rootChildren = []
	json = ParseJson(rsp)
	if json <> invalid
		for each category in json
			value = json.Lookup(category)
			row = {}
			row.title = category
			row.children = []
			row.title = category
			for each itemData in value
				item = {}
				item.title = itemData.title
				item.description = itemData.longDescription
				item.hdposterurl = itemData.thumbnail
				item.videoUrl = itemData.url
				item.videoType = itemData.videoType
				item.quality = itemData.quality
				row.children.Push(item)
			end for
			rootChildren.Push(row)
		end for
		m.top.content = CreateObject("roSGNode", "ContentNode")
		m.top.content.Update({
			children: rootChildren
		}, true)
	end if
end sub