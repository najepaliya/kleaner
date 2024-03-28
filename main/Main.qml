import org.kde.kirigami as K
import "../frontend/home"

K.ApplicationWindow {
    height: 960
    width: 540

    pageStack.initialPage: HomePage {}
}