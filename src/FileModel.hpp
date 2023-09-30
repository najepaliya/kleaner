#pragma once

#include <QtWidgets>

class FileModel : public QAbstractListModel
{
    Q_OBJECT

    public:
        // required
        explicit FileModel (QObject* parent = nullptr);
        int rowCount (const QModelIndex& parent) const override;
        QVariant data (const QModelIndex& index, int role) const override;
        
        // for qml access
        Q_INVOKABLE void removeFiles (int first, int last);
        
        // interclass methods
        void insertFiles (QStringList filepaths);
        QStringList getList();
    
    private:
        QStringList list;
};