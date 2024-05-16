package: QnTools
version: "%(commit_hash)s"
tag: master
source: https://github.com/HeavyIonAnalysis/QnTools
requires:
  - ROOT
build_requires:
  - CMake
  - "Xcode:(osx.*)"
prepend_path:
  ROOT_INCLUDE_PATH: "$QN_ROOT/include"
incremental_recipe: |
  cmake $SOURCEDIR -DCMAKE_INSTALL_PREFIX=$INSTALLROOT
  cmake --build . -- ${JOBS:+-j$JOBS} install
  mkdir -p $INSTALLROOT/etc/modulefiles && rsync -a --delete etc/modulefiles/ $INSTALLROOT/etc/modulefiles
---
#!/bin/sh
cmake $SOURCEDIR -DCMAKE_INSTALL_PREFIX=$INSTALLROOT
cmake --build . -- ${JOBS:+-j$JOBS} install

# Modulefile
mkdir -p etc/modulefiles
cat > etc/modulefiles/$PKGNAME <<EoF
#%Module1.0
proc ModulesHelp { } {
  global version
  puts stderr "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
}
set version $PKGVERSION-@@PKGREVISION@$PKGHASH@@
module-whatis "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
# Dependencies
module load BASE/1.0 ${ROOT_VERSION:+ROOT/$ROOT_VERSION-$ROOT_REVISION}
# Our environment
setenv QN_RELEASE \$version
setenv QN_ROOT \$::env(BASEDIR)/$PKGNAME/\$::env(QN_RELEASE)
prepend-path LD_LIBRARY_PATH \$::env(QN_ROOT)/lib
prepend-path ROOT_INCLUDE_PATH \$::env(QN_ROOT)/include
$([[ ${ARCHITECTURE:0:3} == osx ]] && echo "prepend-path DYLD_LIBRARY_PATH \$::env(Qn_DIR)/lib")
EoF
mkdir -p $INSTALLROOT/etc/modulefiles && rsync -a --delete etc/modulefiles/ $INSTALLROOT/etc/modulefiles
