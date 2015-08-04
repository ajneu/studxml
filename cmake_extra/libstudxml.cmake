
##################################
# libstudxml Download and Checksum 
##################################
set(LIBSTUDXML_DOWNLOAD libstudxml-1.0.1.tar.bz2)
set(LIBSTUDXML_DIR      libstudxml-1.0.1)         # unzipped directory
set(LIBSTUDXML_INSTALL  libstudxml-1.0.1_install) # directory holding the result of building

set(LIBSTUDXML_DOWNLOAD_VARIANT 2)

if (${LIBSTUDXML_DOWNLOAD_VARIANT} EQUAL 1)
  file(DOWNLOAD http://www.codesynthesis.com/download/libstudxml/1.0/${LIBSTUDXML_DOWNLOAD}.sha1
                                              "${PROJECT_BINARY_DIR}/${LIBSTUDXML_DOWNLOAD}.sha1")

  file(DOWNLOAD http://www.codesynthesis.com/download/libstudxml/1.0/${LIBSTUDXML_DOWNLOAD}
                                              "${PROJECT_BINARY_DIR}/${LIBSTUDXML_DOWNLOAD}")

  execute_process(COMMAND sha1sum -c "${LIBSTUDXML_DOWNLOAD}.sha1"
    WORKING_DIRECTORY "${PROJECT_BINARY_DIR}"
    RESULT_VARIABLE RESULT_VAR)

  if (NOT (${RESULT_VAR} EQUAL 0))
    message(FATAL_ERROR "sha1sum of download ${LIBSTUDXML_DOWNLOAD} not correct")
  endif()
  
else()

  file(DOWNLOAD http://www.codesynthesis.com/download/libstudxml/1.0/${LIBSTUDXML_DOWNLOAD}
                                              "${PROJECT_BINARY_DIR}/${LIBSTUDXML_DOWNLOAD}"
       EXPECTED_HASH SHA1=59e40dd960e202648dca6a93b491dbe8823499c7)
endif()


##################################
# libstudxml build
##################################
if (NOT EXISTS "${PROJECT_BINARY_DIR}/${LIBSTUDXML_INSTALL}")
  execute_process(COMMAND tar xf "${LIBSTUDXML_DOWNLOAD}"
                  WORKING_DIRECTORY "${PROJECT_BINARY_DIR}")

  execute_process(COMMAND ./configure --prefix "${PROJECT_BINARY_DIR}/${LIBSTUDXML_INSTALL}"
                  WORKING_DIRECTORY "${PROJECT_BINARY_DIR}/${LIBSTUDXML_DIR}")

  execute_process(COMMAND make
                  WORKING_DIRECTORY "${PROJECT_BINARY_DIR}/${LIBSTUDXML_DIR}")

  execute_process(COMMAND make install
                  WORKING_DIRECTORY "${PROJECT_BINARY_DIR}/${LIBSTUDXML_DIR}")
endif()
