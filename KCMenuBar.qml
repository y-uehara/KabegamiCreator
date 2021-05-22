import QtQuick 2.0
import QtQuick.Controls 2.12

MenuBar {
    id: root

    Menu {
        title: qsTr("&File...")
        Action {
            text: qsTr("&Open...")
            onTriggered: { openFileDialog.open(); }
        }
        Action {
            text: qsTr("&Save...")
            onTriggered: { saveFileDialog.open(); }
        }
    }
}
