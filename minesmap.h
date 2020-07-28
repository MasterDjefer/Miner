#ifndef MINESMAP_H
#define MINESMAP_H

#include <QObject>
#include <QDebug>

#include <cstdlib>
#include <ctime>
#include <cmath>

class Cell
{
public:
    enum eCellInfo
    {
        Mine = -1,
        Number = 0,
        Invalid = 9
    };

    eCellInfo type;
    int value;

    Cell() : type(Number), value(0) {}
    void setMine()
    {
        type = Mine;
        value = -1;
    }
};

class MinesMap : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE void generateMap(int rowSize, int columnSize, int minesCount, int startCell);
    Q_INVOKABLE int getCellValue(int cellIndex);

    Q_INVOKABLE int getTopLeftCellIndex(int cellIndex);
    Q_INVOKABLE int getTopCellIndex(int cellIndex);
    Q_INVOKABLE int getTopRightCellIndex(int cellIndex);
    Q_INVOKABLE int getRightCellIndex(int cellIndex);
    Q_INVOKABLE int getBottomRightCellIndex(int cellIndex);
    Q_INVOKABLE int getBottomCellIndex(int cellIndex);
    Q_INVOKABLE int getBottomLeftCellIndex(int cellIndex);
    Q_INVOKABLE int getLeftCellIndex(int cellIndex);

public:
    explicit MinesMap(QObject *parent = nullptr);

private:
    Cell::eCellInfo minesCountAroundCell(int pos, int &count);
    void fillUntouchedFields(int pos);

private:
    int mRowSize;
    int mColumnSize;
    int mMinesCount;
    QVector<Cell> mMap;
    QVector<int> mUntouchedFields;
};

#endif // MINESMAP_H
