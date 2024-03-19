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

# generate required file for LSP
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# enable defauts
qt_standard_project_setup(REQUIRES ${QT6_MIN_VERSION})

# add executable target
qt_add_executable(kleaner
    backend/main.cpp
)

# generate qml module from executable target
qt_add_qml_module(kleaner
    URI io.github.najepaliya.kleaner
    QML_FILES frontend/Main.qml
    SOURCES backend/backend.hpp backend/backend.cpp
)

# link required libraries to target
target_include_directories(kleaner PUBLIC backend)
target_link_libraries(kleaner PRIVATE Qt6::Widgets)