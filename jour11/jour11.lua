-- Calcule le mot suivant 
-- @param mot string : le mot à incrémenter
-- @return string : le mot incrémenté
-- exemple : abcz -> abda
local function suivant(mot)
    local len = mot:len()
    local ret = mot:sub(1, len - 1)
    if mot:sub(len, len) == 'z' then
        -- utilisé si abzz par ex. s’appelle récursivment pour trouver acaa
        ret = suivant(ret) .. 'a' 
    else
        ret = ret .. string.char(mot:sub(len, len):byte() + 1)
    end
    return ret
end

-- Détecte s’il existe une suite de 3 lettres consécutives
-- @param mot string : mot où il faut vérifier s’il y a une suite
-- @return bool : true s’il y a une suite, false sinon
-- exemple : uabcie -> true; abecud -> false
local function suite(mot)
    local ret = false
    local pred = nil
    local i = 1
    local c = nil
    -- lorsqu’on trouve la première lettre, on met ret à true et pred à c
    -- si on trouve la troisième lettre, on met pred à nil. 
    -- si ret est à true et pred à nil, on a trouvé une suite de 3 lettres
    while not (ret and pred == nil) and i <= #mot do
        c = mot:sub(i, i)
        -- première itération
        if pred == nil then
            pred = c
        elseif pred ~= nil then 
            if pred:byte() == (c:byte() - 1) then
                -- si le pred est bien prédecesseur de c, on vérifie ret
                -- pour modifier ensuite pred en conséquence (nil si fin)
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
    return (ret and pred == nil) and true or false
end

-- Cherche le nombre de double dans un mot
-- @param mot string : mot à vérifier
-- @return int : le nombre de double présent
-- exemple : aaabc -> 1; aacaauxxii -> 4
local function double(mot)
    local ret = 0
    local pred = nil
    for c in mot:gmatch(".") do
        -- pred ~= obligatoire car on ne peut pas comparer un char avec un nil
        if pred ~= nil and pred == c then
            ret = ret + 1
            pred = nil
        else
            pred = c
        end
    end
    return ret
end

-- incrémente le mot selon le mauvais caractère
-- @param mot string : le mot à modifier
-- @param char string : le caractère à trouver et incrémenter
-- @return string : le mot modifié ou non
-- exemple : avec char = i
-- abcidd -> abcjaa; abcde -> abcde
local function badChar(mot, char)
    local ret = mot
    local tmp = mot:find(char)

    if tmp ~= nil then
        if tmp == 1 then
            ret = string.char(ret:sub(tmp, tmp):byte() + 1) .. string.rep('a', #ret - tmp)
        elseif tmp == ret:len() then
            ret = ret:sub(1, tmp-1) .. string.char(ret:sub(tmp, tmp):byte() + 1)
        else
            ret = ret:sub(1, tmp - 1) .. string.char(ret:sub(tmp, tmp):byte() + 1) .. string.rep('a', #ret - tmp)
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
