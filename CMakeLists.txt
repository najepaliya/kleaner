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

# add executable target
qt_add_executable(kleaner
    main/main.cpp
)

# add c++ sources to executable target
target_sources(kleaner PUBLIC
    backend/backend.cpp
    backend/file_model.cpp
)

# Bundle qml and js sources with executable target
qt_add_qml_module(kleaner
    URI io.github.najepaliya.kleaner
    QML_FILES main/Main.qml frontend/home/HomePage.qml frontend/home/AbstractView.qml frontend/home/FileView.qml frontend/home/FileViewFunctions.js frontend/home/TemplateView.qml frontend/home/TemplateViewFunctions.js frontend/home/ButtonRow.qml
)

# link required libraries to target
target_include_directories(kleaner PUBLIC backend)
target_link_libraries(kleaner PRIVATE Qt6::Widgets)