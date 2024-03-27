#pragma once

#include <QObject>

class FileModel : public QObject
{
    Q_OBJECT

    public:
        explicit FileModel(QObject* parent = nullptr);
        Q_INVOKABLE void test();
};