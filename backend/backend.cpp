#include "backend.hpp"

Backend::Backend(QObject* parent) : QObject{parent}
{
}

int Backend::generateNumber()
{
    return 2;
}