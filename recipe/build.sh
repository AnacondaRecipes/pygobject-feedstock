#!/usr/bin/env bash

set -ex

# get meson to find pkg-config when cross compiling
export PKG_CONFIG=$BUILD_PREFIX/bin/pkg-config

echo "=== pkg-config resolution check ==="
echo "PKG_CONFIG explicitly set to: $PKG_CONFIG"
echo "pkg-config resolves to: $(which pkg-config)"
if [[ "$(which pkg-config)" == "$PKG_CONFIG" ]]; then
  echo "confirmed same"
else
  echo "error"
  exit 1
fi

meson_config_args=(
  --wrap-mode=nofallback
  --backend=ninja
  -Dtests=false
  -Dpycairo=enabled
  -Dpython="$PYTHON"
)

meson setup forgebuild ${MESON_ARGS} "${meson_config_args[@]}"
ninja -v -C forgebuild -j ${CPU_COUNT}
ninja -C forgebuild install -j ${CPU_COUNT}
