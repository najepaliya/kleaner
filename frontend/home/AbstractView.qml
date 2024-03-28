import QtQuick.Controls as C
import org.kde.kirigami as K
import QtQuick.Layouts as L
import QtQuick as Q

Q.ListView {
    id: root
    
    required property string viewTitle
    required property list<var> headerButtonList
    required property list<var> rowButtonList
    required property var viewModel
    
    property int rowHeight
    property int index

    L.Layout.fillHeight: true
    L.Layout.fillWidth: true

    component ButtonRow: Q.Repeater {
        required property list<var> buttonList
        
        model: buttonList.length
        
        delegate: C.ToolButton {
            required property int index
            icon.name: buttonList[index].icon
            onClicked: buttonList[index].function()
        }
    }

    header: C.ToolBar {
        z: 2
        width: parent.width
        horizontalPadding: K.Units.gridUnit
        
        Q.Component.onCompleted: () => {
            rowHeight = height 
        }
        
        L.RowLayout {
            anchors.fill: parent
            
            Q.Text {
                L.Layout.fillWidth: true
                text: root.viewTitle
            }
            
            ButtonRow {
                buttonList: root.headerButtonList
            }
        }
    }

    headerPositioning: Q.ListView.OverlayHeader
    clip: true
    model: root.viewModel
    
    delegate: C.ItemDelegate {
        height: rowHeight
        width: parent.width
        
        L.RowLayout {
            height: parent.height
            width: parent.width - 2 * K.Units.gridUnit
            anchors.horizontalCenter: parent.horizontalCenter
            
            Q.Text {
                text: model.display
                L.Layout.fillWidth: true
            }
            
            ButtonRow {
                buttonList: root.rowButtonList
            }
        }
    }
}