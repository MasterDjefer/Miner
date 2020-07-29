import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.11
import QtQuick 2.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

Image
{
    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    source: "qrc:///images/gameOver.png"
    scale: 0.6

    Drag.active: dragArea.drag.active

    MouseArea
    {
        id: dragArea

        anchors.fill: parent
        drag.target: parent
    }

    function resetImgPos()
    {
        x = parent.width / 2 - width / 2
        y = parent.height / 2 - height / 2
    }
}




