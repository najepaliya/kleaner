#pragma once

#include <QtWidgets>

class FileModel : public QAbstractListModel
{
    Q_OBJECT

    public:
        explicit FileModel (QObject* parent = nullptr);
        int rowCount (const QModelIndex& parent) const override;
        QVariant data (const QModelIndex& index, int role) const override;
        Q_INVOKABLE QString removeFile (int index);
        Q_INVOKABLE void insertFiles (QList<QUrl> urls);
        // QHash<int,QByteArray> roleNames () const override;
    private:
        QStringList list;
};