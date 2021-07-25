macro (ph_add_test name)
	add_executable (test_${name} testlib.cpp test_${name}.cpp ${HEADER_LIST})
	target_link_libraries (test_${name} PRIVATE ${PROJECT_NAME} Catch2::Catch2 ph::color)
	target_include_directories (test_${name} PRIVATE include ph::color)
	ph_precompile (TARGET test_${name} PRIVATE PCH ${std_pch})

	if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
		set_target_properties(test_${name}          PROPERTIES FOLDER "${PROJECT_NAME}")
	endif()		
endmacro ()




macro (ph_add_test name)
#if file doesnt exist, create one
	set (prefix ARG)
	set (NoValues DONT_ERASE_MODULE_IF_NOT_DEFINED)
	set (SingleValues NAME DESTINATION)
	set (MultiValues TESTS BAJS)

	cmake_parse_arguments (${prefix} "${NoValues}" "${SingleValues}" "${MultiValues}" ${ARGN})

	if (ARG_DESTINATION)
		# message(${ARG_DESTINATION})
		set(destination ${ARG_DESTINATION})
	else()
	   set (destination ${CMAKE_CURRENT_LIST_DIR})
	endif ()
	message("BAHS")

	if (ARG_TESTS)
		foreach (test_name IN LISTS ARG_TESTS)
			set (header_file "${ARG_INCLUDE}/${test_name}.hpp")
			set (source_file "${ARG_SRC}/${test_name}.cpp")
			if (EXISTS ${header_file})
				# message("${header_file} already exists.")
			else ()
				# message("creating ${header_file}")
				file (WRITE "${header_file}" "#pragma once")
			endif ()
			if (EXISTS ${source_file})
				# message("${source_file} already exists.")
			else ()
				# message ("creating ${header_file}")
				file (WRITE "${source_file}" "#include \"${module_name}.hpp\"")
			endif ()
		endforeach ()
	endif ()


	add_executable (test_${name} testlib.cpp test_${name}.cpp ${HEADER_LIST})
	target_compile_definitions (test_${name} PRIVATE "$<$<CONFIG:DEBUG>:DEBUG> $<$<CONFIG:RELEASE>:RELEASE>")

	target_link_libraries (test_${name} PRIVATE ph::concepts ${PROJECT_NAME} ${Boost_LIBRARIES} Catch2::Catch2)
	target_include_directories (test_${name} PRIVATE ${Boost_INCLUDE_DIRS} ph::concepts ../include)
	ph_precompile (TARGET test_${name} PRIVATE PCH ${std_pch} ${boost_pch})

	if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
		set_target_properties(test_${name}          PROPERTIES FOLDER "${PROJECT_NAME}")
	else ()
		set_target_properties(test_${name}          PROPERTIES FOLDER "dependencies/${PROJECT_NAME}")
	endif()		
endmacro ()


# ph_add_test(
# 	TESTS
# 		""
# )