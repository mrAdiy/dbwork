#include "show_db.h"
#include "ui_show_db.h"

Show_DB::Show_DB(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Show_DB)
{
    rows_counter = 0;
    ui->setupUi(this);
    //Настраиваем таблицу на автоматический подгон по высоте/ширине.
    ui->Current_data_table->horizontalHeader()->
            setResizeMode(QHeaderView::Stretch);
    ui->Current_data_table->verticalHeader()->
            setResizeMode(QHeaderView::Stretch);
    for (int i=0; i<8; i++) ui->Current_data_table->insertColumn(i);
    QStringList name_table;
    name_table << QString::fromUtf8("id пошлины")
               << QString::fromUtf8("id поставки")
               << QString::fromUtf8("Название\nтовара")
               << QString::fromUtf8("Вес")
               << QString::fromUtf8("Кол-во")
               << QString::fromUtf8("Объём")
               << QString::fromUtf8("id товара")
               << QString::fromUtf8("Размер\nпошлины");
    ui->Current_data_table->setHorizontalHeaderLabels(name_table);
    ui->Current_data_table->setToolTip(QString::fromUtf8("Крайний левый "
            "столбец - это смещение на странице."));
    connect(ui->accept_page_btn, SIGNAL (clicked()), this,
            SLOT (set_displayed_page()));
}

Show_DB::~Show_DB()
{
    delete ui;
}

void Show_DB::addRow()
{
    rows_counter++;
}

void Show_DB::fillRow(inquiry_handler IHshow, int i)
{
    BD_data.push_back(IHshow.query->value(i).toString());
}

void Show_DB::fillTable(int page)
{
    int start = 0, end = 1000;
    QString total_pages = "1";

    if (page < 1) return;
    if (BD_data.size()==0) return; //Отображать нечего

    //Переводим страницу в № ячейки вектора: каждая страница - 1000 строк.
    //На каждую строку уходит по 8 записей. Каждая страница - 8000 строк.
    //Первая страница - 0->8000, вторая - 8000->16000 и т.д.
    start = (page-1)*8000;
    end = page*8000;

    total_pages = QString::number(rows_counter/1000);
    ui->page_number_labl->setText(QString::number(page)+"/"+total_pages);

    for (int i=start; i<end; i+=8){
        ui->Current_data_table->insertRow(ui->Current_data_table->rowCount());
        for (int j=0; j<8; j++){
            QTableWidgetItem * item =
                    new QTableWidgetItem(BD_data[i+j]);
            ui->Current_data_table->setItem(
                        ui->Current_data_table->rowCount()-1,j,item);
        }
    }
}

void Show_DB::set_displayed_page()
{
    int page = 1;
    QString temp;

    temp = ui->page_LE->text();
    temp.replace(QRegExp("[0123456789]"), "");
    if (temp.size()>0){
        QMessageBox msg_box;
        msg_box.setText("Bad input format to page number; please check it!");
        msg_box.exec();
        return;
    }else page = ui->page_LE->text().toInt();

    if (page > (rows_counter/1000)) page = rows_counter/1000;
    else if (page==0) page = 1;
    ui->Current_data_table->clear();
    ui->Current_data_table->setRowCount(0);

    fillTable(page);
}
