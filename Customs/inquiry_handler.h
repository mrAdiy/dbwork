#ifndef INQUIRY_HANDLER_H
#define INQUIRY_HANDLER_H

#include <QString>
#include <QDebug>
#include <QtSQL>
#include <QMessageBox>

class inquiry_handler
{
public:
    inquiry_handler();
    ~inquiry_handler();
    inquiry_handler(QString UI_date_from, QString UI_date_before, int cri);

    QString inquiry_to_DB, //Наш запрос, который мы будем отсылать
                                //к базе данных.
            date_from, date_before,
            criterion; //Критерий востребованности товара.
    QSqlDatabase db;
    QSqlQuery *query;//Отправляемый к БД запрос.

    bool connect_to_DB(QString bd_name); //Подключение к БД.
    bool checkDate();//Проверка правильности введённой даты.
    void SetDates(); //Установка введённых дат.
    void sendInquiry(QString myInquiry);//Отправляем запрос.
    void UpdateInquiry(QString bd, QString part, int id, int value);
};

#endif // INQUIRY_HANDLER_H
