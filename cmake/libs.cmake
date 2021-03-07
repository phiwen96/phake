
set (boost_preprocessor_pch 
<boost/preprocessor/seq/for_each.hpp>
<boost/preprocessor/variadic/to_seq.hpp>
<boost/preprocessor/facilities/expand.hpp>
<boost/preprocessor/stringize.hpp>
<boost/preprocessor/repetition/enum_params.hpp>
<boost/preprocessor/cat.hpp>
<boost/preprocessor/seq/cat.hpp>
<boost/preprocessor/control/if.hpp>
<boost/preprocessor/facilities/empty.hpp>
<boost/preprocessor/facilities/identity.hpp>
<boost/preprocessor/seq/to_tuple.hpp>
<boost/preprocessor/seq/for_each_i.hpp>
<boost/preprocessor/arithmetic/inc.hpp>
<boost/preprocessor/comparison/not_equal.hpp>
<boost/preprocessor/repetition/for.hpp>
<boost/preprocessor/tuple/elem.hpp>
<boost/preprocessor/repetition.hpp>
<boost/preprocessor/arithmetic/sub.hpp>
<boost/preprocessor/punctuation/comma_if.hpp>
<boost/preprocessor/control/if.hpp>
<boost/preprocessor/facilities/empty.hpp>
<boost/preprocessor/facilities/identity.hpp>
CACHE 
STRING 
"boost pch headers"
)

set (std_pch
<iostream>
<vector>
<string>
<utility>
<function>
<array>
<tuple>
<type_traits>
<fstream>
<regex>
CACHE 
STRING 
"std pch headers"
)



function(ph_boost target)
    cmake_parse_arguments(p "public;private;interface;no_pch" "" "" ${ARGN})
    if (${ARGC} EQUAL "1" OR p_public)
        set (t3 PUBLIC)
    elseif (p_private)
        set (t3 PRIVATE)
    elseif(p_interface)
        set (t3 INTERFACE)
    endif()
    cmake_language (EVAL CODE "
        target_link_libraries(${target} ${t3} ${Boost_LIBRARIES})
        target_include_directories (${target} ${t3} ${Boost_INCLUDE_DIRS})
    ")
    if (NOT p_no_pch)
        target_precompile_headers (${target} 
         PRIVATE 
            ${boost_preprocessor_pch}
        )
    endif ()
    
    
    
endfunction()




function (ph_precompile)
    set(p       p)
    set(n0     PRIVATE PUBLIC)
    set(n1 TARGET)
    set(n  HEADERS PCH)

    set (availability PUBLIC)

    cmake_parse_arguments( ${p}
                            "${n0}"
                            "${n1}"
                            "${n}"
                            ${ARGN}
    )

    foreach(arg IN LISTS n0)
        if(${${p}_${arg}})
            set (availability "${arg}")
            break ()
        else()
        endif()
    endforeach()

    foreach(arg IN LISTS n1)
        if ("${arg}" STREQUAL TARGET)
            set (target ${${p}_${arg}})
        endif ()
        
    endforeach()
    

    foreach (arg IN LISTS n)
        if ("${arg}" STREQUAL HEADERS)
            set (${headers} ${headers} ${${p}_${arg}})
        elseif ("${arg}" STREQUAL PCH)
            message("PCH = ${${p}_${arg}}")
            set (${headers} ${headers} ${${p}_${arg}})
        endif ()
        list (APPEND headers ${${p}_${arg}})
    endforeach ()
    # message(${target})
    message (${headers})
    # message (${availability})
    target_precompile_headers (${target} ${availability} ${headers})


    
endfunction ()



