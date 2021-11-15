sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' scene = screen.CreateScene("MainScene")
    scene = screen.CreateScene("Demo")
    screen.show()
    demo()
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

sub printArr(arr)
    for i = 0 to arr.count() - 1
        ? "item " i " : " arr[i] 
    end for
end sub

function program1(s as string)
    ? "sequence: " s 
    stack = s.split("")
    while stack.count() > 0
        ? stack.pop()
    end while
end function


function program2(s as string) as boolean
    ? "sequence: " s 
    balancedMap = {
        ")" : "(", 
        "]" : "[",
        "}" : "{"
    }
    
    arr = s.split("")
    stack = []
    
    for i = 0 to arr.count() - 1
        if arr[i] = "(" or arr[i] = "[" or arr[i] = "{"
            stack.push(arr[i])
        end if 
        if arr[i] = ")" or arr[i] = "]" or arr[i] = "}"
            if stack.count() = 0
                return false
            end if
            if stack.peek() = balancedMap[arr[i]]
                stack.pop()
            end if
        end if 
    end for
    return stack.count() = 0
end function

function program3(n as integer)
    if n > 1
        program3(n/2)
    end if

    print(n mod 2)
end function

function program4(n = 50)
    res = ""
    for i = 0 to n
        res += chr(rnd(122-97) + 97) '97 -> 121 is a random ascii character from a->z
        ' A->Z: 65->90
    end for
    ? res
end function

function program5(s as string)
    res = ""
    arr = s.split(" ")
    arr.sort()
    for each item in arr
        res = res + item + " "
    end for
    res = left(res, len(res) - 1)
    return res
end function

sub demo()
    ' program1("asfsdfasdfasdfawqttsg")
    ' ? program2("(asfsdfasdfasdfawqttsg")
    ' ? program2("(as)fsdfasdfasdfawqttsg")
    ' ? program2("(as[])fsdfasdfasdfawqttsg")
    ' program3(8)
    ' program4()
    ' ? program5("go to school")
    ' ? program5("a c b")
end sub
