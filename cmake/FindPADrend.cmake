# Try to find PADrend. Once done, this will define:
#
#   PADREND_FOUND - variable which returns the result of the search
#   PADREND_INCLUDE_DIRS - list of include directories
#   PADREND_LIBRARIES - options for the linker

#=============================================================================
#
# This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/.
# Author: Sascha Brandt (sascha@brandt.graphics)
#
#=============================================================================


# Find PADrend include dir
find_path(PADREND_INCLUDE_DIR
	MinSG/MinSG.h
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../include
	${CMAKE_CURRENT_SOURCE_DIR}/../modules
	${CMAKE_CURRENT_SOURCE_DIR}/../../modules
	/upb/groups/fg-madh/public/share/padrend/include
)

set(PADREND_DEFAULT_LIBRARY_PATHS 
	${CMAKE_CURRENT_SOURCE_DIR}/../bin
	${CMAKE_CURRENT_SOURCE_DIR}/../lib
	${CMAKE_CURRENT_SOURCE_DIR}/../build
	${CMAKE_CURRENT_SOURCE_DIR}/../../build
	/upb/groups/fg-madh/public/share/padrend/linux/lib
)

# Find Geometry
find_library(PADREND_GEOMETRY_LIBRARY
	libGeometry.so Geometry
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/Geometry
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/Geometry
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find Rendering
find_library(PADREND_RENDERING_LIBRARY
	libRendering.so Rendering
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/Rendering
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/Rendering
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find Util
find_library(PADREND_UTIL_LIBRARY
	libUtil.so Util
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/Util
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/Util
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find MinSG
find_library(PADREND_MINSG_LIBRARY
	libMinSG.so MinSG
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/MinSG
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/MinSG
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find E_Geometry
find_library(PADREND_E_GEOMETRY_LIBRARY
	libE_Geometry.so E_Geometry
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/E_Geometry
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/E_Geometry
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find E_Rendering
find_library(PADREND_E_RENDERING_LIBRARY
	libE_Rendering.so E_Rendering
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/E_Rendering
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/E_Rendering
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find E_Util
find_library(PADREND_E_UTIL_LIBRARY
	libE_Util.so E_Util
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/E_Util
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/E_Util
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

# Find E_MinSG
find_library(PADREND_E_MINSG_LIBRARY
	libE_MinSG.so E_MinSG
	PATHS
	${CMAKE_CURRENT_SOURCE_DIR}/../build/modules/E_MinSG
	${CMAKE_CURRENT_SOURCE_DIR}/../../build/modules/E_MinSG
	${PADREND_DEFAULT_LIBRARY_PATHS}
)

set(PADREND_INCLUDE_DIRS ${PADREND_INCLUDE_DIR})
set(PADREND_LIBRARIES 
	${PADREND_GEOMETRY_LIBRARY}
	${PADREND_RENDERING_LIBRARY}
	${PADREND_UTIL_LIBRARY}
	${PADREND_MINSG_LIBRARY}
	${PADREND_E_GEOMETRY_LIBRARY}
	${PADREND_E_RENDERING_LIBRARY}
	${PADREND_E_UTIL_LIBRARY}
	${PADREND_E_MINSG_LIBRARY}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PADrend DEFAULT_MSG
	PADREND_INCLUDE_DIR
	PADREND_GEOMETRY_LIBRARY
	PADREND_RENDERING_LIBRARY
	PADREND_UTIL_LIBRARY
	PADREND_MINSG_LIBRARY
	PADREND_E_GEOMETRY_LIBRARY
	PADREND_E_RENDERING_LIBRARY
	PADREND_E_UTIL_LIBRARY
	PADREND_E_MINSG_LIBRARY
)

mark_as_advanced(
	PADREND_INCLUDE_DIR
	PADREND_GEOMETRY_LIBRARY
	PADREND_RENDERING_LIBRARY
	PADREND_UTIL_LIBRARY
	PADREND_MINSG_LIBRARY
	PADREND_E_GEOMETRY_LIBRARY
	PADREND_E_RENDERING_LIBRARY
	PADREND_E_UTIL_LIBRARY
)
