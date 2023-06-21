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
    shell.run("wget")
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
