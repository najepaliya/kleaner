#pragma once

#include <QtCore>
#include <QtGui>

class FileModel : public QAbstractListModel
{
    Q_OBJECT

    public:
        explicit FileModel(QObject* parent = nullptr);

        int rowCount(const QModelIndex& parent) const override;
        QVariant data(const QModelIndex& index, int role) const override;

        Q_INVOKABLE void addFiles(QList<QUrl> urls);
        Q_INVOKABLE void removeFile(int index);
        Q_INVOKABLE void removeAllFiles();
    
    private:
        QList<QString> fileList;
};