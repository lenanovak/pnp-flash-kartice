import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Dialog {
    id: flashCardDuplicateDialog
    modal: true
    standardButtons: DialogButtonBox.Ok
    width: 400
    title: qsTr("Već postoji kartica istog sadržaja!")

    property FlashCardModel flashCardModel
    property int selectedFlashCardIndex: -1

    onAccepted: {
        flashCardDuplicateDialog.close()
    }

}
