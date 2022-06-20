import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtQml.Models

Page {
    id: page
    signal playQuiz(FlashCardModel flashCardModel)

    ListView {
        id: flashCardsList
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 58
        anchors.bottomMargin: 54
        clip: true
        model: FlashCardModel {}
        delegate: FlashCardDelegate {
            onUpdateFlashCard: {
                flashCardDialog.selectedFlashCardIndex = index
                flashCardDialog.visible = true
            }
            onDeleteFlashCard: {
                flashCardDeleteDialog.selectedFlashCardIndex = index
                flashCardDeleteDialog.visible = true
            }
        }
    }

    Button {
        id: addFlashCardButton
        text: qsTr("Dodaj karticu")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 20
        leftPadding: 30
        rightPadding: 30
        onClicked: {
            flashCardDialog.selectedFlashCardIndex = -1
            flashCardDialog.visible = true
        }
    }

    Button {
        id: playFlashCardQuizButton
        text: qsTr("Testiraj znanje")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 20
        leftPadding: 30
        rightPadding: 30
        onClicked: playQuiz(flashCardsList.model)
    }

    FlashCardDialog {
        id: flashCardDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        flashCardModel: flashCardsList.model
    }

    FlashCardDeleteDialog {
        id: flashCardDeleteDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        flashCardModel: flashCardsList.model
    }

    TextField {
        id: keywordSearch
        width: 453
        height: 46
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 13
        anchors.topMargin: 6
        placeholderText: qsTr("Pretraži kartice")
        onTextChanged: {
            // TODO
        }
    }

}
