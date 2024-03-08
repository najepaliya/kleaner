# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: 2024 Neel Jepaliya <najepaliya@gmail.com>

# Target: static library
qt_add_qml_module(kleaner_static
    STATIC
    URI io.github.najepaliya.kleaner
    VERSION 1.1
    QML_FILES
        contents/ui/Main.qml
        contents/ui/About.qml
)

target_sources(kleaner_static PUBLIC
    app.cpp
)

target_link_libraries(kleaner_static PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Svg
    KF6::I18n
    KF6::CoreAddons
    KF6::ConfigCore
    KF6::ConfigGui
)
target_include_directories(kleaner_static PUBLIC ${CMAKE_BINARY_DIR})

# if (ANDROID)
#     kirigami_package_breeze_icons(ICONS
#         list-add
#         help-about
#         application-exit
#         applications-graphics
#     )
# else()
    target_link_libraries(kleaner_static PUBLIC Qt::Widgets)
# endif()

kconfig_add_kcfg_files(kleaner_static GENERATE_MOC kleanerconfig.kcfgc)

# Target: main executable
add_executable(kleaner main.cpp)
target_link_libraries(kleaner PUBLIC kleaner_static kleaner_staticplugin)
install(TARGETS kleaner ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
