cmake_policy(SET CMP0057 NEW)
include(RunCMake)

function(run_test name)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/${name}-build)
  run_cmake(${name})
  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(${name}-build ${CMAKE_COMMAND} --build . --config Debug)
  run_cmake_command(${name}-test ${CMAKE_CTEST_COMMAND} -C Debug)
endfunction()

run_cmake(DisabledPch)
run_cmake(PchDebugGenex)
run_test(PchInterface)
run_cmake(PchPrologueEpilogue)
run_test(SkipPrecompileHeaders)
run_test(CXXnotC)
run_test(PchReuseFrom)
run_test(PchReuseFromPrefixed)
run_test(PchReuseFromSubdir)
run_cmake(PchMultilanguage)
if(RunCMake_GENERATOR MATCHES "Make|Ninja")
  run_cmake(PchWarnInvalid)

  if(CMAKE_C_COMPILER_ID STREQUAL "Clang" AND
     CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0.0)
    run_cmake(PchInstantiateTemplates)
  endif()
endif()
run_test(PchReuseFromObjLib)
run_test(PchIncludedAllLanguages)
run_test(PchIncludedOneLanguage)
run_test(PchLibObjLibExe)
