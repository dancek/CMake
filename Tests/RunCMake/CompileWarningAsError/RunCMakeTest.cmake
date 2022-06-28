include(RunCMake)

function(run_compile_warn test lang extension)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/${test}_${lang}-build)
  set(RunCMake_TEST_OUTPUT_MERGE 1)
  run_cmake_with_options(${test}_${lang} "-DLANGUAGE=${lang}" "-DEXTENSION=${extension}" ${ARGN})
  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(${test}_${lang}-Build ${CMAKE_COMMAND} --build . ${verbose_args})
endfunction()

set(langs C CXX)
set(exts c cxx)

foreach(lang ext IN ZIP_LISTS langs exts)
  run_compile_warn(WerrorOn ${lang} ${ext})
  run_compile_warn(WerrorOff ${lang} ${ext})
  run_compile_warn(WerrorOnIgnore ${lang} ${ext} "--compile-no-warning-as-error")
endforeach()
