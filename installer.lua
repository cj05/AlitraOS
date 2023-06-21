print("### Welcome to Alitra OS Installer ###")
if not http then
  print("Disk-Based Installation is not supported")
  return
end
exit = 0
repeat
  print("Installer Options: 1.INSTALL 2.REMOVE 3.EXIT")
  output = read()
  if(output == "3")then
    exit = 1
  end
until(exit == 1)
