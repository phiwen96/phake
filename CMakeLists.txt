cmake_minimum_required (VERSION 3.19.6)

add_custom_target (phake)


macro(lol)
	# processor
	set (_x86_64 "false")
	set (_arm64 "false")
	if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64")
		set (_x86_64 "true")
	elseif (${CMAKE_SYSTEM_PROCESSOR} MATCHES "arm64")
		set (_arm64 "true")
	else ()
		message (FATAL_ERROR "unknown processor")
	endif ()

	set (_Darwin "false")
	set (_Linux "false")
	set (_Windows "false")

	if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
		# message("Darwin")
		set (_Darwin "true")
		# add_compile_definitions (Darwin)
	elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
		set (_Linux "true")
		# add_compile_definitions (Linux)
	elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
		message (FATAL_ERROR "not yet defined for Windows")

		set (_Windows 1)
		# add_compile_definitions (Windows)
	else ()
		message (FATAL_ERROR "unknown system ${CMAKE_SYSTEM_NAME}")
	endif ()
endmacro(lol)





list (APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
		execute_process(
			# COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #--recursive
            COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive --jobs 8
                        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT
		)

		# execute_process(
		# 	# COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #--recursive
        #     COMMAND ${GIT_EXECUTABLE} submodule update --remote

        #                 WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        #                 RESULT_VARIABLE GIT_SUBMOD_RESULT
		# )

		# execute_process(
		# 	# COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #--recursive
        #     COMMAND ${GIT_EXECUTABLE} submodule update --remote

        #                 WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        #                 RESULT_VARIABLE GIT_SUBMOD_RESULT
		# )

		# execute_process(
		# 	# COMMAND ${GIT_EXECUTABLE} submodule update --remote --merge #--recursive
        #     COMMAND ${GIT_EXECUTABLE} pull

        #                 WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        #                 RESULT_VARIABLE GIT_SUBMOD_RESULT
		# )





        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()


include (FetchContent)


file (GLOB_RECURSE cmakes cmake/*.cmake)

foreach (file ${cmakes})
    include (${file})
endforeach ()

