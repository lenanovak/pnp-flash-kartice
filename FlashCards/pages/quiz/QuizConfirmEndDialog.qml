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

    /*contentItem: Rectangle {
        color: "transparent"
        visible: !noQuestions
        Label {
            anchors.fill: parent
            Layout.fillWidth: true
            text: qsTr("Ukupan broj dostupnih pitanja: " + totalQuestions + "\nBroj testiranih pitanja: " + testedQuestions +
                       "\nIspravno odgovorenih pitanja: " + rightAnswers + "\nTočnost: " + percentage + "%")
        }
    }*/

    onAccepted: {
        quizFinishDialog.visible = true
    }
    onRejected: {
        quizConfirmEndDialog.close()
    }
}
