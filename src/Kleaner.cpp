#include "Kleaner.hpp"

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

int Kleaner::clearExif()
{
    int result = 0;
    if (cleaner.hasExif() && cleaner.clearExif() && cleaner.applyChanges())
    {
        result = 1;
    }
    return result;
}

int Kleaner::clearIptc()
{
    int result = 0;
    if (cleaner.hasIptc() && cleaner.clearIptc() && cleaner.applyChanges())
    {
        result = 1;
    }
    return result;
}

int Kleaner::clearXmp()
{
    int result = 0;
    if (cleaner.hasXmp() && cleaner.clearXmp() && cleaner.applyChanges())
    {
        result = 1;
    }
    return result;
}

int Kleaner::clearComments()
{
    int result = 0;
    if (cleaner.hasComments() && cleaner.clearComments() && cleaner.applyChanges())
    {
        result = 1;
    }
    return result;
}

QString Kleaner::processFiles (int index)
{
    QStringList files = m_fileModel->getList();
    int successful = 0;

    for (int i = 0; i < files.size(); i++)
    {
        if (cleaner.load(files[i]))
        {
            switch (index)
            {
                case 0:
                    successful += clearExif();
                    break;
                case 1:
                    successful += clearIptc();
                    break;
                case 2:
                    successful += clearXmp();
                    break;
                case 3:
                    successful += clearComments();
                    break;
            }
        }
    }

    QString result = QString::number(successful) + "/" + QString::number(files.size());
    return result;
}