#include "backend.hpp"

Backend::Backend(QObject* parent) : QObject{parent}
{
}

void Backend::generateNumber()
{
    emit numberEmitted(2);
}