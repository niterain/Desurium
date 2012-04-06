if(64BIT)
  set(EXTRA_OPTS "arch=x64")
endif()

if(DEBUG) 
ExternalProject_Add(
  boost
  URL http://downloads.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.zip
  URL_MD5 854dcbbff31b896c85c38247060b7713
  UPDATE_COMMAND ""
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND bootstrap.bat
  BUILD_COMMAND b2.exe --with-date_time --with-filesystem
                  --with-thread --with-system variant=debug link=static
				  threading=multi runtime-link=shared
  INSTALL_COMMAND ""
)
else()
ExternalProject_Add(
  boost
  URL http://downloads.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.zip
  URL_MD5 854dcbbff31b896c85c38247060b7713
  UPDATE_COMMAND ""
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND bootstrap.bat
  BUILD_COMMAND b2.exe --with-date_time --with-filesystem
                  --with-thread --with-system variant=release link=static
				  threading=multi runtime-link=shared
  INSTALL_COMMAND ""
)
endif()

ExternalProject_Get_Property(
    boost
    source_dir
)

set(Boost_DIR ${source_dir})
set(Boost_INCLUDE_DIR ${Boost_DIR})
set(Boost_LIBRARY_DIR ${Boost_DIR}/stage/lib)

# todo: get desura build with system layout
if(DEBUG)
	set(BAS "-vc100-mt-gd-1_49")
else()
	set(BAS "-vc100-mt-1_49")
endif()

set(Boost_LIBRARIES "${Boost_LIBRARY_DIR}/libboost_date_time${BAS}.lib;${Boost_LIBRARY_DIR}/libboost_filesystem${BAS}.lib;${Boost_LIBRARY_DIR}/libboost_system${BAS}.lib;${Boost_LIBRARY_DIR}/libboost_thread${BAS}.lib")
