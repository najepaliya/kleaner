#include "kleaner.hpp"

Kleaner::Kleaner (QObject* parent) : QObject (parent)
{
}

QString Kleaner::introductionText() const
{
    return m_introductionText;
}

void Kleaner::setIntroductionText(const QString &introductionText)
{
    m_introductionText = introductionText;
    Q_EMIT introductionTextChanged();
}