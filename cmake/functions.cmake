cmake_minimum_required (VERSION 3.19.4)
include(CMakeParseArguments)












macro (ph_define_self res)
    cmake_parse_arguments(
        P
        "SINGLE;ANOTHER;name;dir" "ONE_VALUE;ALSO_ONE_VALUE" "MULTI_VALUES"
        ${ARGN}
    ) 
    # cmake_parse_arguments (KUK "${options}" "" "" ${ARGN})
    if (P_name)
    get_filename_component (${res} ${CMAKE_CURRENT_LIST_DIR} NAME)
    elseif (P_dir)
        get_filename_component (${res} ${CMAKE_CURRENT_LIST_DIR} ABSOLUTE DIRECTORY)
    else ()
        get_filename_component (${res} ${CMAKE_CURRENT_LIST_DIR} NAME)
    endif ()
    
    string(REPLACE " " "_" res ${res})
endmacro ()



function (ph_parent_dir current_dir ret)
    cmake_path (HAS_PARENT_PATH ${current_dir} has_parent)
    if (${has_parent})
        cmake_path (GET ${current_dir} PARENT_PATH ${ret})
    endif ()
endfunction ()


function(add_mytest targetName)
      add_executable(${targetName} ${ARGN})
      target_link_libraries(${targetName} PRIVATE foobar)
      add_test(NAME    ${targetName}
               COMMAND ${targetName}
      )
endfunction()





    





function(ph_define_list_len list res)
    list(LENGTH ${list} ${res})
endfunction()

# set(SEXY_STRING "I love CMake")
# string(REPLACE " " ";" SEXY_LIST ${SEXY_STRING})

# message(STATUS "string = ${SEXY_STRING}")
# # string = I love CMake

# message(STATUS "list = ${SEXY_LIST}")
# # list = I;love;CMake



# message ("number of arguments sent to function: ${ARGC}")
#   message ("all function arguments:               ${ARGV}")
#   message ("all arguments beyond defined:         ${ARGN}") 



macro(ph_get_property ret var)
get_property(${ret} GLOBAL PROPERTY ${var})
endmacro()

macro(ph_define_property res var)
    set_property (GLOBAL PROPERTY ${res} ${var})
endmacro()



macro (ph_header_list return_list)
    if (${ARGN} EQUALS 1)
        file (GLOB_RECURSE new_list ${ARGN}/*.hpp)
    elseif()
        file (GLOB_RECURSE new_list *.h)
    endif()
    file (GLOB_RECURSE new_list *.h)
    set (dir_list "")
    foreach (file_path ${new_list})
        get_filename_component (dir_path ${file_path} PATH)
        set (dir_list ${dir_list} ${dir_path})
    endforeach ()
    list (REMOVE_DUPLICATES dir_list)
    set (${return_list} ${dir_list})
endmacro ()





# reading files

# # Assuming the canonical version is listed in a single line
# # This would be in several parts if picking up from MAJOR, MINOR, etc.
# set(VERSION_REGEX "#define MY_VERSION[ \t]+\"(.+)\"")

# # Read in the line containing the version
# file(STRINGS "${CMAKE_CURRENT_SOURCE_DIR}/include/My/Version.hpp"
#     VERSION_STRING REGEX ${VERSION_REGEX})

# # Pick out just the version
# string(REGEX REPLACE ${VERSION_REGEX} "\\1" VERSION_STRING "${VERSION_STRING}")

# # Automatically getting PROJECT_VERSION_MAJOR, My_VERSION_MAJOR, etc.
# project(My LANGUAGES CXX VERSION ${VERSION_STRING})



function(COMPLEX) 
    cmake_parse_arguments(
        COMPLEX_PREFIX
        "SINGLE;ANOTHER" "ONE_VALUE;ALSO_ONE_VALUE" "MULTI_VALUES"
        ${ARGN}
    ) 
endfunction()



macro(ph_dont_build_here)
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
    file (TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
    if (EXISTS "${LOC_PATH}")
        message (FATAL_ERROR "You cannot build in a source directory.")
    endif ()
endmacro()





# MACRO(ph_subdir_list result curdir)
#   FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
#   SET(dirlist "")
#   FOREACH(child ${children})
#     IF(IS_DIRECTORY ${curdir}/${child})
#       LIST(APPEND dirlist ${child})
#     ENDIF()
#   ENDFOREACH()
#   SET(${result} ${dirlist})
# ENDMACRO()

MACRO(ph_subdir_list result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
      LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO()




# libraries
# >>>>>> accordingly
# >>>>>> FILE(READ ${LIB_SOURCE_DIR}/include/config.h CURRENT_CONFIG)
# >>>>>> STRING(REGEX MATCH "\#define USE_OPENGLES" GLES_IS_SET 
# >>>>>> ${CURRENT_CONFIG})
# >>>>>> STRING(REGEX MATCH "\#define USE_OPENGL" GL_IS_SET 
# >>>>>> ${CURRENT_CONFIG})
# >>>>>> IF("#define USE_OPENGLES" STREQUAL "${GLES_IS_SET}")
# >>>>>> MESSAGE("GLES config!")
# >>>>>> ELSE("#define USE_OPENGLES" STREQUAL "${GLES_IS_SET}")
# >>>>>> IF("#define USE_OPENGL" STREQUAL "${GL_IS_SET}")
# >>>>>>     MESSAGE("GL config!")
# >>>>>> ELSE("#define USE_OPENGL" STREQUAL "${GL_IS_SET}")
# >>>>>>     MESSAGE("Error! USE_GL or USE_GLES must be defined!")
# >>>>>> ENDIF("#define USE_OPENGL" STREQUAL "${GL_IS_SET}")
# >>>>>> ENDIF("#define USE_OPENGLES" STREQUAL "${GLES_IS_SET}")



macro (ph_parent dir)
    cmake_parse_arguments (p "name;dir" "" "" ${ARGN})
    if (p_name)
        set (r "NAME")
    else ()
        set (r "ABSOLUTE DIRECTORY")
    endif ()
    cmake_language (EVAL CODE "
    get_filename_component(${dir} ${CMAKE_CURRENT_LIST_DIR} ${r})
    ")
    
endmacro ()








