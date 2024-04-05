# set versions
cmake_minimum_required(VERSION 3.16)
set(KF6_MIN_VERSION 6.0)
set(QT6_MIN_VERSION 6.6)

# set project
project(kleaner)

# set path
find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

# find packages
find_package(KF6 ${KF6_MIN_VERSION} REQUIRED COMPONENTS Kirigami)
find_package(Qt6 ${QT6_MIN_VERSION} REQUIRED COMPONENTS Widgets)
find_package(KExiv2Qt6)

# generate required file for LSP
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# enable defauts
qt_standard_project_setup(REQUIRES ${QT6_MIN_VERSION})

# frontend main executable target
qt_add_executable(kleaner
    frontend/main.cpp
)
qt_add_qml_module(kleaner
    URI
        io.github.najepaliya.kleaner
    VERSION
        1.0
    QML_FILES
        frontend/Main.qml
        frontend/HomePage.qml
        frontend/FileView.qml
        frontend/FileViewFunctions.js
        frontend/AbstractView.qml
        frontend/ButtonRow.qml
)

# backend static library target
qt_add_qml_module(libkleaner
STATIC
URI io.github.najepaliya.kleaner.backend
VERSION 1.0
SOURCES
    backend/main.cpp
    backend/file_model.cpp
)
target_include_directories(libkleaner PUBLIC backend)
target_link_libraries(libkleaner PRIVATE Qt6::Widgets)

# link backend static library target to frontend main executable target
target_link_libraries(kleaner PRIVATE Qt6::Widgets libkleanerplugin)