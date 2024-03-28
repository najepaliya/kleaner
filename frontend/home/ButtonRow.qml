import QtQuick.Controls as C
import QtQuick as Q

Q.Repeater {
    required property list<var> buttonList
    
    model: buttonList.length
    
    delegate: C.ToolButton {
        required property int index
        icon.name: buttonList[index].icon
        onClicked: buttonList[index].function()
    }
}