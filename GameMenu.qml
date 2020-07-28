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
        Button
        {
            id: buttonPlay

            text: "Play"
            Layout.preferredHeight: buttonHeight
            Layout.fillWidth: true

            onClicked:
            {
                window.isFirstClick = false
                repeater.reset()
                gameState.state = "GamePlay"
            }
        }

        Button
        {
            id: buttonSettings

            text: "Settings"
            Layout.preferredHeight: buttonHeight
            Layout.fillWidth: true

            onClicked:
            {
                gameState.state = "ConfigMenu"
            }
        }
    }
}
