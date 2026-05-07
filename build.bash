#!/usr/bin/env bash
set -euxo pipefail

if [[ "$(pwd)" != "$(cd "$(dirname "$0")" && pwd)" ]]; then
	echo 'Please cd to project diectory beforehand.' 1>&2
	exit 1
fi

build_dir=./build

test -d $build_dir && rm -r $build_dir || true

export CLICOLOR_FORCE=1

cmake_configure_args=(
	-B "$build_dir"

	-DCMAKE_MAKE_PROGRAM="$(which ninja)" -G Ninja
	#-DCMAKE_MAKE_PROGRAM="$(which make)" -G 'Unix Makefiles'

	-DCMAKE_TOOLCHAIN_FILE="$HOME/devel/vcpkg/scripts/buildsystems/vcpkg.cmake" # must after -DCMAKE_MAKE_PROGRAM

	# vcpkgではなくmacportsでインストールしたwxWidgetsを使う例
	#-DwxWidgets_CONFIG_EXECUTABLE=/opt/local/Library/Frameworks/wxWidgets.framework/Versions/wxWidgets/3.1/bin/wx-config

	#-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++

	-DCMAKE_COLOR_DIAGNOSTICS=ON

	#-DCMAKE_BUILD_TYPE=Debug
	-DCMAKE_BUILD_TYPE=Release
)
cmake "${cmake_configure_args[@]}"
cmake --build "$build_dir" -j
