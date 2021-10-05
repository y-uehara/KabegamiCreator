import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: app
    width: 1280
    height: 720
    visible: true
    title: qsTr("Kabegami Creator")

    property int brightness: 100
    property url fileUrl: ""

    onWidthChanged: { kcImageCanvas.maskEnable = false }
    onHeightChanged: { kcImageCanvas.maskEnable = false }

    menuBar: KCMenuBar { id: kcMenuBar }

    KCImageCanvas {
        id: kcImageCanvas

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: kcBrightnessSlider.top
    }

    KCBrightnessSlider {
        id: kcBrightnessSlider
        height: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    FileDialog {
        id: openFileDialog

        title: "Please choose a file"
        onAccepted: {
            app.fileUrl = openFileDialog.fileUrl;
            kcImageCanvas.update();
        }
    }

    FileDialog {
        id: saveFileDialog

        selectExisting: false
        title: "Please choose a file"
        onAccepted: {
            var widthFactor =  kcImageCanvas.sourceSize.width / kcImageCanvas.imageWidth;
            var heightFactor = kcImageCanvas.sourceSize.height / kcImageCanvas.imageHeight
            kcImageExporter.exportFile(saveFileDialog.fileUrl, kcImageCanvas.clipX * widthFactor, kcImageCanvas.clipY * heightFactor, kcImageCanvas.clipWidth * widthFactor, kcImageCanvas.clipHeight * heightFactor);
        }
    }
}

