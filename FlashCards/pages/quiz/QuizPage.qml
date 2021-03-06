import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
    signal stopQuiz()

    property ListModel questions
    property bool noQuestions: true
    property bool showAnswer: false
    property string question
    property string answer

    property var prevQ: Array.from({length: questions.count}, (_, index) => index)

    property int rightAnswers: 0
    property int testedQuestions: 0

    function newQuestion() {
        if (questions.count < 1) {
            noQuestions = true
            return
        }
        var randomEl = prevQ[Math.floor(Math.random() * prevQ.length)]
        let flashCard = questions.get(randomEl)
        prevQ = prevQ.filter(e => e !== randomEl)

        answer = flashCard.answer
        question = flashCard.question
        noQuestions = false
        showAnswer= false
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        Label {
            id: currentLabel
            text: noQuestions ? qsTr(" Potrebna barem jedna kartica! ") : (showAnswer ? answer : question)
            //font.pixelSize: Qt.application.font.pixelSize * (showAnswer ? 2 : 3)
            font.pixelSize: Qt.application.font.pixelSize * (showAnswer ? 3 : 2)
            Layout.maximumWidth: Window.width - 100
            wrapMode: Label.WordWrap
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            /*MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    showAnswer = !showAnswer
                    showText = showAnswer ? answer : question
                    currentLabel.textChanged(showText)
                }
            }*/
        }

        ProgressBar {
            id: progressBar
            value: noQuestions ? 0 : testedQuestions/questions.count
            Layout.fillWidth: true
            Layout.margins: 20
        }

        RowLayout {
            Button {
                id: dontKnowThisButton
                text: qsTr(" Ne znam odgovor ")
                visible: !noQuestions && !showAnswer
                //visible: !advance
                Layout.fillWidth: true
                Layout.margins: 20
                Material.background: Material.color(Material.Red, Material.Shade800)
                onClicked: {
                    showAnswer = true
                    //advance = true
                    testedQuestions = testedQuestions + 1
                }
            }

            Button {
                id: knowThisButton
                visible: !noQuestions && !showAnswer
                //visible: !advance
                text: qsTr(" Znam odgovor ")
                Layout.fillWidth: true
                Layout.margins: 20
                Material.background: Material.color(Material.Green, Material.Shade800)
                onClicked: {
                    showAnswer = true
                    //advance = true
                    testedQuestions = testedQuestions + 1
                    rightAnswers = rightAnswers + 1
                }
            }

            Button {
                id: stopQuizButton
                text: qsTr(" Zaustavi test ")
                visible: noQuestions || showAnswer
                //visible: advance
                Layout.fillWidth: true
                Layout.margins: 20
                Material.background: Material.color(Material.Red, Material.Shade800)
                onClicked: {
                    quizConfirmEndDialog.visible = true
                }
            }

            Button {
                id: newQuestionButton
                text: qsTr("Sljede??e pitanje")
                visible: !noQuestions && showAnswer
                //visible: advance
                Layout.fillWidth: true
                Layout.margins: 20
                Material.background: Material.color(Material.Green, Material.Shade800)
                onClicked: {
                    if (testedQuestions === questions.count) {
                        quizFinishDialog.visible = true
                    } else {
                        newQuestion()
                        showAnswer= false
                        //advance = false
                    }
                }
            }
        }
    }

    QuizFinishDialog {
        id: quizFinishDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
    }

    QuizConfirmEndDialog {
        id: quizConfirmEndDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
    }

}
