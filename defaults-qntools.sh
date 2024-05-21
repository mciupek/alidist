package: defaults-qntools
version: v1
env:
  CFLAGS: -fPIC -O2
  CMAKE_BUILD_TYPE: RELWITHDEBINFO
  CXXFLAGS: -fPIC -O2 -std=c++20
  CXXSTD: '20'
  ENABLE_VMC: 'ON'
  GEANT4_BUILD_MULTITHREADED: 'OFF'
  MACOSX_DEPLOYMENT_TARGET: '10.15'
disable:
  - DPMJET
  - GEANT3
  - GEANT4
  - GEANT4_VMC
  - arrow
  - mesos
  - MySQL
overrides:
  RooUnfold:
    version: "%(tag_basename)s"
    tag: ZDCflow
    source: https://github.com/mciupek/RooUnfold
  AliRoot:
    version: '%(commit_hash)s_O2'
    requires:
      - ROOT
      - DPMJET
      - fastjet:(?!.*ppc64)
      - GEANT3
      - GEANT4_VMC
      - Vc
      - ZeroMQ
      - JAliEn-ROOT
  AliPhysics:
    version: "%(tag_basename)s"
    source: https://github.com/mciupek/AliPhysics
    tag: ZDCFlow
  GCC-Toolchain:
    version: v12.2.0-alice1
    tag: v12.2.0-alice1
  cgal:
    version: 4.12.2
  fastjet:
    tag: v3.4.1_1.052-alice2
---


# This file is included in any build recipe and it's only used to set
# environment variables. Which file to actually include can be defined by the
# "--defaults" option of alibuild.
