import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window

import "./pages/main" as FlashCard
import "./pages/quiz" as Quiz

ApplicationWindow {
    id: window
    //maximumWidth: 700
    //minimumWidth: 700
    //maximumHeight: 500
    //minimumHeight: 500
    width: 700
    height: 500
    visible: true
    title: qsTr("Kartice za učenje")

    FlashCard.FlashCardPage {
        id: flashCardPage
        onPlayQuiz: {
            quizPage.questions = flashCardModel
            quizPage.newQuestion()
            stackView.push(quizPage)
        }
    }

    Quiz.QuizPage {
        id: quizPage
        /*onStopQuiz: {
            stackView.pop()
            //stackView.push(flashCardPage)
        }*/
    }

    StackView {
        id: stackView
        initialItem: flashCardPage
        anchors.fill: parent
    }
}
