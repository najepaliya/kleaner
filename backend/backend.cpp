#include "backend.hpp"

Backend::Backend(QObject* parent)
    : QObject(parent)
    , m_fileModel(new FileModel())
{}

FileModel* Backend::fileModel()
{
    return m_fileModel;
}