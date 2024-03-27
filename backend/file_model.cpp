#include "file_model.hpp"
#include <iostream>

FileModel::FileModel(QObject* parent)
:
    QObject{parent}
{}

void FileModel::test()
{
    std::cout << "test\n";
}