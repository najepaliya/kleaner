add_executable(helloworld main.cpp resources.qrc)
target_link_libraries(helloworld Qt5::Quick Qt5::Qml Qt5::Gui Qt5::QuickControls2 Qt5::Widgets KF5::Kirigami2 KF5::I18n)