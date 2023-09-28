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

void Kleaner::processFiles()
{
    QStringList files = m_fileModel->getList();
    KExiv2Iface::KExiv2 cleaner;
    QVector<int> indexes;
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
                    indexes.append(i);
                }
            }
        }
    }
    qDebug() << indexes.size();
    int decrement = 0;
    for (int i = 0; i < indexes.size(); i++)
    {
        m_fileModel->removeFile(indexes[i] - decrement);
        decrement++;
    }
}