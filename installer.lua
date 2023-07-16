local function get( sUrl )
    write( "Attempting to fetch " .. sUrl .. "... " )
    local ok, err = http.checkURL( sUrl )
    if not ok then
        print( "Failed." )
        if err then
            print("Error Code: " .. err )
        end
        return nil
    end
    local response = http.get( sUrl , nil , true )
    if not response then
        print( "Failed. No response from Host" )
        return nil
    end
    print( "Success." )
    local sResponse = response.readAll()
    response.close()
    return sResponse
end




term.clear()
term.setCursorPos(1,1)
print("### Welcome to Alitra OS Installer ###")
if not http then
  print("Disk-Based Installation is not supported")
  return
end
exit = 0
repeat
  term.clear()
  term.setCursorPos(1,1)
  print("### Welcome to Alitra OS Installer ###")
  print("Installer Options: 1.Install In PC 2.Create Portable Installer 3.REMOVE 4.EXIT")
  output = read()
  if output == "1" then
    print("Do you want to format the computer (Y/N)?")
    if read()=="Y" then
      --format the entire computer
      print("Feature WIP")
    end
    data = get("https://raw.githubusercontent.com/cj05/AlitraOS/main/metadata.json")
    print(data)
  end
  if output == "2" then
    print("Feature WIP")
  end
  if output == "3" then
    print("Feature WIP")
  end
  if output == "4" then
    exit = 1
  end
until(exit == 1)
