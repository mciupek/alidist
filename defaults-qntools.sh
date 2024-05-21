package: defaults-qntools
version: v1
env:
  CXXFLAGS: "-fPIC -g -O2 -std=c++20"
  CFLAGS: "-fPIC -g -O2"
  CMAKE_BUILD_TYPE: "RELWITHDEBINFO"
disable:
  - DPMJET
  - GEANT3
  - GEANT4
  - GEANT4_VMC
  - arrow
overrides:
  RooUnfold:
    version: "%(tag_basename)s"
    tag: ZDCflow
    source: https://github.com/mciupek/RooUnfold
  AliRoot:
    version: "%(tag_basename)s"
    tag: master
    source: https://github.com/alisw/AliRoot
  AliPhysics:
    version: "%(tag_basename)s"
    source: https://github.com/mciupek/AliPhysics
    tag: ZDCFlow
---
