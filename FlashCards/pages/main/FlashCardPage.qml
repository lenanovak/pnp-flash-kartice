import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtQml.Models

Page {
    id: page
    signal playQuiz(FlashCardModel flashCardModel)

    property bool filter: false
    property string matchedText
    property int foundMatches: 0

    ListView {
        id: flashCardsList
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: !filter
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


    ListView {
        id: flashCardsListFiltered
        visible: filter
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 58
        anchors.bottomMargin: 54
        clip: true
        model: FlashCardModelFiltered {}
        delegate: FlashCardDelegate {
            onUpdateFlashCard: {
                flashCardDialog.selectedFlashCardIndex = flashCardsListFiltered.model.get(index).trueIndex
                flashCardDialog.visible = true
                keywordSearch.text = ""
            }
            onDeleteFlashCard: {
                flashCardDeleteDialog.selectedFlashCardIndex = flashCardsListFiltered.model.get(index).trueIndex
                flashCardDeleteDialog.visible = true
                keywordSearch.text = ""
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
        height: 46
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.leftMargin: 13
        anchors.topMargin: 6
        placeholderText: qsTr("Pretraži kartice")
        onTextChanged: {
            // CUSTOM SEARCH BAR
            if (keywordSearch.text === "" || keywordSearch.text.toLowerCase() !== matchedText) {
                filter = false
                for (var i = 0; i < flashCardsListFiltered.model.count; i++) {
                    flashCardsListFiltered.model.remove(i)
                }
            }
            for (var i = 0; i < flashCardsList.model.count; i++) {
                if ((flashCardsList.model.get(i).keyword).toLowerCase() === keywordSearch.text.toLowerCase()) {
                    matchedText = keywordSearch.text.toLowerCase()
                    filter = true
                    for (var j = 0; j < flashCardsListFiltered.model.count; j++) {
                        if (flashCardsListFiltered.model.get(j).question === flashCardsList.model.get(i).question) {
                            return
                        }
                    }
                    flashCardsListFiltered.model.append({
                                                            "question": flashCardsList.model.get(i).question,
                                                            "answer": flashCardsList.model.get(i).answer,
                                                            "keyword": flashCardsList.model.get(i).keyword,
                                                            "trueIndex": i
                                                        })
                }
            }
        }
    }
}
