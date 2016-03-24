#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "inquiry_handler.h"

#include <QtSQL>
#include <QString>
#include <QTime>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    //Небольшая подсказка к вводимому id
    ui->criterion_id_LABEL->setToolTip(QString::fromUtf8("Для пошлины - ID "
                               "пошлины, для веса/кол-ва/объёма - ID товара"));
    gist = new QCustomPlot(this);
    ui->QVBL->addWidget(gist);

    //Подключаем наши кнопки к слотам
    connect(ui->AcceptButton, SIGNAL (released()), this,
                                            SLOT (handle_AcceptButton()));
    connect(ui->upd_button, SIGNAL (released()), this,
                                            SLOT (handle_upd_button()));
    connect(ui->show_DB, SIGNAL (released()), this,
                                            SLOT (main_show_DB()));

    //Подключаем к перерисовки наши RadioButton`ы у графика
    connect(ui->ALL_RB, SIGNAL (clicked()), this, SLOT (rewriteGist()));
    connect(ui->TOP_RB, SIGNAL (clicked()), this, SLOT (rewriteGist()));

    //Настраиваем таблицу на автоматический подгон по высоте/ширине
    ui->tw->horizontalHeader()->setResizeMode(QHeaderView::Stretch);
    ui->tw->verticalHeader()->setResizeMode(QHeaderView::Stretch);
    //Вставляем в таблицу столбцы
    for (int i=0; i<2; i++) ui->tw->insertColumn(i);
    QStringList name_table;
    name_table << QString::fromUtf8("Название товара")
               << QString::fromUtf8("Оценка по критерию");
    ui->tw->setHorizontalHeaderLabels(name_table);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::rewriteGist()
{
    MakeGist();
}

void MainWindow::main_show_DB()
{
    Show_DB *SDB = new Show_DB();

    inquiry_handler IHshow;

    //Шлём запрос для получения текущих данных!
    if(IHshow.connect_to_DB("customs_de")){//Подсоединение к БД прошло успешно
        IHshow.sendInquiry("SELECT duty_and_delivery.*, duty.duty_total_size "
                           "FROM duty_and_delivery, duty WHERE "
                           "duty_and_delivery.DAD_duty = duty.id_duty;");
    }else CallMessageBox("We can`t connect to database; "
                         "please, check that it is online.");

    //Получаем данные.
    while (IHshow.query->next()){
        SDB->addRow(); //Вставляем строки.
        for (int i=0; i<8; i++){ //Заполняем строки
                                //(считываем значения и переводим в String)

            SDB->fillRow(IHshow, i);//Заполняем строки таблицуы.
        }
    }

    SDB->fillTable(1);//Заполняем таблицу со страницы 1
    SDB->show(); //и показываем таблицу (начиная со стр. 1)
}

int MainWindow::getCriterium()
{
    if (ui->Duty_RB->isChecked()) return 0;
    else if (ui->Weight_RB->isChecked()) return 1;
    else if (ui->Amount_RB->isChecked()) return 2;
    else return 3;
}

bool MainWindow::checkToInt()
{
    QString temp;
    temp = ui->new_data_LE->text();
    temp.replace(QRegExp("[0123456789]"), "");
    if (temp.length()>0) return false;
    temp = ui->upd_ID_LE->text();
    temp.replace(QRegExp("[0123456789]"), "");
    if (temp.length()>0) return false;

    return true;
}

void MainWindow::handle_upd_button()
{
    //Часть/ID/значение
    QString part = "duty";
    int id = 1, value = 1;

    if (ui->upd_duty_RB->isChecked()) part = "duty";
    else if (ui->upd_weight_RB->isChecked()) part = "weight";
    else if (ui->upd_amount_RB->isChecked()) part = "amount";
    else part = "volume";

    if (checkToInt()){
        id = ui->upd_ID_LE->text().toInt();
        value = ui->new_data_LE->text().toInt();
        //Недопустимое значение id
        if (id < 0 || value <0 ){
            CallMessageBox("Uncorrect ID or value; please, check them.");
            return;
        }
    }else{
        CallMessageBox("Uncorrect ID or value; please, check them.");
        return;
    }

    inquiry_handler IHu;

    if(IHu.connect_to_DB("customs")){//Подсоединение к БД прошло успешно
        IHu.UpdateInquiry("customs", part, id, value);
        IHu.UpdateInquiry("customs_de", part, id, value);
    }else CallMessageBox("We can`t connect to database; "
                         "please, check that it is online.");
}

