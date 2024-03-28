const openFileDialog = () => {
    fileDialog.open()
}

const addFiles = () => {
    Backend.fileModel.addFiles(fileDialog.selectedFiles)
}

const removeFile = () => {
    Backend.fileModel.removeFile(index)
}

const removeAllFiles = () => {
    Backend.fileModel.removeAllFiles()
}