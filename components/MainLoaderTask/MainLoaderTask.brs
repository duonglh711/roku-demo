sub init()
	m.top.functionName = "getContent"
end sub


sub getContent()
	xfer = CreateObject("roURLTransfer")
	xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
	xfer.SetURL("https://lhduong1999-roku-demo.s3.ap-southeast-1.amazonaws.com/mockdata.json")
	rsp = xfer.GetToString()

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