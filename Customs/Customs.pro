#-------------------------------------------------
#
# Project created by QtCreator 2016-03-21T15:03:16
#
#-------------------------------------------------

QT       += core gui sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

TARGET = Customs
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    inquiry_handler.cpp \
    qcustomplot.cpp \
    show_db.cpp

HEADERS  += mainwindow.h \
    inquiry_handler.h \
    qcustomplot.h \
    show_db.h

FORMS    += mainwindow.ui \
    show_db.ui
