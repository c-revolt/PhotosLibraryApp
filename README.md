# **PhotosLybraryApp**

Учебный проект. Приложение загружает изображения из интернета по запросу пользователя. Использовалалась API ресурса **[Unsplash.](https://unsplash.com/developers)**

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
Экран Галерея имеет UILabel с надписью, который исчезает, когда пользователь начиниает поиск в SearchBar.


Дизайн отображения ячеек CollectionView реализован с помощью библиотеки [Unsplash Photo Picker](https://github.com/unsplash/unsplash-photopicker-ios)
