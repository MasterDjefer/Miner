import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.11
import QtQuick 2.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

Item
{
    anchors.centerIn: parent

    width: 200
    property int buttonHeight: 50

    ColumnLayout
    {
        anchors.fill: parent

        RowLayout
        {
            Text
            {
                text: "Field width:"
            }
            TextField
            {
                id: mapWidthField
                text: columnNumber
            }
        }

        RowLayout
        {
            Text
            {
                text: "Field height:"
            }
            TextField
            {
                id: mapHeightField
                text: rowNumber
            }
        }

        RowLayout
        {
            Text
            {
                text: "Mines count:"
            }
            TextField
            {
                id: minesCountField
                text: minesCount
            }
        }

        RowLayout
        {
            Button
            {
                id: buttonBack

                text: "<Back"
                Layout.preferredHeight: buttonHeight
                Layout.fillWidth: true

                onClicked:
                {
                    gameState.state = "GameMenu"
                }
            }

            Button
            {
                id: buttonSave

                text: "Save"
                Layout.preferredHeight: buttonHeight
                Layout.fillWidth: true

                onClicked:
                {
                    var width = parseInt(mapWidthField.text)
                    var height = parseInt(mapHeightField.text)
                    var mines= parseInt(minesCountField.text)

                    console.log(width)

                    window.setParams(width, height, mines)

                    gameState.state = "GameMenu"
                }
            }
        }
    }
}
