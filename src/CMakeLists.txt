add_executable(kleaner main.cpp FileModel.cpp resources.qrc)
target_link_libraries(kleaner Qt5::Quick Qt5::Qml Qt5::Gui Qt5::QuickControls2 Qt5::Widgets KF5::Kirigami2 KF5::I18n)
install(TARGETS kleaner ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})