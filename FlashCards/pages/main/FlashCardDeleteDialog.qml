import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.LocalStorage
import "qrc:/Database.js" as JS

Dialog {
    id: flashCardDeleteDialog
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
    width: 400
    title: qsTr("Želite li obrisati karticu?")

    property FlashCardModel flashCardModel
    property int selectedFlashCardIndex: -1

    Label {
        anchors.fill: parent
        Layout.fillWidth: true
        text: qsTr("Pitanje: " + flashCardsList.model.get(selectedFlashCardIndex).question)
    }

    onAccepted: {
        JS.dbDeleteRow(JS.getID(selectedFlashCardIndex), selectedFlashCardIndex)
    }
    onRejected: {
        flashCardDeleteDialog.close()
    }

}
