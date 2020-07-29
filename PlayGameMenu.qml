import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.11
import QtQuick 2.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

RowLayout
{
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom

    property int buttonWidth: 200
    property int buttonHeight: 40

    Button
    {
        id: buttonBack

        text: "<Back"
        Layout.preferredWidth: buttonWidth
        Layout.preferredHeight: buttonHeight

        onClicked:
        {
            repeater.reset()
            gameState.state = "GameMenu"
        }
    }

    Button
    {
        id: buttonRestart

        text: "Restart"
        Layout.preferredWidth: buttonWidth
        Layout.preferredHeight: buttonHeight

        onClicked:
        {
            repeater.reset()
            gameState.state = "GamePlay"
        }
    }
}
