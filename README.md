
# Hướng dẫn
- Project hướng đến 1 quy trình khép kín cho việc mua bán xe: Đăng tin, tìm kiếm, xem chi tiết tin đăng, chi tiết và đánh giá user, liên hệ + chat qua lại giữa các user (phần cuối này chưa hoàn thiện đủ)
- Project sử dụng RealmSwift là local Storage lưu dữ liệu các tin đăng bán xe, giao diện và Firebase để lưu thông tin về tài khoản, đánh giá user
- Run Pod install trước khi chạy
## Có 5 màn hình chính: SignIn/SignUp, Trang Chủ, Thông báo, Tài Khoản, Chi tiết xe
## - 1. SignIn/SignUp
- Sigin và signup phải đủ 6 ký tự, email đúng quy tắc
- Có thể sử dụng các tài khoản đã tạo
hoa@gmail.com , 123456
dung@gmail.com , 123456
hoang@yahoo.com , 123456
duongle@gmail.com , 123456
chi@gmail.com , 123456
- Hoặc tạo tài khoản mới trong SignUp
<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136497716-12ee16a3-0f17-4c3e-b1f4-4ad54035a586.png">

## - 2. Trang Chủ
- Do tin bán xe lưu trong Realm Local nên khuyến khích người dùng sử dụng 2-3 tài khoản mỗi tài khoản tạo 1-2 tin đăng để có dữ liệu phân tích và theo dõi. Vào phần Đăng tin trong tabbar để tạo tin đăng mới 
- Phần khoảng trắng trong hình sẽ hiện các tin đăng, sau khi tạo tin có thể tìm kiếm trên search bar hoặc filter theo ý cá nhân, lưu ý phần filter chỉ làm cho 4 trường là hãng xe, loại xe, năm sản xuất và khoảng giá
<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136497197-d8e30ea8-ca52-4f82-9593-e2b708fe768d.png">

## - 3. The MainViewController
- Users information were saved from LoginViewController and RegisterViewController will be updated and shown in these following field: Name, Date of birth, Adress, Phonenumber, email
- In case User want to go back to Login, press Back Button to present LoginViewController
<img width="324" alt="main" src="https://user-images.githubusercontent.com/84574760/122742394-18f94b00-d2b0-11eb-9f0d-ebf028f51463.png">

