#include "file_model.hpp"
#include <QtQml>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(FileModel* fileModel READ fileModel)

    public:
        explicit Backend(QObject* parent = nullptr)
            : QObject(parent)
            , m_fileModel(new FileModel())
        {}
        FileModel* fileModel()
        {
            return m_fileModel;
        }
    
    private:
        FileModel* m_fileModel;
};

#include "main.moc"