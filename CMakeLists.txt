cmake_minimum_required (VERSION 3.19.6)

# find_package (Git QUIET)

# if (GIT_FOUND)
#     execute_process (
#         # COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
#         COMMAND ${GIT_EXECUTABLE} checkout main
#         # COMMAND ${GIT_EXECUTABLE} config pull.rebase true
#         COMMAND ${GIT_EXECUTABLE} config pull.ff only 
#         COMMAND ${GIT_EXECUTABLE} pull
#         COMMAND ${GIT_EXECUTABLE} checkout 
#         COMMAND ${GIT_EXECUTABLE} merge master
#                     # COMMAND ${GIT_EXECUTABLE} submodule foreach git pull main
#                     WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
#                     # RESULT_VARIABLE GIT_SUBMOD_RESULT
#     )
# endif ()


# if (GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# # Update submodules as needed
#     option (GIT_SUBMODULE "Check submodules during build" ON)
#     if (GIT_SUBMODULE)
#         message (STATUS "Submodule update")
#         # execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
#         #                 WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#         #                 RESULT_VARIABLE GIT_SUBMOD_RESULT)
# 		execute_process (
# 			# COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
# 			COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #submodule update --remote --merge --init --recursive

# 						# COMMAND ${GIT_EXECUTABLE} submodule foreach git pull main
#                         WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
#                         RESULT_VARIABLE GIT_SUBMOD_RESULT
# 		)

#         if (NOT GIT_SUBMOD_RESULT EQUAL "0")
#             message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
#         endif ()
#     endif ()
# endif ()

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        # execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
        #                 WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        #                 RESULT_VARIABLE GIT_SUBMOD_RESULT)
		execute_process(
			# COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
			# COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #submodule update --remote --merge --init --recursive
			COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge --recursive

						# COMMAND ${GIT_EXECUTABLE} submodule foreach git pull main
                        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT
		)
        execute_process(
			# COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
			# COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #submodule update --remote --merge --init --recursive
			COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge --recursive

						# COMMAND ${GIT_EXECUTABLE} submodule foreach git pull main
                        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT
		)

        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

include (cmake/parse.cmake)

include (cmake/libs.cmake)

include (cmake/functions.cmake)



# file (GLOB_RECURSE cmakes cmake/*.cmake)

# foreach (file ${cmakes})
#     include (${file})
# endforeach ()

