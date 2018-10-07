-- hypercycles-sdl (https://github.com/Herschel/hypercycles-sdl)
-- Copyright (c) 2015 The hypercycles-sdl authors
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-- General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

workspace "hypercycles"
  language "C++"
  configurations { "debug", "release" }
  if os.target() == "windows" then
    platforms { "win64" }
  else
    platforms { "osx" }
  end

  -- Windows SDK version.
  -- Must be set outside filter.
  systemversion "10.0.15063.0"

  filter "configurations:debug"
    defines { "DEBUG" }
    symbols "On"

  filter "configurations:release"
    defines { "NDEBUG" }
    optimize "On"

  filter "platforms:win64"
    system "Windows"
    architecture "x64"

  filter "platforms:osx"
    system "macosx"
    libdirs { "/usr/local/lib" }
    includedirs { "/usr/local/include/SDL2" }
    links { "SDL2", "SDL2_mixer" }


  project "hypercycles"
    kind "ConsoleApp"

    targetdir "bin/%{cfg.buildcfg}"
    debugdir "assets"

    -- Windows only, but must be set outside filter.
    nuget {
      "sdl2.nuget:2.0.8.2",
      "sdl2.nuget.redist:2.0.8.2",
      "sdl2_mixer.nuget:2.0.2.2",
      "sdl2_mixer.nuget.redist:2.0.2.2"
    }

    files { "src/*.c", "src/*.cpp", "src/*.h" }
    excludes { "src/build1.cpp" }
