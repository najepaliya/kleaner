#include "FileModel.hpp"

FileModel::FileModel (QObject* parent) : QAbstractListModel (parent)
{
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

void FileModel::removeFiles (int first, int last)
{
    beginRemoveRows (QModelIndex(), first, last);
    for (int i = first; i < last + 1; i++)
    {
        list.removeAt(i);
    }
    endRemoveRows ();
}

void FileModel::insertFiles (QStringList filepaths)
{
    beginResetModel ();
    for (int i = 0; i < filepaths.size(); i++)
    {
        if (!list.contains(filepaths[i]))
        {
            list.append(filepaths[i]);
        }
    }
    list.sort ();
    endResetModel ();
}

QStringList FileModel::getList()
{
    return list;
}