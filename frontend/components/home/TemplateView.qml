import QtQuick as Q
import QtQuick.Controls as QC
import QtQuick.Dialogs as QD
import QtQuick.Layouts as QL
import org.kde.kirigami as K

Q.ListView {
    QL.Layout.fillHeight: true
    QL.Layout.fillWidth: true
    property int rowHeight
    header: QC.ToolBar {
        z: 2
        width: parent.width
        horizontalPadding: K.Units.gridUnit
        Q.Component.onCompleted: () => {
            parent.rowHeight = height 
        }
        QL.RowLayout {
            anchors.fill: parent
            Q.Text {
                QL.Layout.fillWidth: true
                text: "Templates"
            }
            QC.ToolButton {
                icon.name: "list-add"
            }
        }
    }
    headerPositioning: Q.ListView.OverlayHeader
    clip: true
    id: listView
    model: 300
    delegate: QC.ItemDelegate {
        height: parent.rowHeight
        width: parent.width
        QL.RowLayout {
            anchors.fill: parent
            Q.Text {
                text: index
                QL.Layout.fillWidth: true
                QL.Layout.leftMargin: K.Units.gridUnit
            }
            QC.ToolButton {
                icon.name: "edit-entry"
            }
            QC.ToolButton {
                icon.name: "edit-delete"
                QL.Layout.rightMargin: K.Units.gridUnit
            }
        }
    }
}