#!/usr/bin/env bash

if [[ "$(pwd)" != "$(cd "$(dirname "$0")" && pwd)" ]]; then
	echo 'Please cd to project diectory beforehand.' 1>&2
	exit 1
fi

build_dir=./build

usage() {
	echo "Usage: $0 [-c]"
	echo "  -c    Remove $build_dir directory first"
	echo "  -h    Show this help message"
}

clean_build_dir=
while getopts "ch" opt; do
	case ${opt} in
		c) clean_build_dir=true ;;
		h) usage; exit 0 ;;
		*) usage; exit 1 ;;
	esac
done
shift $((OPTIND - 1))
[[ $# -gt 0 ]] && { usage; exit 1; }

set -euxo pipefail

if [ "$clean_build_dir" = true ]; then
	test -d $build_dir && rm -r $build_dir || true
fi

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

	-DCMAKE_POLICY_VERSION_MINIMUM=3.5
)
cmake "${cmake_configure_args[@]}"
cmake --build "$build_dir" -j
