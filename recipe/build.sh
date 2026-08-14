#!/usr/bin/env bash

set -ex

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
