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