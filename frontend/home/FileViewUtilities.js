const addFiles = () => {
    Backend.fileModel.addFiles(fileDialog.selectedFiles)
}

const headerButtonList = [
    {
        icon: "edit-clear-history",
        function: () => {
            Backend.fileModel.removeAllFiles()
        }
    },
    {
        icon: "list-add",
        function: () => {
            fileDialog.open()
        }
    }
]

const rowButtonList = [
    {
        icon: "edit-delete",
        function: () => {
            Backend.fileModel.removeFile(index)
        }
    }
]