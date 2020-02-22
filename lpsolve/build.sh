platform="unknown"
unamestr=$(uname)
if [[ "$unamestr" == "Linux" ]]; then
  platform="linux"
  platarch="ux${ARCH}"
  libname="liblpsolve55.so"
  ccc="ccc"
elif [[ "$unamestr" == "Darwin" ]]; then
  platform="macos"
  platarch="osx64"
  libname="liblpsolve55.dylib"
  ccc="ccc.osx"
fi

mkdir -p ${PREFIX}/bin
mkdir -p ${PREFIX}/lib
mkdir -p ${PREFIX}/include/lpsolve

# build library
cd lp_solve_5.5/lpsolve55
sh -x ${ccc}
cd bin/${platarch}

if [[ "$platform" == "macos" ]]; then
  install_name_tool -id ${PREFIX}/lib/liblpsolve55.dylib liblpsolve55.dylib
fi

cp ${libname} ${PREFIX}/lib/
cd ../../../

# build executable
cd lp_solve
sh ${ccc}
cp bin/${platarch}/lp_solve ${PREFIX}/bin/
cd ..

# install headers
cp *.h ${PREFIX}/include/
cp *.h ${PREFIX}/include/lpsolve/
