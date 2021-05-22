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
    property int imageWidth: kcImageCanvas.paintedWidth
    property int imageHeight: kcImageCanvas.paintedHeight

    property int clipX: 0
    property int clipY: 0
    property int clipWidth: 0
    property int clipHeight: 0

    property point dragStart: Qt.point(0, 0)

    onWidthChanged: { kcImageCanvas.maskEnable = false }
    onHeightChanged: { kcImageCanvas.maskEnable = false }

    menuBar: KCMenuBar { id: kcMenuBar }

    KCImageCanvas {
        id: kcImageCanvas

        imageParameter: app.fileUrl + "&" +
                        app.brightness + "&" +
                        app.imageWidth + "&" +
                        app.imageHeight

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: kcBrightnessSlider.top

        // drag frame
        Rectangle {
            id: dragFrame
            visible: false
            x: 100; y: 100
            width: 1; height: 1
            color: "#00000000"
            border.color: "black"
            border.width: 1
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: {
                kcImageCanvas.maskEnable = false;

                dragStart.x = mouse.x;
                dragStart.y = mouse.y;

                dragFrame.x = mouse.x;
                dragFrame.y = mouse.y;
                dragFrame.width = 1;
                dragFrame.height = 1;
                dragFrame.visible = true;
            }
            onReleased: {
                dragFrame.visible = false;

                // adjust difference of sizes between canvas and painted image
                app.clipX = Math.max(0, dragFrame.x - (kcImageCanvas.width - app.imageWidth) / 2);
                app.clipWidth = Math.min(app.imageWidth, Math.max(dragStart.x, mouse.x) - (kcImageCanvas.width - app.imageWidth) / 2) - app.clipX;
                app.clipY = Math.max(0, dragFrame.y - (kcImageCanvas.height - app.imageHeight) / 2);
                app.clipHeight = Math.min(app.imageHeight, Math.max(dragStart.y, mouse.y) - (kcImageCanvas.height - app.imageHeight) / 2) - app.clipY;

                kcImageCanvas.update();
                kcImageCanvas.maskEnable = true;
            }
            onPositionChanged: {
                if(pressed) {
                    dragFrame.x = Math.min(dragStart.x, mouse.x);
                    dragFrame.y = Math.min(dragStart.y, mouse.y);
                    dragFrame.width = Math.abs(dragStart.x - mouse.x);
                    dragFrame.height = Math.abs(dragStart.y - mouse.y);
                }
            }
        }
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
            var widthFactor =  kcImageCanvas.sourceSize.width / app.imageWidth;
            var heightFactor = kcImageCanvas.sourceSize.height / app.imageHeight;
            kcImageExporter.exportFile(saveFileDialog.fileUrl, app.clipX * widthFactor, app.clipY * heightFactor, app.clipWidth * widthFactor, app.clipHeight * heightFactor);
        }
    }
}

