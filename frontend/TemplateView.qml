import QtQuick.Controls as C
import "TemplateViewFunctions.js" as F
import org.kde.kirigami as K
import QtQuick.Layouts as L
import QtQuick as Q
import io.github.najepaliya.kleaner

AbstractView {
    id: root

    viewHeaderTitle: "Templates"
    
    viewHeaderButtonList: [
        {
            icon: "list-add",
            function: F.addTemplate
        }
    ]

    viewModel: 2000

    C.ButtonGroup {
        id: buttonGroup
    }

    viewItemDelegate: C.RadioDelegate {
        id: itemDelegate

        height: root.rowHeight
        width: root.viewList.contentItem.width

        indicator: C.RadioButton {
            id: radioButton
            C.ButtonGroup.group: buttonGroup
            leftPadding: K.Units.gridUnit
            anchors.verticalCenter: itemDelegate.verticalCenter
        }

        L.RowLayout {
            height: itemDelegate.height
            width: itemDelegate.width - 2 * K.Units.gridUnit
            anchors.horizontalCenter: itemDelegate.horizontalCenter

            Q.Text {
                text: index
                leftPadding: K.Units.gridUnit + K.Units.gridUnit
                L.Layout.fillWidth: true
            }

            ButtonRow {
                buttonList: [
                    {
                        icon: "edit-entry",
                        function: F.editTemplate
                    },
                    {
                        icon: "edit-delete",
                        function: F.deleteTemplate
                    }
                ]
            }
        }
    }
}