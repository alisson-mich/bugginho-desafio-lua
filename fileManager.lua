require "libs/json"

function createGuests()
  if io.open("guests.json") == nil then
    local guests = io.open("guests.json", "w")
    guests.write("[]")
    guests.close()
  end
end

function createRemoved()
  if io.open("removed.json") == nil then
    local guests = io.open("removed.json", "w")
    guests.write("[]")
    guests.close()
  end
end

function convertJSONtoString(fileName)
  JSONFile = io.open(fileName, "r")
  txt = JSONFile:read("*a")
  JSONFile:close()
  return txt
end

function convertTabletoJSON(table, filename)
  -- table becomes json
  local json = JSON:encode(table)
  local file = io.open(filename, "w")
  file:write(json)
  file:close()
end
