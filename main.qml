import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 720
    height: 480
    title: qsTr("Nyselet")

    color: "black"

    Image {
        id: leftEye
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/resources/leftEye.jpg"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        width: parent.width / 2
        height: parent.height
    }

    Image {
        id: rightEye
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/resources/rightEye.jpg"

        anchors.top: parent.top
        anchors.left: leftEye.right
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        width: parent.width / 2
        height: parent.height
    }
}
