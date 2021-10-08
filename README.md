
# Hướng dẫn
- Project hướng đến 1 quy trình khép kín cho việc mua bán xe: Đăng tin, tìm kiếm, xem chi tiết tin đăng, chi tiết và đánh giá user, liên hệ + chat qua lại giữa các user (phần cuối này chưa hoàn thiện đủ)
- Project sử dụng RealmSwift là local Storage lưu dữ liệu các tin đăng bán xe, giao diện và Firebase để lưu thông tin về tài khoản, đánh giá user
- Run Pod install trước khi chạy
## Có 6 màn hình chính: SignIn/SignUp, Trang Chủ, Bán xe, Thông báo, Tài Khoản, Chi tiết xe
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
- Trang chủ khi vào chỉnh hình nền từ phần sửa thông tin tài khoản sẽ có thêm màn hình chỉnh hình nền tuỳ ý cho user và sẽ lưu vào Realm. Hình nền chỉnh dạng màu Gradient nên có màu đầu, cuối, điểm đầu cuối, alpha
<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136498485-6e2417cf-472a-4694-9811-ef2688c90d29.png">

## - 3. Đăng tin bán xe
- Chọn các thông tin để đăng bán, các trường có dấu * ko đc bỏ trống, nếu bỏ trống sẽ báo lỗi hiện màu đỏ, chọn các hãng xe hay gặp để đăng vì một số hãng chưa được up dữ liệu đầy đủ
- Phân up ảnh chỉ làm demo, do lưu ảnh trong realm khó khăn nên ảnh ko phải là ảnh lấy từ phần upload trong photos library
<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136499855-563fde2a-b594-46dc-aeab-8d3a2704c94d.png">

## - 4. Thông báo

- Khi tạo thành công tin đăng mới sẽ có thông báo hiện lên bằng 1 ô chữ màu đỏ tròn dưới tabbar, số hiện trên ô chữ ứng với số tin đăng thành công, tin đăng thành công hiện trên tableview và có chấm tròn màu xanh bên phải thể hiện thông báo chưa đc đọc, khi tap và sẽ hiển thị tin đăng và chấm tròn biến mất, thể hiện tin đã được đọc
<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136498988-f5b5ab7d-8b86-4179-b363-16040abe7336.png">

## - 5. Chi tiết tin đăng

- Tất cả chi tiết tin đăng hiện tại đây, có thể click vào ảnh để hiện full slide ảnh
- Có thể gọi điện cho ngươi bán băng nút gọi ở dưới, phần nhắn tin chưa được làm đầy đủ
- Để hiện chi tiết người bán có thể vào avatar user tại đây có thể đánh giá user bằng sao (nếu là tin đăng của mình sẽ ko tap vào avatar đc)

<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136499362-8e573dde-c6b0-43fb-9032-01c2ce63ba19.png">

## - 6. Tài khoản

- Hiện chi tiết tài khoản, có thể vào phần sửa chi tiết tài khoản để update tên, email, mật khẩu...
- Có thể chỉnh giao diện loại sáng tối (dark/light)
- Đối vơí giao diện sáng, có thêm phần chỉnh màu nền, như đề cập mục 2/ Trang chủ

<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136500486-f28370fa-d6aa-46e2-8f78-486c1bb9a8fc.png">

<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136500645-da02e82d-bb2f-41bb-bf98-7870c24edc12.png">

## - 7. Đánh giá người dùng

- Truy cập bằng cách vào từ avatar của user khác phần chi tiết tin đăng để đánh giá 1-5 sao, dữ liệu sẽ được lưu trên FireBase và ko mất đi với mọi tài khoản

<img width="324" alt="image" src="https://user-images.githubusercontent.com/84574760/136501019-d2626a71-97f0-42fe-ab0a-a3df0de2c425.png">
