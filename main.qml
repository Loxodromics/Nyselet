import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.15

Window {

    property string folderPath: ""
    property int indexOffset: 0

    visible: true
    width: 720
    height: 480
    title: qsTr("Nyselet")

    color: "black"

    Image {
        id: leftEye
        fillMode: Image.PreserveAspectCrop
        source: "assets:/images/leftEye.jpg"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        width: parent.width / 2
        height: parent.height
    }

    Image {
        id: rightEye
        fillMode: Image.PreserveAspectCrop
        source: "assets:/images/rightEye.jpg"

        anchors.top: parent.top
        anchors.left: leftEye.right
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        width: parent.width / 2
        height: parent.height
    }

    ListView {
        width: 200; height: 400

        FolderListModel {
            id: folderModel
            nameFilters: ["*.jpg", "*.jpeg"]

            folder: "assets:/images/"

            onFolderChanged: {
                console.log("onFolderChanged: " + folderPath + " count: " + count)
                if (count > 1) {
                    console.log("onFolderChanged > 1");
                    indexOffset = 0
                    showImages();
                }
            }
        }

        Component {
            id: fileDelegate
            Text { text: fileName }
        }

        model: folderModel
        delegate: fileDelegate
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            console.log("You chose folder: " + fileDialog.folder)
            console.log("You chose file: " + fileDialog.fileUrl)
            folderPath = decodeURIComponent(fileDialog.fileUrl)
//            folderPath = fileDialog.fileUrl;
//            folderPath = folderPath.replace(":", "/");
            folderPath = folderPath.replace(/:/g, "/");
            folderPath = folderPath.replace("///", "://");
            console.log("folder path: " + folderPath);
            folderModel.folder = folderPath
            showImages();
        }
        onRejected: {
            console.log("Canceled")
        }
//        Component.onCompleted: visible = true
    }

    Item {
        id: inpiut

        anchors.fill: parent

        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_Left) {
                console.log("move left");
                event.accepted = true;

                if (indexOffset > 1)
                    indexOffset--;
                else
                    indexOffset = folderModel.count - 2;
                showImages();
            }

            if (event.key === Qt.Key_Right) {
                if (indexOffset < folderModel.count - 2)
                    indexOffset++;
                else
                    indexOffset = 0;
            showImages();
            }

            console.log("indexOffset: " + indexOffset);
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent

            onClicked: {
//                fileDialog.visible = true
                if (indexOffset < folderModel.count - 2)
                    indexOffset++;
                else
                    indexOffset = 0;
                showImages();
            }
        }
    }

    function showImages() {
        console.log("showImages");
        leftEye.source = folderModel.get(indexOffset, "fileUrl");
        console.log("leftEye.source: " + leftEye.source);
        rightEye.source = folderModel.get(indexOffset + 1, "fileUrl");
        console.log("rightEye.source: " + rightEye.source);
//        rightEye.source = folderPath + "/0.jpeg";
    }
}
