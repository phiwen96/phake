macro (ph_add_test name)
	add_executable (test_${name} testlib.cpp test_${name}.cpp ${HEADER_LIST})
	target_link_libraries (test_${name} PRIVATE ${PROJECT_NAME} Catch2::Catch2 ph::color)
	target_include_directories (test_${name} PRIVATE include ph::color)
	ph_precompile (TARGET test_${name} PRIVATE PCH ${std_pch})

	if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
		set_target_properties(test_${name}          PROPERTIES FOLDER "${PROJECT_NAME}")
	endif()		
endmacro ()