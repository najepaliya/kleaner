#pragma once

#include <QtQml>
#include "file_model.hpp"

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(FileModel* fileModel READ fileModel)

    public:
        explicit Backend(QObject* parent = nullptr);
        FileModel* fileModel();
    
    private:
        FileModel* m_fileModel;
};