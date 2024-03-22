import QtQuick as Q
import QtQuick.Controls as QC
import QtQuick.Dialogs as QD
import QtQuick.Layouts as QL
import org.kde.kirigami as K

Q.ListView {
    QL.Layout.fillHeight: true
    QL.Layout.fillWidth: true
    property int rowHeight
    required property string title
    required property list<var> headerButtons
    required property list<var> rowButtons
    
    component ButtonRepeater: Q.Repeater {
        required property list<var> buttonList
        model: buttonList.length
        
        delegate: QC.ToolButton {
            required property int index
            icon.name: buttonList[index].icon
            onClicked: buttonList[index].function()
        }
    }

    header: QC.ToolBar {
        z: 2
        width: parent.width
        horizontalPadding: K.Units.gridUnit
        
        Q.Component.onCompleted: () => {
            rowHeight = height 
        }
        
        QL.RowLayout {
            anchors.fill: parent
            
            Q.Text {
                QL.Layout.fillWidth: true
                text: title
            }
            
            ButtonRepeater {
                buttonList: headerButtons
            }
        }
    }

    headerPositioning: Q.ListView.OverlayHeader
    clip: true
    model: 300
    
    delegate: QC.ItemDelegate {
        height: rowHeight
        width: parent.width
        
        QL.RowLayout {
            height: parent.height
            width: parent.width - 2 * K.Units.gridUnit
            anchors.horizontalCenter: parent.horizontalCenter
            
            Q.Text {
                text: index
                QL.Layout.fillWidth: true
            }
            
            ButtonRepeater {
                buttonList: rowButtons
            }
        }
    }
}