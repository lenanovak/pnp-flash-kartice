# pnp-flash-kartice

Project for the "Platform Independent Programming" course - University of Rijeka, Faculty of Engineering, academic year 2021/2022

The project is educational game called "Flashcards" (cro. _Kartice za učenje_).

The game consists of:  
  
1. **Main screen** - The user can search for existing cards (_Pretraži kartice_), create new cards (_Dodaj karticu_), edit (_Uredi_) or delete (_Obriši_) existing ones and choose an action to test their knowledge (_Testiraj znanje_). 
  
2. **New Card Entry Form** - The form contains 3 fields: question (_Pitanje_), answer (_Odgovor_) and keywords (_Kjučna riječ_) by which cards are searched.
  
3. **Knowledge Test Screen** - User sees randomly arranged existing question cards. The user can choose one of two actions: "I know the answer" (_Znam odgovor_) or "I don't know the answer" (_Ne znam odgovor_). Depending on the selected action, the card is added to the number of correct or incorrect answers. At the end of the test, the user can see their result.

Demo: https://drive.google.com/file/d/14W2JVZ1Q0Z1n7RtkMrlV16BOWrPK_yPa/view?usp=sharing

#### Requirements:
- Qt 6.2.4
- QtQml.Models
- QtQuick
- QtQuick.Controls
- QtQuick.Controls.Material
- QtQuick.Layouts
- QtQuick.LocalStorage
- QtQuick.Window

#### First time setup:
1. Clone the project
2. Import `FlashCard.pro` into the QtCreator
3. Run the project
4. To add init data, click on the "Options / Import questions" (_"Opcije / Uvezi pitanja"_) action and choose `init_data.json` file
5. Exported data (action "Options / Export questions" (_Opcije / Izvezi pitanja"_)) will be located on users desktop as a .json file

Created database can be found locally (for Windows): `C:\Users\username\AppData\Roaming\FlashCard\QML\OfflineStorage\Databases`

Made by: **Lena Novak**