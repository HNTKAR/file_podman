CREATE USER 'nextcloud_user'@'localhost' IDENTIFIED BY 'nextcloud_password';
CREATE DATABASE IF NOT EXISTS nextcloud_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES on nextcloud_db.* to 'nextcloud_user'@'localhost';
FLUSH privileges;