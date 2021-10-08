
# Hướng dẫn
- Project hướng đến 1 quy trình khép kín cho việc mua bán xe: Đăng tin, tìm kiếm, xem chi tiết tin đăng, chi tiết và đánh giá user, liên hệ + chat qua lại giữa các user (phần cuối này chưa hoàn thiện đủ)
- Project sử dụng RealmSwift là local Storage lưu dữ liệu các tin đăng bán xe, giao diện và Firebase để lưu thông tin về tài khoản, đánh giá user
## Có 5 màn hình chính: SignIn/SignUp, Trang Chủ, Thông báo, Tài Khoản, Chi tiết xe
## - 1. SignIn/SignUp
- 


<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136497197-d8e30ea8-ca52-4f82-9593-e2b708fe768d.png">

## - 2. The RegisterViewController
- Included 3 textField for inputting Users information: Phonenumber, Name, Password. Input these information and press register Button to save and present MainViewController
- In case User want to go back to Login, press Back Button to present LoginViewController

<img width="324" alt="register" src="https://user-images.githubusercontent.com/84574760/122742405-1d256880-d2b0-11eb-8783-d036d61906c1.png">

## - 3. The MainViewController
- Users information were saved from LoginViewController and RegisterViewController will be updated and shown in these following field: Name, Date of birth, Adress, Phonenumber, email
- In case User want to go back to Login, press Back Button to present LoginViewController
<img width="324" alt="main" src="https://user-images.githubusercontent.com/84574760/122742394-18f94b00-d2b0-11eb-9f0d-ebf028f51463.png">

