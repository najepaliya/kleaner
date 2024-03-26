#include "backend.hpp"

Backend::Backend(QObject* parent) : QObject{parent}
{
}

void Backend::generateNumber()
{
    qDebug() << 2;
}