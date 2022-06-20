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

    onAccepted: {
        flashCardModel.remove(selectedFlashCardIndex)
    }
    onRejected: flashCardDeleteDialog.close()

}
