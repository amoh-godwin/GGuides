import QtQuick 2.10
import QtQuick.Controls 2.3

Button {
    id: ctrl
    property color hover_bg: "transparent"

    background: Rectangle {
        implicitWidth: 48
        implicitHeight: 48
        color: ctrl.hovered ? hover_bg : "transparent"
    }

}
