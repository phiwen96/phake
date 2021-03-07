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

macro(ph_git)
find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

# if(NOT EXISTS "${PROJECT_SOURCE_DIR}/extern/repo/CMakeLists.txt")
#     message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
# endif()
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








macro (ph_parse)
    set(p       p)
    set(N0     )
    set(N1 )
    set(N  n0 n1 n ARGS)


    cmake_parse_arguments( ${p}
                            "${N0}"
                            "${N1}"
                            "${N}"
                            ${ARGN}
    )

    
        


        

    
        foreach (arg IN LISTS N)
        if ("${arg}" STREQUAL n0)
            # list (APPEND n0 ${${p}_${arg}})
            set (n0 ${${p}_${arg}})

        elseif ("${arg}" STREQUAL n1)
            # list (APPEND n1 ${${p}_${arg}})
            # message (". ${${p}_${arg}} .")
        
            set (n1 ${${p}_${arg}})

        elseif ("${arg}" STREQUAL n)
            set (n ${${p}_${arg}})
            # list (APPEND n ${${p}_${arg}})

        elseif ("${arg}" STREQUAL f0)
            # set (APPEND F0 ${${p}_${arg}})

        elseif ("${arg}" STREQUAL f1)
            # set (APPEND F1 ${${p}_${arg}})

        elseif ("${arg}" STREQUAL fn)
            # set (APPEND FN ${${p}_${arg}})

        elseif ("${arg}" STREQUAL ARGS)
            
            # message (${${p}_${arg}})
            set (argsa ${${p}_${arg}})
            # message (${argsa})
        
            foreach (a ${argsa})
                # message (${a})
                list (APPEND res ${a})
                # set (res ${res} ${a})
                # list (APPEND argsab ${a})
                # set (argsac ${argsac} "${a}")
                
                # set (b ${a})
                # cont ("${a}")
                # cont ()
            endforeach ()
            # message (${argsab})
            # message (${argsac})
            # list (APPEND argsad ${${p}_${arg}})
            # message ("${argsad}")
            # cont (${argsad})
            # message (${argsab})
            
            # cont (${${p}_${arg}})

        endif ()


        # message ("${argsa}")

        

    endforeach ()
    message (${res})
    set (ARGN ${res})

    function (cont)
       

            set(pp      ARG)
            set(NN0     ${n0})
            set(NN1 ${n1})
            set(NN ${n})


            cmake_parse_arguments( ${pp}
                                    "${n0}"
                                    "${n1}"
                                    "${n}"
                                    ${res}
            )

            message (${ARGN})


            foreach (arg IN LISTS NN0)
                # message (${arg})
                if(${${pp}_${arg}})
                    message("  ${arg} enabled")
                    # N0 (${arg})
                else()
                    message("  ${arg} disabled")
                endif()
            endforeach ()


            foreach (arg IN LISTS NN1)
                message("  ${arg} = ${${pp}_${arg}}")
            endforeach ()

            foreach (arg IN LISTS NN)
                message("  ${arg} = ${${pp}_${arg}}")
            endforeach ()

   
    endfunction ()

    cont (${res})

  
    

   

    # message (${n0})
    # function (b)
    #     foreach (a ${n0})
    #         # message(b)
    #         # message (${a})
    #         if (${p_${a}})
    #             message("${a} = ${p_${a}}")
    #         endif ()
    #         # list (APPEND n_0 "
    #         #     if (p_${a})
    #         #         message (\"yes ${a}\")
    #         #     endif ()
    #         # ")
    #     endforeach ()
    
    # endfunction()
    
    # cmake_language (EVAL CODE "
        # set(p       p)
        # set(N0     ${n0})
        # set(N1 ${n1})
        # set(N ${n})


        # cmake_parse_arguments( ${p}
        #                         "${n0}"
        #                         "${n1}"
        #                         "${n}"
        #                         ${ARGN}
        # )
        # foreach (a ${ARGN})
        #     if (${p_${a}})
        #         message (p_${a})
        #     endif ()
        # endforeach () 
        # message (${ARGN})
        # b ()
        # foreach (a ${n_0})
        #     message (\"${a}\")
        #     cmake_language (EVAL CODE \" ${a}\")
        # endforeach ()

        # if (p_KUK0)
            # message (KUK)
        # endif ()

        # message (\"${n0}\")
        # string (REPLACE \";\" \" \" n0 \"${n0}\")
        # message(${n0})

        # foreach (arg ${n0})
        #     # message (\"${n0}\")
        #     # message (\"${np}\")
        #     if (${arg})
        #         # message (asda)
        #         # message (p_${arg})
        #     endif ()
        # endforeach ()

        # if (p_KUK)
        #     # message (asdasd)
        # endif ()
    

        
        # foreach (arg IN LISTS N0)
        #     # set (a ${arg})
       
        #     if (${${p}_${arg}})
        #         # message (""cool)
        #         # F0
        #         cmake_language(CALL ${F0} ${arg})
        #     else ()
        #         # message (""error)
        #     endif ()
        # endforeach ()

        # foreach(arg IN LISTS N1)
        #     if ("${arg}" STREQUAL TARGET)
        #         set (target ${${p}_${arg}})
        #     endif ()
        
        # endforeach()

        # foreach (arg IN LISTS N)
        #     if ("${arg}" STREQUAL n0)
        # endforeach ()
        
        
    #     "
    # )


    
    
endmacro ()