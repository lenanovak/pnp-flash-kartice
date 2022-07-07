import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window

Dialog {
    id: quizConfirmEndDialog
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
    width: 400
    title: qsTr(" Želite li zaustaviti testiranje? ")

    onAccepted: {
        quizFinishDialog.visible = true
    }
    onRejected: {
        quizConfirmEndDialog.close()
    }
}
