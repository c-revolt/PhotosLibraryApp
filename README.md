# **PhotosLibraryApp**

Учебный проект. 

<img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_1.png" width="100"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_2.png" width="100"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_3.png" width="100"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_4.png" width="100"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_5.png" width="100"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_6.png" width="100">

Приложение загружает изображения из интернета по запросу пользователя. Использовалалась API ресурса **[Unsplash.](https://unsplash.com/developers)**

**Стэк**
- Swift 5+
- iOS 15+
- UIKit
- URLSession + URLComponents
- Верстка кодом
- Архитектура MVVM 
- SPM: [SD WebImage](https://github.com/SDWebImage/SDWebImage)


**Описание**

Приложение имеет два экрана: Галерея и Избранное. 
Экран Галерея имеет UILabel с надписью, который исчезает, когда пользователь начиниает поиск в SearchBar. Так же, в NavigationBar есть две кнопки: Поделиться и Сохранить, которые не активны и имеют серый цвет до тех пор, пока пользователь не выбирет хотя бы одно фото. На экране так же есть лейбл, который исчезает, когда там появляются первые сохраненные фото, а так же кнопка для удаления выбранных объектов.

<img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_1.png" width="400"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_2.png" width="400">

SearchBar отправляет запрос в сеть только тогда, когда пользователь полностью закончил ввод, а не при вводе каждого символа, что позволяет экономить расход трафика. Дизайн отображения ячеек CollectionView реализован с помощью сторонней библиотеки [Unsplash Photo Picker](https://github.com/unsplash/unsplash-photopicker-ios). 

Когда пользователь выбирает хотя бы одно фото, кнопки NavigationBar становятся активными и меняют цвет.

<img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_3.png" width="400"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_4.png" width="400">

Кнопка Поделиться позволяет сохранять выбранные объекты в штатном приложении Фото и отправлять другим пользователям. Кнопка Сохранить позволяет сохранять выбранные объекты на второй экран приложения: Favorites. 

<img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_5.png" width="400"><img src="https://github.com/c-revolt/PhotosLybraryApp/blob/main/PhotosLibraryApp/SupportingFiles/Screenshots/screen_6.png" width="400">


