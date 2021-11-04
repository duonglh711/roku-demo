sub Init()
end sub

sub OnContentSet() ' invoked when item metadata retrieved
    content = m.top.itemContent
    ' set poster uri if content is valid
    if content <> invalid 
        m.top.FindNode("poster").uri = content.hdPosterUrl
    end if

    focusPercent = .9 + .1*m.top.focusPercent 
    m.top.scale = [focusPercent, focusPercent]
    abc = "bdf"
    ? "value: " abc

end sub

sub OnFocusChange() ' invoked when item metadata retrieved
    focusPercent = .9 + .1*m.top.focusPercent
    m.top.scale = [focusPercent, focusPercent]
end sub
