# Package

version       = "0.1.0"
author        = "Regis Caillaud"
description   = "A new awesome nimble package"
license       = "MIT"
skipDirs      = @["foopackage", "foozpackage", "barpackage", "install"]
bin           = @["mainMonoRepo"]


# Dependencies

requires "nim >= 1.4.4"

import os
task setup, "Setup repo":
  #exec("git submodule update --init --recursive")
  echo("git submodule update --init --recursive")
  selfExec("r --hints:off install/initdep.nim")
  exec("nimble refresh")

task recPkgs, "Recursive Package develop":
  for kind, dir in walkDir("."):
    let dir = tailDir(dir)
    if kind != pcDir or dir == "install" or dir == "log" or dir == ".git":
      discard
    else:
      echo kind, ">> ", dir
      withDir dir:
        echo "nimble develop " & dir
        exec("nimble develop -y")

before install:
  setupTask()
  recPkgsTask()

before develop:
  setupTask()
  recPkgsTask()
