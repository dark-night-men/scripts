#!/usr/bin/env python
#
# Copyright (C) 2014  Google Inc.
#
# This file is part of YouCompleteMe.
#
# YouCompleteMe is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# YouCompleteMe is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with YouCompleteMe.  If not, see <http://www.gnu.org/licenses/>.

import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-Wall',
'-Wextra',
'-Werror',
'-fexceptions',
'-DNDEBUG',
# THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
# language to use when compiling headers. So it will guess. Badly. So C++
# headers will be compiled as C headers. You don't want that so ALWAYS specify
# a "-std=<something>".
# For a C project, you would set this to something like 'c99' instead of
# 'c++11'.
#'-std=c++11',
'-std=c++1y',
# ...and the same thing goes for the magic -x option which specifies the
# language that the files to be compiled are written in. This is mostly
# relevant for c++ headers.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x',
'c++',
'-isystem',
'/usr/include',
'-isystem',
'/usr/local/include',
'-isystem',
'/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1',
'-isystem',
'/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtconnectivity/include/QtBluetooth',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtconnectivity/include/QtNfc',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtsensors/include/QtSensors',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwebkit/include/QtWebKit',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwebkit/include/QtWebKitWidgets',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtactiveqt/include/ActiveQt',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtquick1/include/QtDeclarative',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwebengine/include/QtWebEngineWidgets',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwebengine/include/QtWebEngine',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwayland/include/QtCompositor',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwayland/include/QtWaylandClient',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtlocation/include/QtPositioning',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtlocation/include/QtLocation',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtmacextras/include/QtMacExtras',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtserialport/include/QtSerialPort',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtandroidextras/include/QtAndroidExtras',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtcanvas3d/include/QtCanvas3D',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtenginio/include/Enginio',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtGui',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtOpenGLExtensions',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtPlatformHeaders',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtSql',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtANGLE',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtZlib',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtWidgets',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtCore',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtTest',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtDBus',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtConcurrent',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtXml',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtPlatformSupport',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtNetwork',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtPrintSupport',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtbase/include/QtOpenGL',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwebsockets/include/QtWebSockets',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qttools/include/QtUiPlugin',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qttools/include/QtHelp',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qttools/include/QtDesignerComponents',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qttools/include/QtUiTools',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qttools/include/QtCLucene',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qttools/include/QtDesigner',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qt3d/include/Qt3DCore',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qt3d/include/Qt3DRenderer',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qt3d/include/Qt3DQuickRenderer',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qt3d/include/Qt3DInput',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qt3d/include/Qt3DQuick',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtx11extras/include/QtX11Extras',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwebchannel/include/QtWebChannel',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtscript/include/QtScriptTools',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtscript/include/QtScript',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtwinextras/include/QtWinExtras',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtmultimedia/include/QtMultimedia',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtmultimedia/include/QtMultimediaQuick_p',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtmultimedia/include/QtMultimediaWidgets',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtdeclarative/include/QtQml',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtdeclarative/include/QtQuickTest',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtdeclarative/include/QtQuick',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtdeclarative/include/QtQuickParticles',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtdeclarative/include/QtQuickWidgets',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtdeclarative/include/QtQmlDevTools',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtsvg/include/QtSvg',
'-isystem',
'/home/zerg/download/qt-everywhere-opensource-src-5.5.0/qtxmlpatterns/include/QtXmlPatterns',
'-isystem',
'/usr/include/c++/5',
'-isystem',
'/usr/include/c++/5.4.0'
]


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags.
compilation_database_folder = ''

if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def FlagsForFile( filename, **kwargs ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = GetCompilationInfoForFile( filename )
    if not compilation_info:
      return None

    final_flags = MakeRelativePathsInFlagsAbsolute(
      compilation_info.compiler_flags_,
      compilation_info.compiler_working_dir_ )
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }

