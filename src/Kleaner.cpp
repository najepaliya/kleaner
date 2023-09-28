#include "Kleaner.hpp"
#include <KExiv2/KExiv2>

Kleaner::Kleaner (QObject* parent) : QObject (parent)
{
    m_fileModel = new FileModel();
}

Kleaner::~Kleaner()
{
    delete m_fileModel;
}

FileModel* Kleaner::fileModel() const
{
    return m_fileModel;
}

QString Kleaner::processFiles()
{
    QStringList files = m_fileModel->getList();
    KExiv2Iface::KExiv2 cleaner;
    int successful = 0;
    for (int i = 0; i < files.size(); i++)
    {
        if (cleaner.load(files[i]))
        {
            if ((cleaner.hasExif() && cleaner.clearExif())
            || (cleaner.hasIptc() && cleaner.clearIptc())
            || (cleaner.hasXmp() && cleaner.clearXmp())
            || (cleaner.hasComments() && cleaner.clearComments()))
            {
                if (cleaner.applyChanges())
                {
                    successful++;
                }
            }
        }
    }
    QString result = QString::number(files.size()) + " files processed: " + QString::number(successful) + " successful and " + QString::number(files.size() - successful) + " failed";
    m_fileModel->removeFile(0, files.size());
    return result;
}