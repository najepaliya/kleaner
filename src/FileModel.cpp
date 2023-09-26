#include "FileModel.hpp"

FileModel::FileModel (QObject* parent) : QAbstractListModel (parent)
{
    // list = QColor::colorNames();
}

int FileModel::rowCount (const QModelIndex& parent) const
{
    if (!parent.isValid())
    {
        return list.size();
    }
    return 0;
}

QVariant FileModel::data (const QModelIndex& index, int role) const
{
    if (role != Qt::DisplayRole)
    {
        return QVariant();
    }
    const int row = index.row();
    const QString result = list[row];
    return result;
}

// QHash<int,QByteArray> FileModel::roleNames () const
// {
//     QHash<int,QByteArray> mapping;
//     mapping[Qt::DisplayRole] = "display";
//     return mapping;
// }

QString FileModel::removeFile (int index)
{
    beginRemoveRows (QModelIndex(), index, index);
    QString filename = list.takeAt(index);
    endRemoveRows ();
    return filename;
}

void FileModel::insertFiles (QList<QUrl> urls)
{

    beginResetModel ();
    for (int i = 0; i < urls.size(); i++)
    {
        QString filename = urls[i].toLocalFile();
        if (!list.contains(filename))
        {
            list.append(filename);
        }
    }
    list.sort ();
    endResetModel ();
}