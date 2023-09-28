#pragma once

#include <QtWidgets>

class FileModel : public QAbstractListModel
{
    Q_OBJECT

    public:
        explicit FileModel (QObject* parent = nullptr);
        int rowCount (const QModelIndex& parent) const override;
        QVariant data (const QModelIndex& index, int role) const override;
        Q_INVOKABLE void removeFile (int first, int last);
        Q_INVOKABLE void insertFiles (QList<QUrl> urls);
        QStringList getList();
    private:
        QStringList list;
};