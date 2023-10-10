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
    if (cleaner.hasExif() && !(cleaner.clearExif() && cleaner.applyChanges()))
    {
        result = 1;
    }
    return result;
}

int Kleaner::clearIptc()
{
    int result = 0;
    if (cleaner.hasIptc() && !(cleaner.clearIptc() && cleaner.applyChanges()))
    {
        result = 1;
    }
    return result;
}

int Kleaner::clearXmp()
{
    int result = 0;
    if (cleaner.hasXmp() && !(cleaner.clearXmp() && cleaner.applyChanges()))
    {
        result = 1;
    }
    return result;
}

int Kleaner::clearComments()
{
    int result = 0;
    if (cleaner.hasComments() && !(cleaner.clearComments() && cleaner.applyChanges()))
    {
        result = 1;
    }
    return result;
}

bool Kleaner::filterInput (QList<QUrl> urls)
{
    bool result = true;
    QStringList filepaths;
    for (int i = 0; i < urls.size(); i++)
    {
        QString filepath = urls[i].toLocalFile();
        if (cleaner.canWriteExif(filepath) || cleaner.canWriteIptc(filepath) || cleaner.canWriteXmp(filepath) || cleaner.canWriteComment(filepath))
        {
            filepaths.append(filepath);
        }
    }
    m_fileModel->insertFiles(filepaths);
    if (filepaths.size() == urls.size())
    {
        result = false;
    }
    return result;
}

QVariantMap Kleaner::processFiles (int index)
{
    QStringList files = m_fileModel->getList();
    int unknown = 0;
    int failures = 0;

    for (int i = 0; i < files.size(); i++)
    {
        if (cleaner.load(files[i]))
        {
            switch (index)
            {
                case 0:
                    failures += clearExif();
                    break;
                case 1:
                    failures += clearIptc();
                    break;
                case 2:
                    failures += clearXmp();
                    break;
                case 3:
                    failures += clearComments();
                    break;
            }
        }
        else
        {
            unknown++;
        }
    }

    QVariantMap result = {{"total", files.size()}, {"failures", failures}, {"unknown", unknown}};
    return result;

    // QString result = QString::number(files.size()) + " files with " + QString::number(failures) + " metadata clearing/saving failures and " + QString::number(unknown) + " metadata loading failures.";
    // return result;
}