import QtQuick 2.0

Rectangle
{
    id: mineField
    width: buttonSize
    height: buttonSize
    border.width: 2
    border.color: "#C7C7C7"

    property bool isVisited: false
    signal autoOpen(int cellValue, bool shouldStop)

    onAutoOpen:
    {
        openNormalCell(cellValue, shouldStop)
    }

    Text
    {
        id: minesCountText
        anchors.centerIn: parent
        text: ""
        font.pixelSize: 40

        visible: false
    }

    Image
    {
        id: flagImg
        anchors.centerIn: parent
        source: "qrc:///images/flag.png"

        visible: false
    }
    Image
    {
        id: mineImg
        anchors.centerIn: parent
        source: "qrc:///images/mine.jpg"

        visible: false
    }
    Image
    {
        id: wrongMineImg
        anchors.centerIn: parent
        source: "qrc:///images/wrongMine.jpg"

        visible: false
    }


    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked:
        {
            mouse.button == Qt.RightButton ? onRightClicked() : onLeftClicked()
        }

        onEntered:
        {
            cursorShape = Qt.PointingHandCursor
            parent.color = colorFieldEnter
        }
        onExited:
        {
            if (!minesCountText.visible)
            {
                cursorShape = Qt.PointingHandCursor
                parent.color = colorFieldLeave
            }
        }
    }

    function onLeftClicked()
    {
        if (!flagImg.visible)
        {
            if (!isFirstClick)
            {
                minesMap.generateMap(rowNumber, columnNumber, minesCount, index);
                isFirstClick = true
            }

            var minuesCountPerCell = minesMap.getCellValue(index)

            if (minuesCountPerCell === -1)
            {
                openMineCell()
            }
            else
            {
                openNormalCell(minuesCountPerCell, false)
            }
        }
    }
    function onRightClicked()
    {
        if (!minesCountText.visible)
        {
            flagImg.visible = !flagImg.visible
        }
    }

    function openNormalCell(minuesCountPerCell, shouldStop)
    {
        if (!minuesCountPerCell)
        {
            minuesCountPerCell = ""
        }

        mineField.color = colorFieldEnter
        minesCountText.text = minuesCountPerCell
        minesCountText.visible = true
        isVisited = true

        if (minuesCountPerCell === "" && !shouldStop)
        {
            openCells()
        }
    }

    function openMineCell()
    {
        mineImg.visible = true
        repeater.openAllMines()
        gameState.state = "GameOver"
    }

    function openCells()
    {
        emitSignal(minesMap.getLeftCellIndex(index))
        emitSignal(minesMap.getTopCellIndex(index))
        emitSignal(minesMap.getRightCellIndex(index))
        emitSignal(minesMap.getBottomCellIndex(index))

        emitSignal(minesMap.getTopLeftCellIndex(index))
        emitSignal(minesMap.getTopRightCellIndex(index))
        emitSignal(minesMap.getBottomRightCellIndex(index))
        emitSignal(minesMap.getBottomLeftCellIndex(index))
    }

    function emitSignal(cellIndex)
    {
        if (cellIndex !== -1)
        {
            if (!repeater.itemAt(cellIndex).isFlagSet())
            {
                var cellValue = minesMap.getCellValue(cellIndex)

                if (cellValue !== -1)
                {
                    if (!repeater.itemAt(cellIndex).isVisited)
                        repeater.itemAt(cellIndex).autoOpen(cellValue, cellValue)
                }
            }
        }
    }

    function openMine()
    {
        if (minesMap.getCellValue(index) === -1)
        {
            if (flagImg.visible)
            {
                wrongMineImg.visible = true
            }
            else
            {
                mineImg.visible = true
            }
        }
    }

    function isFlagSet()
    {
        return flagImg.visible
    }
}
