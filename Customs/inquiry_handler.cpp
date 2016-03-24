#include "inquiry_handler.h"

inquiry_handler::inquiry_handler(QString UI_date_from, QString UI_date_before,
                                 int cri)
{
    date_from = UI_date_from;
    date_before = UI_date_before;

    //Определяем критерий!
    if (cri==0) criterion = "SUM(duty.duty_total_size)";//Пошлина.
    else if (cri == 1) criterion = "SUM(duty_and_delivery.DAD_weight)";//Вес
    else if (cri == 2) criterion = "SUM(duty_and_delivery.DAD_amount)";//Кол-во
    else criterion = "SUM(duty_and_delivery.DAD_volume)";//объём
}

//Конструктор и деструктор по-умолчанию
inquiry_handler::inquiry_handler() {}
inquiry_handler::~inquiry_handler(){}

//Проверка даты (правильность введения)
bool inquiry_handler::checkDate()
{
    QString temp;

    //Сначала проверяем: а нет ли вообще запрещённых символов?
    temp = date_from;
    date_from.replace(QRegExp("[-0123456789]"), "");
    if (date_from.length()>0) return false;
    else date_from = temp;
    temp = date_before;
    date_before.replace(QRegExp("[-0123456789]"), "");
    if (date_before.length()>0) return false;
    else date_before = temp;

    //Теперь разбиваем введённую дату и смотрим: сколько частей получилось?
    QStringList date_list_from = date_from.split('-');
    if (date_list_from.length()!=3) return false;
    QStringList date_list_before = date_before.split('-');
    if (date_list_before.length()!=3) return false;

    //Проверяем год/месяц/число отдельно.
    //Соблюдение размерностей.
    if (date_list_from[0].length()!=4) return false;
    if (date_list_from[1].length()!=2) return false;
    if (date_list_from[2].length()!=2) return false;
    if (date_list_before[0].length()!=4) return false;
    if (date_list_before[1].length()!=2) return false;
    if (date_list_before[2].length()!=2) return false;
    //Дата начала больше даты конца?
    if (date_list_from[0] > date_list_before[0]) return false;
    if (date_list_from[0] == date_list_before[0] &&
            date_list_from[1] > date_list_before[1]) return false;
    if (date_list_from[0] == date_list_before[0] &&
            date_list_from[1] == date_list_before[1] &&
                date_list_from[2] > date_list_before[2]) return false;
    //Месяц не должен быть больше 12!
    if (date_list_from[1].toInt()>12) return false;
    if (date_list_before[1].toInt()>12) return false;
    //День не должен быть больше 31!
    if (date_list_from[2].toInt()>31) return false;
    if (date_list_before[2].toInt()>31) return false;

    return true;
}

//Установка даты
void inquiry_handler::SetDates()
{
    inquiry_to_DB = "SELECT duty_and_delivery.DAD_goods_name, "
        + criterion +
        " FROM duty, duty_and_delivery, delivery\n"
        "WHERE duty.id_duty = duty_and_delivery.DAD_duty AND "
        "duty_and_delivery.DAD_delivery = delivery.id_delivery\n"
        "AND (DATE(delivery_time) BETWEEN "
            "'" + date_from + "' AND '" + date_before + "')\n"
        "GROUP BY duty_and_delivery.DAD_goods_name\n"
        "HAVING " + criterion + ">0\n"
        "ORDER BY " + criterion + " DESC\n"
        "LIMIT 10;\n";
}

//Подключение к БД
bool inquiry_handler::connect_to_DB(QString bd_name)
{
    //Подключение к БД:
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    db.setPort(3306);
    //Авторизация в БД:
    db.setUserName("root");
    db.setPassword("pass");
    db.setDatabaseName(bd_name);
    query = new QSqlQuery(db);

    if (db.open()) return true;
    else{
        QMessageBox msg_box;
        msg_box.setText("Error: "+db.lastError().text());
        msg_box.exec();
        return false;
    }
}

void inquiry_handler::sendInquiry(QString myInquiry)
{
    query->exec(myInquiry);//Отправляем указанный запрос.
}

void inquiry_handler::UpdateInquiry(QString bd, QString part, int id,int value)
{
    QString upd_Inquiry = "";

    sendInquiry("USE `" + bd + "`;\n");//Переключаемся на нужную БД

    if (part!="duty")
       upd_Inquiry = "UPDATE goods SET goods.good_" + part + " = " +
               QString::number(value) + " WHERE goods.id_good = " +
               QString::number(id) + ";";
    else upd_Inquiry = "UPDATE duty SET duty_total_size = " +
           QString::number(value) + " WHERE id_duty = " +  QString::number(id);

    sendInquiry(upd_Inquiry);//Обновляем нашу БД
}
