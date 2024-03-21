import org.kde.kirigami as K
import "../frontend/pages"

K.ApplicationWindow {
    height: 960
    width: 540

    pageStack.initialPage: Home {}
}