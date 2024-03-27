#include "backend.hpp"

Backend::Backend(QObject* parent)
:
    QObject{parent},
    m_fileModel(new FileModel(this))
{}

FileModel* Backend::fileModel()
{
    return this->m_fileModel;
}