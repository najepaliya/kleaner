#include "file_model.hpp"

FileModel::FileModel(QObject* parent)
    : QAbstractListModel(parent)
{}

int FileModel::rowCount(const QModelIndex& parent) const
{
    return fileList.count();
}

QVariant FileModel::data(const QModelIndex& index, int role) const
{
    return fileList.value(index.row());
}

void FileModel::addFiles(QList<QUrl> urls)
{
    QList<QString> validFiles;
    for (QUrl& url : urls)
    {
        QString filePath = url.toLocalFile();
        if (not fileList.contains(filePath))
        {
            validFiles.append(filePath);
        }
    }
    int validFileCount = validFiles.count();
    if (validFileCount > 0)
    {
        int currentFileCount = fileList.count();
        beginInsertRows(QModelIndex(), currentFileCount, currentFileCount + validFileCount - 1);
        fileList.append(validFiles);
        endInsertRows();
    }
}

void FileModel::removeFile(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    fileList.remove(index);
    endRemoveRows();
}

void FileModel::removeAllFiles()
{
    beginRemoveRows(QModelIndex(), 0, fileList.count() - 1);
    fileList.clear();
    endRemoveRows();
}