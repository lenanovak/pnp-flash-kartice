import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.LocalStorage

import "./pages/main" as FlashCard
import "./pages/quiz" as Quiz
import "qrc:/Database.js" as JS

ApplicationWindow {
    id: window
    width: 700
    height: 500
    visible: true
    title: qsTr("Kartice za učenje")

    Component.onCompleted: {
        JS.dbInit()
    }

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
