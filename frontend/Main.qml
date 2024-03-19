import org.kde.kirigami as Kirigami
import QtQuick.Controls
import QtQuick.Layouts
import io.github.najepaliya.kleaner

Kirigami.ApplicationWindow {
    height: 540
    width: 960

    property int randNum: 0

    Backend {
        id: myBackend
        onNumberEmitted: (num) => {
            randNum = num
        }
    }

    ColumnLayout {
        Button {
            text: "Generate Number"
            onClicked: myBackend.generateNumber()
        }

        Label {
            text: randNum
        }
    }
}