cmake_minimum_required (VERSION 3.19.6)

project (phake)

file (GLOB_RECURSE cmakes cmake/*.cmake)

foreach (file ${cmakes})
    include (${file})
endforeach ()

