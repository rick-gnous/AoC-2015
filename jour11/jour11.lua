local function suivant(mot)
    local len = mot:len()
    local ret = mot:sub(1, len - 1)
    if mot:sub(len, len) == 'z' then
        ret = suivant(ret) .. 'a'
    else
        ret = ret .. string.char(string.byte(mot:sub(len, len)) + 1)
    end
    return ret
end

local function suite(mot)
    local ret = false
    local pred = nil
    local i = 1
    local c = nil
    while not (ret and pred == nil) and i <= mot:len() do
        c = mot:sub(i, i)
        if pred == nil then
            pred = c
        elseif pred ~= nil then 
            if string.byte(pred) == (string.byte(c) - 1) then
                if ret then
                    pred = nil 
                else
                    pred = c 
                    ret = true
                end
            else
                ret = false
                pred = c
            end
        end
        i = i + 1
    end
    if ret and pred == nil then
        return true
    else
        return false
    end
end

local function double(mot)
    local ret = 0
    local pred = nil
    for c in mot:gmatch(".") do
        if pred ~= nil and pred == c then
            ret = ret + 1
            pred = nil
        else
            pred = c
        end
    end
    return ret
end

local function badChar(mot, char)
    local ret = mot
    local tmp = mot:find(char)

    if tmp ~= nil then
        if tmp == 1 then
            ret = string.char(string.byte(ret:sub(tmp, tmp)) + 1) .. string.rep('a', ret:len() - tmp)
        elseif tmp == ret:len() then
            ret = ret:sub(1, tmp-1) .. string.char(string.byte(ret:sub(tmp, tmp)) + 1)
        else
            ret = ret:sub(1, tmp - 1) .. string.char(string.byte(ret:sub(tmp, tmp)) + 1) .. string.rep('a', ret:len() - tmp)
        end
    end
    return ret
end

myInput = "cqjxjnds"
fin = false

while not fin do
    myInput = badChar(myInput, 'i')
    myInput = badChar(myInput, 'l')
    myInput = badChar(myInput, 'o')
    if suite(myInput) and double(myInput) >= 2 then
        print(myInput)
        fin = true
    else
        myInput = suivant(myInput)
    end
end


-- une suite de 3 caractères au moins (abc par ex)
-- ne doit pas contenir i l o
-- doit avoir 2 doubles (aa et cc par ex)
