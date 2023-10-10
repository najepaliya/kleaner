#pragma once

#include <QObject>
#include <KExiv2/KExiv2>
#include "FileModel.hpp"

class Kleaner : public QObject
{
    Q_OBJECT

    Q_PROPERTY (FileModel* fileModel READ fileModel NOTIFY fileModelChanged);

    public:
        // required
        explicit Kleaner (QObject* parent = nullptr);
        ~Kleaner() override;

        // property methods
        FileModel* fileModel() const;
        Q_SIGNAL void fileModelChanged();

        // invokable via qml
        Q_INVOKABLE bool filterInput (QList<QUrl> urls);
        Q_INVOKABLE QVariantMap processFiles (int index);
        
        // internal class methods
        int clearExif();
        int clearIptc();
        int clearXmp();
        int clearComments();

    private:
        FileModel* m_fileModel;
        KExiv2Iface::KExiv2 cleaner;
};