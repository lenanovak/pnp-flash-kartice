import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Dialog {
    id: flashCardDialog
    modal: true
    standardButtons: DialogButtonBox.Save | DialogButtonBox.Cancel
    width: 400

    title: isNewItem() ? qsTr("Dodaj novu karticu") :qsTr("Ažuriraj postojeću karticu")

    property FlashCardModel flashCardModel
    property int selectedFlashCardIndex
    property int limitQuestion: 36
    property int limitAnswer: 56

    function isNewItem() {
        return selectedFlashCardIndex === -1
    }

    function addFlashCard() {
        flashCardModel.append({
                                  "question": flashCardQuestionTextField.text,
                                  "answer": flashCardAnswerTextField.text,
                                  "keyword": flashCardKeywordTextField.text
                              })
    }

    function changeFlashCard() {
        flashCardModel.get(selectedFlashCardIndex).question = flashCardQuestionTextField.text
        flashCardModel.get(selectedFlashCardIndex).answer = flashCardAnswerTextField.text
        flashCardModel.get(selectedFlashCardIndex).keyword = flashCardKeywordTextField.text
    }

    onAccepted: {
        isNewItem() ? addFlashCard() : changeFlashCard()
        flashCardPage.filter = false
    }
    onRejected: flashCardDialog.close()


    contentItem: ColumnLayout {
        GridLayout {
            columns: 2

            Label {
                text: qsTr("Pitanje:")
            }

            TextField {
                id: flashCardQuestionTextField
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardModel.get(selectedFlashCardIndex).question
                selectByMouse: true
                onTextChanged: if (length > limitQuestion) remove(limitQuestion, length)
            }

            Label {
                text: qsTr("Odgovor:")
            }

            TextField {
                id: flashCardAnswerTextField
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardModel.get(selectedFlashCardIndex).answer
                selectByMouse: true
                onTextChanged: if (length > limitAnswer) remove(limitAnswer, length)
            }

            Label {
                text: qsTr("Ključna riječ:")
            }

            TextField {
                id: flashCardKeywordTextField
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardModel.get(selectedFlashCardIndex).keyword
                selectByMouse: true
                onTextChanged: if (length > limitQuestion) remove(limitQuestion, length)
            }
        }
    }
}
