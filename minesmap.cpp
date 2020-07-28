#include "minesmap.h"

MinesMap::MinesMap(QObject *parent) : QObject(parent)
{
    srand(time(0));
}

Cell::eCellInfo MinesMap::minesCountAroundCell(int pos, int &count)
{
    if (pos >= mMap.size())
    {
        throw std::out_of_range("bad pos in map");
    }

    if (mMap[pos].type == Cell::Mine)
    {
        return Cell::Mine;
    }

    int index = getTopLeftCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getTopCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getTopRightCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getRightCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getBottomRightCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getBottomCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getBottomLeftCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }
    index = getLeftCellIndex(pos);
    if (index != -1)
    {
        if (getCellValue(index) == Cell::Mine) count++;
    }

    return Cell::Number;
}

void MinesMap::generateMap(int rowSize, int columnSize, int minesCount, int startCell)
{
    mRowSize = rowSize;
    mColumnSize = columnSize;
    mMinesCount = minesCount;

    mMap.clear();
    mMap.fill(Cell(), rowSize * columnSize);

    while (minesCount)
    {
        int minesPos = rand() % (rowSize * columnSize);
        if (minesPos < 0) minesPos *= -1;

        if (mMap[minesPos].type == Cell::Number)
        {
            mMap[minesPos].setMine();
            minesCount--;
        }
    }

    for (int i = 0; i < mMap.size(); ++i)
    {
        int count = 0;
        if (minesCountAroundCell(i, count) == Cell::Number)
        {
            mMap[i].value = count;
        }
    }
}

int MinesMap::getCellValue(int cellIndex)
{
    return mMap.at(cellIndex).value;
}

int MinesMap::getTopLeftCellIndex(int cellIndex)
{
    //if top exist
    if ((cellIndex - mColumnSize) >= 0)
    {
        int top = cellIndex - mColumnSize;

        //process top left exist
        if (top % mColumnSize)
        {
            int leftTop = top - 1;

            return leftTop;
        }
    }

    return -1;
}

int MinesMap::getTopCellIndex(int cellIndex)
{
    //if top exist
    if ((cellIndex - mColumnSize) >= 0)
    {
        int top = cellIndex - mColumnSize;

        return top;
    }

    return -1;
}

int MinesMap::getTopRightCellIndex(int cellIndex)
{
    //if top exist
    if ((cellIndex - mColumnSize) >= 0)
    {
        int top = cellIndex - mColumnSize;

        //process top right exist
        if ((top + 1) % mColumnSize)
        {
            int rightTop = top + 1;

            return rightTop;
        }
    }

    return -1;
}

int MinesMap::getRightCellIndex(int cellIndex)
{
    //if right exist
    if ((cellIndex + 1) % mColumnSize)
    {
        //process right
        int right = cellIndex + 1;

        return right;
    }

    return -1;
}

int MinesMap::getBottomRightCellIndex(int cellIndex)
{
    //if bottom exist
    if (cellIndex + mColumnSize < mMap.size())
    {
        int bottom = cellIndex + mColumnSize;

        //process bottom right exist
        if ((bottom + 1) % mColumnSize)
        {
            int rightBottom = bottom + 1;

            return rightBottom;
        }
    }

    return -1;
}

int MinesMap::getBottomCellIndex(int cellIndex)
{
    //if bottom exist
    if (cellIndex + mColumnSize < mMap.size())
    {
        int bottom = cellIndex + mColumnSize;

        return bottom;
    }

    return -1;
}

int MinesMap::getBottomLeftCellIndex(int cellIndex)
{
    //if bottom exist
    if (cellIndex + mColumnSize < mMap.size())
    {
        int bottom = cellIndex + mColumnSize;

        //process bottom left exist
        if (bottom % mColumnSize)
        {
            int leftBottom = bottom - 1;

            return leftBottom;
        }
    }

    return -1;
}

int MinesMap::getLeftCellIndex(int cellIndex)
{
    //if left exist
    if (cellIndex % mColumnSize)
    {
        //process left
        int left = cellIndex - 1;

        return left;
    }

    return -1;
}
