#!/usr/bin/env bash
set -e

if [ "$(uname)" == "Darwin" ]; then
  # other
  libext=".dylib"
  export LDFLAGS="-rpath ${PREFIX}/lib ${LDFLAGS}"
  export LINKFLAGS="${LDFLAGS}"
  skiprpath="-DCMAKE_SKIP_RPATH=TRUE"
else
  libext=".so"
  skiprpath=""
fi

# Install Cyclus
#export VERBOSE=1
pwd
ls -al
${PYTHON} install.py --prefix="${PREFIX}" \
  --build_type="Release" \
  --dont-allow-milps \
  --deps-root="${PREFIX}" \
  --core-version="${PKG_VERSION}" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}" \
  -DBLAS_LIBRARIES="-L${PREFIX}/lib -lopenblas" \
  -DLAPACK_LIBRARIES="-L${PREFIX}/lib -lopenblas" \
  ${skiprpath} \
  --clean -j "${CPU_COUNT}"
