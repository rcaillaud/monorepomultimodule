import os
import parsecfg

let home = getHomeDir()
when defined(windows):
  let nimbleConfigDir = (home & "AppData/Roaming/nimble/")
else:
  let nimbleConfigDir = (home & ".config/nimble")

let nimbleConfig = normalizedPath(nimbleConfigDir / "nimble.ini")
echo nimbleConfig
let pwd = getCurrentDir()
let packageName = "LocalTest"
let packagesFile = normalizedPath(pwd / "install" / "localpackages.json")
echo packagesFile

discard existsOrCreateDir(nimbleConfigDir)
var dict = newConfig()
dict.setSectionKey("", "; This is a generated file. Do not modify", "")
dict.setSectionKey("PackageList", "name", packageName)
dict.setSectionKey("PackageList", "path", packagesFile)
dict.writeConfig(nimbleConfig)
#echo nimbleConfig
