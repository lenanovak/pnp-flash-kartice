import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Dialog {
    id: flashCardDeleteDialog
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
    width: 400
    title: qsTr("Želite li obrisati karticu?")

    property FlashCardModel flashCardModel
    property int selectedFlashCardIndex

    Label {
        anchors.fill: parent
        Layout.fillWidth: true
        text: qsTr("Pitanje: " + flashCardModel.get(selectedFlashCardIndex).question)
    }

    onAccepted: {
        flashCardModel.remove(selectedFlashCardIndex)
        flashCardPage.filter = false
    }
    onRejected: flashCardDeleteDialog.close()

}
