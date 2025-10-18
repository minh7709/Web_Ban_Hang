# Web_Ban_Hang
![UI shop ban hang](./UI.png)
```bash
git clone https://github.com/minh7709/Web_Ban_Hang.git
cd Web_Ban_Hang
npm install
npx install express mysql2
```
# Cấu hình Server
```bash
PORT=3000
```
# Cấu hình Database
```bash
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_DATABASE=web_ban_hang_db

mysql -u root -p web_ban_hang_db < classicmodels.sql
```
# Chay Chuong trinh
```bash
npm run dev
http://localhost:3000
```