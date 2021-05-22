import QtQuick 2.0

Image {
    id: root

    property string imageParameter
    property bool   maskEnable

    fillMode: Image.PreserveAspectFit
    source: ""

    function update() {
        root.source = app.fileUrl == "" ? "" : "image://kcImageProvider/" + imageParameter;
    }

    Image {
        id: mask
        visible: root.maskEnable
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        source: root.maskEnable ? "image://kcMaskProvider/" + app.imageWidth + "&" + app.imageHeight + "&" + app.clipX + "&" + app.clipY + "&" + app.clipWidth + "&" + app.clipHeight : ""
    }
}
