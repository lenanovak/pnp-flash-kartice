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
                maximumLength: 40
            }

            Label {
                text: qsTr("Odgovor:")
            }

            TextField {
                id: flashCardAnswerTextField
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardModel.get(selectedFlashCardIndex).answer
                maximumLength: 60
            }

            Label {
                text: qsTr("Ključna riječ:")
            }

            TextField {
                id: flashCardKeywordTextField
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardModel.get(selectedFlashCardIndex).keyword
                maximumLength: 60
            }
        }
    }
}
