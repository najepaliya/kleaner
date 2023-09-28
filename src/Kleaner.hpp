#pragma once

#include <QObject>
#include <KExiv2/KExiv2>
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

        Q_INVOKABLE QString processFiles (int index);
        
        int clearExif();
        int clearIptc();
        int clearXmp();
        int clearComments();

    private:
        FileModel* m_fileModel;
        KExiv2Iface::KExiv2 cleaner;
};