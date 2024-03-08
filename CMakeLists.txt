# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: 2024 Neel Jepaliya <najepaliya@gmail.com>

cmake_minimum_required(VERSION 3.16)

project(kleaner VERSION 1.1)

include(FeatureSummary)

set(QT6_MIN_VERSION 6.5.0)
set(KF6_MIN_VERSION 6.0.0)

find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(FeatureSummary)
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMSetupVersion)
include(ECMFindQmlModule)
# if (NOT ANDROID)
    include(KDEGitCommitHooks)
    include(KDEClangFormat)
# endif()

ecm_setup_version(${PROJECT_VERSION}
    VARIABLE_PREFIX KLEANER
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/source/version-kleaner.h"
)

set(QT_EXTRA_COMPONENTS)
# if (NOT ANDROID)
    list(APPEND QT_EXTRA_COMPONENTS Widgets)
# endif()

find_package(Qt6 ${QT6_MIN_VERSION} REQUIRED COMPONENTS Core Gui Qml QuickControls2 Svg ${QT_EXTRA_COMPONENTS})
find_package(KF6 ${KF6_MIN_VERSION} REQUIRED COMPONENTS Kirigami2 CoreAddons Config I18n)

qt_policy(SET QTP0001 NEW)

ecm_find_qmlmodule(org.kde.kirigamiaddons.formcard 1.0)

# if (ANDROID)
#     configure_file(${CMAKE_CURRENT_SOURCE_DIR}/android/version.gradle.in ${CMAKE_BINARY_DIR}/version.gradle)
# endif()

add_subdirectory(source)

install(FILES data/io.github.najepaliya.kleaner.desktop DESTINATION ${KDE_INSTALL_APPDIR})
install(FILES data/io.github.najepaliya.kleaner.metainfo.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
install(FILES data/io.github.najepaliya.kleaner.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
ki18n_install(po)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

# if (NOT ANDROID)
    file(GLOB_RECURSE ALL_CLANG_FORMAT_SOURCE_FILES src/*.cpp src/*.h)
    kde_clang_format(${ALL_CLANG_FORMAT_SOURCE_FILES})
    kde_configure_git_pre_commit_hook(CHECKS CLANG_FORMAT)
# endif()
