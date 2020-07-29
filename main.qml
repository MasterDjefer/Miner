import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.11
import QtQuick 2.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

/*
minesMap - object exported from C++
*/

Window
{
    id: window

    visible: true
    width: 640
    height: 482

    property int rowNumber: 10
    property int columnNumber: 10
    property int minesCount: 20
    property int buttonSize: 60
    property string colorFieldEnter: "#E7E2E2"
    property string colorFieldLeave: "#FFFFFF"
    property bool isFirstClick: false


    function setParams(columnN, rowN, minesC)
    {
        rowNumber = rowN
        columnNumber = columnN
        minesCount = minesC

        repeater.model = rowNumber * columnNumber
    }

    Component.onCompleted:
    {
        gameState.state = "GameMenu"
    }

    Item
    {
        id: gameState
        states:
        [
            State
            {
                name: "ConfigMenu"
                PropertyChanges { target: table; visible: false }
                PropertyChanges { target: gameOverItem; visible: false }
                PropertyChanges { target: menu; visible: false }
                PropertyChanges { target: configMenu; visible: true }
                PropertyChanges { target: playGameMenu; visible: false }
            },
            State
            {
                name: "GameMenu"
                PropertyChanges { target: table; visible: false }
                PropertyChanges { target: gameOverItem; visible: false }
                PropertyChanges { target: menu; visible: true }
                PropertyChanges { target: configMenu; visible: false }
                PropertyChanges { target: playGameMenu; visible: false }
            },
            State
            {
                name: "GamePlay"
                PropertyChanges { target: table; visible: true }
                PropertyChanges { target: gameOverItem; visible: false }
                PropertyChanges { target: menu; visible: false }
                PropertyChanges { target: configMenu; visible: false }
                PropertyChanges { target: playGameMenu; visible: true }
            },
            State
            {
                name: "GameOver"
                PropertyChanges { target: gameOverItem; visible: true }
                PropertyChanges { target: table; visible: true; enabled: false }
                PropertyChanges { target: menu; visible: false }
                PropertyChanges { target: configMenu; visible: false }
                PropertyChanges { target: playGameMenu; visible: true }
                StateChangeScript { script: gameOverItem.resetImgPos() }
            }
        ]
    }

    GameOver
    {
        id: gameOverItem

        visible: false
        z: 2
    }


    Grid
    {
        id: table

        anchors.centerIn: parent
        rows: rowNumber
        columns: columnNumber
        visible: false
        z: 1

        Repeater
        {
            id: repeater

            signal reset

            onReset:
            {
                var temp = model
                model = 0
                model = temp
            }

            model: rowNumber * columnNumber
            delegate: Cell
            {
            }

            function openAllMines()
            {
                for (var i = 0; i < model; ++i)
                {
                    itemAt(i).openMine()
                }
            }
        }
    }

    GameMenu
    {
        id: menu
    }

    ConfigMenu
    {
        id: configMenu
    }

    PlayGameMenu
    {
        id: playGameMenu
    }
}
