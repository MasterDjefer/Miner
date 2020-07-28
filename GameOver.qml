import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.11
import QtQuick 2.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

ColumnLayout
{
    Image
    {
        source: "qrc:///images/gameOver.png"
        scale: 0.6
    }
    RowLayout
    {
        Layout.alignment: Qt.AlignHCenter

        Button
        {
            id: buttonBack

            text: "<Back"

            onClicked:
            {
                repeater.reset()
                gameState.state = "GameMenu"
            }
        }

        Button
        {
            id: buttonRestart

            Layout.alignment: Qt.AlignHCenter

            text: "Restart"

            onClicked:
            {
                minesMap.generateMap(rowNumber, columnNumber, minesCount, 0)

                repeater.reset()
                gameState.state = "GamePlay"
            }
        }
    }
}

