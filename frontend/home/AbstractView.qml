import QtQuick.Controls as C
import org.kde.kirigami as K
import QtQuick.Layouts as L
import QtQuick as Q

Q.Item {
    id: root

    required property string viewHeaderTitle
    required property list<var> viewHeaderButtonList
    required property var viewModel
    required property Q.Component viewItemDelegate

    property int rowHeight
    property alias viewList: _viewList

    L.Layout.fillHeight: true
    L.Layout.fillWidth: true

    Q.ListView {
        id: _viewList

        property int index

        anchors.fill: root
        clip: true
        currentIndex: -1
        model: root.viewModel
        delegate: root.viewItemDelegate
        headerPositioning: Q.ListView.OverlayHeader

        header: C.ToolBar {
            id: viewHeader
            z: 2
            width: root.viewList.width
            horizontalPadding: K.Units.gridUnit
            
            Q.Component.onCompleted: () => {
                root.rowHeight = viewHeader.height
            }
            
            L.RowLayout {
                anchors.fill: viewHeader.contentItem
                
                Q.Text {
                    L.Layout.fillWidth: true
                    text: root.viewHeaderTitle
                }
                
                ButtonRow {
                    buttonList: root.viewHeaderButtonList
                }
            }
        }
    }
}