import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window

Dialog {
    id: quizFinishDialog
    modal: true
    standardButtons: DialogButtonBox.Ok
    width: 400
    title: qsTr(" TEST ZAVRŠEN! ")

    property bool noQuestions: quizPage.noQuestions
    property int rightAnswers: quizPage.rightAnswers
    property int testedQuestions: quizPage.testedQuestions
    property int totalQuestions: noQuestions ? 0: quizPage.questions.count
    property int percentage: (rightAnswers / testedQuestions*100).toFixed(2)

    contentItem: Rectangle {
        color: "transparent"
        visible: !noQuestions
        Label {
            anchors.fill: parent
            Layout.fillWidth: true
            text: qsTr("Ukupan broj dostupnih pitanja: " + totalQuestions + "\nBroj testiranih pitanja: " + testedQuestions +
                       "\nIspravno odgovorenih pitanja: " + rightAnswers + "\nTočnost: " + percentage + "%")
        }
    }

    onAccepted: {
        stackView.pop()
        quizPage.rightAnswers = 0
        quizPage.testedQuestions = 0
    }
}
