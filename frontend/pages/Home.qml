import org.kde.kirigami as K
import QtQuick.Layouts as QL
import "../components"
import io.github.najepaliya.kleaner

K.Page {
    title: "Home"

    QL.ColumnLayout {
        anchors.fill: parent
        spacing: K.Units.gridUnit
        
        AbstractView {
            title: "Files"
            
            headerButtons: [
                {
                    icon: "edit-clear-history",
                    function: () => {
                        Backend.generateNumber()
                    }
                },
                {
                    icon: "list-add",
                    function: () => {
                        console.log("list added")
                    }
                }
            ]
            
            rowButtons: [
                {
                    icon: "edit-delete",
                    function: () => {
                        console.log("row deleted")
                    }
                }
            ]
        }

        AbstractView {
            title: "Templates"
            
            headerButtons: [
                {
                    icon: "list-add",
                    function: () => {
                        console.log("list added")
                    }
                }
            ]
            
            rowButtons: [
                {
                    icon: "edit-entry",
                    function: () => {
                        console.log("row edited")
                    }
                },
                {
                    icon: "edit-delete",
                    function: () => {
                        console.log("row deleted")
                    }
                }
            ]
        }
    }
}