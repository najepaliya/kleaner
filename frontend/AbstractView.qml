import QtQuick as Q
import QtQuick.Controls as QC
import org.kde.kirigami as K
import QtQuick.Layouts as QL

Q.Item {
    id: root

    required property var viewModel
    required property Q.Component viewHeaderRow
    required property Q.Component viewItemRow

    property int rowHeight

    QL.Layout.fillHeight: true
    QL.Layout.fillWidth: true

    Q.ListView {
        id: viewList
        
        anchors.fill: root
        clip: true
        currentIndex: -1
        
        headerPositioning: Q.ListView.OverlayHeader
        header: QC.ToolBar {
            id: viewHeader

            z: 2
            width: viewList.width
            horizontalPadding: K.Units.gridUnit
            
            Q.Loader {
                anchors.fill: viewHeader.contentItem

                sourceComponent: root.viewHeaderRow
            }

            Q.Component.onCompleted: () => {
                root.rowHeight = viewHeader.height
            }
        }

        model: root.viewModel

        delegate: QC.ItemDelegate {
            id: viewItem

            height: root.rowHeight
            width: viewList.width
            horizontalPadding: K.Units.gridUnit

            Q.Loader {
                anchors.fill: viewItem.contentItem
                
                property var viewModel: model
                sourceComponent: root.viewItemRow
            }
        }
    }
}