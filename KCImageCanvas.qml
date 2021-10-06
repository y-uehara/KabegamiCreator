import QtQuick 2.0

Image {
    id: root

    property url fileUrl: ""
    property int brightness: 100

    property string imageParameter: fileUrl + "&" + brightness + "&" + imageWidth + "&" + imageHeight
    property string maskParameter: imageWidth + "&" + imageHeight + "&" + clipX + "&" + clipY + "&" + clipWidth + "&" + clipHeight

    property bool maskEnable

    property point dragStart: Qt.point(0, 0)

    property int clipX: 0
    property int clipY: 0
    property int clipWidth: 0
    property int clipHeight: 0

    property int imageWidth: paintedWidth
    property int imageHeight: paintedHeight

    fillMode: Image.PreserveAspectFit
    source: ""

    function update() {
        source = fileUrl == "" ? "" : "image://kcImageProvider/" + imageParameter;
    }

    function setBrightness(val) {
        brightness = val;
        update();
    }

    function openFile(openUrl) {
        fileUrl = openUrl;
        update();
    }

    function exportFile(saveUrl) {
        var widthFactor =  sourceSize.width / imageWidth;
        var heightFactor = sourceSize.height / imageHeight

        kcImageExporter.exportFile(saveUrl, clipX * widthFactor, clipY * heightFactor, clipWidth * widthFactor, clipHeight * heightFactor);
    }


    Image {
        id: mask
        visible: maskEnable
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        source: fileUrl != "" && maskEnable ? "image://kcMaskProvider/" + maskParameter : ""
    }

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
            maskEnable = false;

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
            clipX = Math.max(0, dragFrame.x - (root.width - imageWidth) / 2);
            clipWidth = Math.min(imageWidth, Math.max(dragStart.x, mouse.x) - (root.width - imageWidth) / 2) - clipX;
            clipY = Math.max(0, dragFrame.y - (root.height - imageHeight) / 2);
            clipHeight = Math.min(imageHeight, Math.max(dragStart.y, mouse.y) - (root.height - imageHeight) / 2) - clipY;

            update();
            maskEnable = true;
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
