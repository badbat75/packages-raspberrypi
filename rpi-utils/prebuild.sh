# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-utils: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

### The top level CMakeLists of the sources adds every subdirectory of the repository and there is no
### option to select them, so it is replaced by one that adds the tools of RPI_UTILS_TOOLS only: a
### tool that appears upstream then does not enter the image by itself either. Its
### cmake_minimum_required is 3.1, which cmake 4 refuses; every subdirectory asks 3.10, and so does this
{
	echo "cmake_minimum_required(VERSION 3.10...3.27)"
	echo "project(utils)"
	for RPI_UTILS_SUBDIR in ${RPI_UTILS_TOOLS}
	do
		echo "add_subdirectory(${RPI_UTILS_SUBDIR})"
	done
} > CMakeLists.txt
cat CMakeLists.txt
