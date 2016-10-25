require "fileManager"

JSON = (loadfile "libs/json.lua")()

createGuests()
createRemoved()

-- create string from json
guestsJSON = convertJSONtoString("guests.json")
removedJSON = convertJSONtoString("removed.json")

-- create table from the string above
guests = JSON:decode(guestsJSON)
removed = JSON:decode(removedJSON)


function RegisterGuest()
  print("Enter the guest's name:")
  local name = io.read()
  print("Enter the CPF number:")
  local cpf = io.read()

  --creates a table and put it to guests table
  local guest = { ["name"] = name, ["cpf"] = cpf }
  guests[#guests + 1] = guest

  --write data in json file
  local jsonGuests = JSON:encode(guests)
  local file = io.open("guests.json", "w")
  file:write(jsonGuests)
  file:close()

  print("\nPress any key to continue")
  io.read()
end

function RemoveGuest()
  print("Choose the way to remove: \n1 - Name, 2 - CPF")
  local choise = io.read()

  -- remove by name
  if choise == '1' then
    print("Enter the guest's name to be removed: ")
    local name = io.read()
    for x,y in pairs(guests) do
      if(y["name"] == name) then
        removed[#removed+1] = guests[x]
        guests[x] = nil
        break
      end
    end
  -- remove by cpf
  elseif choise == '2' then
    print("Enter the guest's cpf to be removed: ")
    local cpf = io.read()
    for x,y in pairs(guests) do
      if(y["cpf"] == cpf) then
        removed[#removed+1] = guests[x]
        guests[x] = nil
        break
      end
    end
  -- wtf was your choise
  else
    print("\nThere's no '"..choise.."' option!")
  end

  convertTabletoJSON(guests, "guests.json")
  convertTabletoJSON(removed, "removed.json")

  print("\nPress any key to continue")
  io.read()
end

-- pronto
function FindByCPF()
  print("Enter the CPF to be find:")
  local cpf = io.read()

  for x,y in pairs(guests) do
    if(y["cpf"] == cpf) then
      print("\nFound!\n")
      print("Name: "..y["name"])
      break
    end
  end

  print("\nPress any key to continue")
  io.read()
end

-- pronto
function ShowAllGuests()
  print("List of all guests:\n\n")

  if(guests ~= nil) then
    for x, y in pairs(guests) do
        print("Name: " .. y["name"] .. "\nCPF: " .. y["cpf"])
    end
  else
    print("The list is empty\n\n")
  end

  print("\nPress any key to continue")
  io.read()
end

-- pronto
function ShowAllRemovedGuests()
  print("List of all removed guests:\n")

  if(removed ~= nil) then
    for x,y in pairs(removed) do
      print("Name: " .. y["name"] .. "\nCPF: " .. y["cpf"])
    end
  else
    print("The list is empty\n\n")
  end

  print("\nPress any key to continue")
  io.read()
end

repeat
  os.execute("clear")
  print("1 - Register a guest")
  print("2 - Remove a guest")
  print("3 - Find a guest by CPF")
  print("4 - Show all guests")
  print("5 - Show all removed guests")
  print("0 - Exit")

  print("\nChoose one:")
  escolha = io.read()

  os.execute("clear")

  if     escolha == '1' then RegisterGuest()
  elseif escolha == '2' then RemoveGuest()
  elseif escolha == '3' then FindByCPF()
  elseif escolha == '4' then ShowAllGuests()
  elseif escolha == '5' then ShowAllRemovedGuests()
  end

until escolha == '0'
