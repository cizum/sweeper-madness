#include <QGuiApplication>
#include <QDebug>

#include "translator.h"

Translator::Translator(QQmlEngine* engine):
    m_language("en"),
    m_engine(engine)
{
    m_translator = new QTranslator(this);
}

void Translator::setLanguage(QString language) {
    if (language == m_language)
        return;

    if (language == QString("fr")) {
        m_translator->load("fr", ":/language");
        qApp->installTranslator(m_translator);
    } else {
        qApp->removeTranslator(m_translator);
    }

    m_language = language;
    emit languageChanged(language);
    emit upChanged("");
}

QString Translator::language() const
{
    return m_language;
}

QString Translator::up() const
{
    return "";
}