void MainWindow::handle_AcceptButton()
{
    QString date_from = "2010-01-01", date_defore = "2015-12-30";

    date_from = ui->line_date_FROM->text();
    date_defore = ui->line_date_BEFORE->text();

    //Объект обработчика запроса:
    inquiry_handler IH(date_from, date_defore, getCriterium());

    if (!IH.checkDate()){
        CallMessageBox("Bad date format. Check it, please.");
        return;
    }

    //Проверка дат (if выше) прошла успешно!
    if(IH.connect_to_DB("customs_de")){//Подсоединение к БД прошло успешно!

        //Очищаем таблицу от предыдущих данных
        ui->tw->setRowCount(0);

        //Отправляем запрос: указываем, что хотим денорм. таблицу
        IH.sendInquiry("USE `customs_de`;\n");
        IH.SetDates(); //Ставим в запрос даты.
        IH.sendInquiry(IH.inquiry_to_DB);

        //Получаем данные.
        while (IH.query->next()){
            ui->tw->insertRow(ui->tw->rowCount());//Вставляем строки.
            for (int i=0; i<2; i++){ //Заполняем строки
                                    //(считываем значения и переводим в String)
                QTableWidgetItem * item =
                        new QTableWidgetItem(IH.query->value(i).toString());
                ui->tw->setItem(ui->tw->rowCount()-1,i,item);//Заполняем табл.
            }
        }

        if (ui->tw->rowCount()==0) CallMessageBox("Here NO any rows in our table");
        else MakeGist(); //Строим гистограмму.

    }else CallMessageBox("We can`t connect to database; "
                         "please, check that it is online.");
}

double MainWindow::getValueFromTable(int row_number)
{
    QTableWidgetItem *ptrToItem;
    ptrToItem = ui->tw->item(row_number, 1);
    return ptrToItem->text().toFloat();
}

void MainWindow::CallMessageBox(QString str)
{
    QMessageBox msg_box;
    msg_box.setText(str);
    msg_box.exec();
}

void MainWindow::MakeGist()
{
    if (ui->tw->rowCount()==0){
        CallMessageBox("Here NO any rows in our table");
        return;
    }

    fossil = new QCPBars(gist->xAxis, gist->yAxis);
    gist->addPlottable(fossil);

    //Крайние значения по оси ординат + сдвиг для удобства отображения
    double maxY = 12.1, minY = 0, delta = 0.1;
    maxY = getValueFromTable(0);
    minY = getValueFromTable(9);
    delta = (maxY - minY)/10;

    if (ui->ALL_RB->isChecked()){//Показываем всё
        maxY += delta;
        minY = 0;
    }else{ //оказываем только верхушку
        maxY += delta;
        minY -= delta;
    }

    // Установки цвета:
    QPen pen;
    pen.setWidthF(1.5);//Толщина контура столбца

    pen.setColor(QColor(50, 50, 100));// Цвет контура столбца
    fossil->setPen(pen);
    // Цвет самого столбца, четвертый параметр - НЕпрозрачность
    fossil->setBrush(QColor(17, 51, 153, 100));

    // Установки значений оси X:
    QVector<double> ticks;
    QVector<QString> labels;
    gist->xAxis->setLabel(QString::fromUtf8("Номер товара"));
    ticks << 1 << 2 << 3 << 4 << 5 << 6 << 7 << 8 << 9 << 10;
    labels <<"1"<<"2"<< "3" << "4" << "5" << "6" << "7" << "8" << "9" << "10";
    gist->xAxis->setAutoTicks(false);
    gist->xAxis->setAutoTickLabels(true);
    gist->xAxis->setTickVector(ticks);
    gist->xAxis->setTickVectorLabels(labels);
    gist->xAxis->setRange(0, 10.7); //Чтобы был виден последний столбец
    gist->xAxis->setSubTickCount(0);
    gist->xAxis->setTickLength(0, 4);
    gist->xAxis->grid()->setVisible(true);

    // Установки значений оси Y:
    gist->yAxis->setLabel(QString::fromUtf8("Кол-во товара за указанное время"));
    gist->yAxis->setRange(minY, maxY);
    gist->yAxis->setPadding(5);
    gist->yAxis->grid()->setSubGridVisible(true);
    QPen gridPen;
    gridPen.setStyle(Qt::SolidLine);
    gridPen.setColor(QColor(0, 0, 0, 25));
    gist->yAxis->grid()->setPen(gridPen);
    gridPen.setStyle(Qt::DotLine);
    gist->yAxis->grid()->setSubGridPen(gridPen);

    // Данные:
    QVector<double> fossilData;

    //Заполнение по результатам запроса:
    for (int i=0; i<10;i++) fossilData << getValueFromTable(i);
    fossil->setData(ticks, fossilData);
    gist->replot();

    // Сброс всех установок графика:
    gist->removePlottable(fossil);
}
