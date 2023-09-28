#pragma once

#include <QObject>
#include "FileModel.hpp"

class Kleaner : public QObject
{
    Q_OBJECT

    Q_PROPERTY (FileModel* fileModel READ fileModel NOTIFY fileModelChanged);

    public:
        explicit Kleaner (QObject* parent = nullptr);
        ~Kleaner() override;

        FileModel* fileModel() const;
        Q_SIGNAL void fileModelChanged();

        Q_INVOKABLE void processFiles();

    private:
        FileModel* m_fileModel;
};