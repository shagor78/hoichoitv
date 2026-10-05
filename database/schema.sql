-- ============================================================
-- Hoichoi IPTV - Complete MySQL Database Schema
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Create database
CREATE DATABASE IF NOT EXISTS `hoichoi_iptv`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `hoichoi_iptv`;

-- ============================================================
-- 1. roles
-- ============================================================
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(50)  NOT NULL,
  `slug`        VARCHAR(50)  NOT NULL,
  `permissions` JSON         NULL,
  `created_at`  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_roles_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 2. users
-- ============================================================
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id`                INT UNSIGNED   NOT NULL AUTO_INCREMENT,
  `uuid`              CHAR(36)       NOT NULL,
  `name`              VARCHAR(255)   NOT NULL,
  `email`             VARCHAR(255)   NOT NULL,
  `password_hash`     VARCHAR(255)   NOT NULL,
  `phone`             VARCHAR(30)    NULL DEFAULT NULL,
  `avatar`            VARCHAR(500)   NULL DEFAULT NULL,
  `role`              ENUM('user','admin','super_admin') NOT NULL DEFAULT 'user',
  `is_active`         TINYINT(1)     NOT NULL DEFAULT 1,
  `email_verified`    TINYINT(1)     NOT NULL DEFAULT 0,
  `two_factor_enabled` TINYINT(1)    NOT NULL DEFAULT 0,
  `two_factor_secret` VARCHAR(255)   NULL DEFAULT NULL,
  `last_login`        TIMESTAMP      NULL DEFAULT NULL,
  `created_at`        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_uuid` (`uuid`),
  UNIQUE KEY `uq_users_email` (`email`),
  KEY `idx_users_role` (`role`),
  KEY `idx_users_is_active` (`is_active`),
  KEY `idx_users_last_login` (`last_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 3. refresh_tokens
-- ============================================================
DROP TABLE IF EXISTS `refresh_tokens`;
CREATE TABLE `refresh_tokens` (
  `id`         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `user_id`    INT UNSIGNED  NOT NULL,
  `token`      VARCHAR(500)  NOT NULL,
  `expires_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_refresh_tokens_token` (`token`(255)),
  KEY `idx_refresh_tokens_user_id` (`user_id`),
  KEY `idx_refresh_tokens_expires_at` (`expires_at`),
  CONSTRAINT `fk_refresh_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 4. categories (self-referencing)
-- ============================================================
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id`          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(100)  NOT NULL,
  `slug`        VARCHAR(120)  NOT NULL,
  `description` TEXT          NULL,
  `icon`        VARCHAR(255)  NULL DEFAULT NULL,
  `image`       VARCHAR(500)  NULL DEFAULT NULL,
  `sort_order`  INT           NOT NULL DEFAULT 0,
  `is_active`   TINYINT(1)    NOT NULL DEFAULT 1,
  `parent_id`   INT UNSIGNED  NULL DEFAULT NULL,
  `created_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_categories_slug` (`slug`),
  KEY `idx_categories_parent_id` (`parent_id`),
  KEY `idx_categories_sort_order` (`sort_order`),
  KEY `idx_categories_is_active` (`is_active`),
  CONSTRAINT `fk_categories_parent` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 5. channels
-- ============================================================
DROP TABLE IF EXISTS `channels`;
CREATE TABLE `channels` (
  `id`            INT UNSIGNED   NOT NULL AUTO_INCREMENT,
  `uuid`          CHAR(36)       NOT NULL,
  `name`          VARCHAR(255)   NOT NULL,
  `slug`          VARCHAR(280)   NOT NULL,
  `logo`          VARCHAR(500)   NULL DEFAULT NULL,
  `banner`        VARCHAR(500)   NULL DEFAULT NULL,
  `description`   TEXT           NULL,
  `category_id`   INT UNSIGNED   NULL DEFAULT NULL,
  `language`      VARCHAR(50)    NULL DEFAULT NULL,
  `country`       VARCHAR(50)    NULL DEFAULT NULL,
  `is_premium`    TINYINT(1)     NOT NULL DEFAULT 0,
  `is_featured`   TINYINT(1)     NOT NULL DEFAULT 0,
  `is_live`       TINYINT(1)     NOT NULL DEFAULT 1,
  `is_active`     TINYINT(1)     NOT NULL DEFAULT 1,
  `is_published`  TINYINT(1)     NOT NULL DEFAULT 1,
  `epg_id`        VARCHAR(100)   NULL DEFAULT NULL,
  `channel_number` INT UNSIGNED  NULL DEFAULT NULL,
  `view_count`    BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `sort_order`    INT            NOT NULL DEFAULT 0,
  `created_at`    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_channels_uuid` (`uuid`),
  UNIQUE KEY `uq_channels_slug` (`slug`),
  KEY `idx_channels_category_id` (`category_id`),
  KEY `idx_channels_language` (`language`),
  KEY `idx_channels_country` (`country`),
  KEY `idx_channels_is_premium` (`is_premium`),
  KEY `idx_channels_is_featured` (`is_featured`),
  KEY `idx_channels_is_live` (`is_live`),
  KEY `idx_channels_is_active_published` (`is_active`, `is_published`),
  KEY `idx_channels_channel_number` (`channel_number`),
  KEY `idx_channels_sort_order` (`sort_order`),
  KEY `idx_channels_view_count` (`view_count`),
  FULLTEXT KEY `ft_channels_name` (`name`),
  CONSTRAINT `fk_channels_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 6. stream_sources
-- ============================================================
DROP TABLE IF EXISTS `stream_sources`;
CREATE TABLE `stream_sources` (
  `id`            INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `channel_id`    INT UNSIGNED  NOT NULL,
  `name`          VARCHAR(255)  NOT NULL,
  `url`           VARCHAR(1000) NOT NULL,
  `stream_type`   ENUM('m3u','m3u8','ts','mp4','rtmp','hls') NOT NULL DEFAULT 'm3u8',
  `is_primary`    TINYINT(1)    NOT NULL DEFAULT 0,
  `is_active`     TINYINT(1)    NOT NULL DEFAULT 1,
  `health_score`  TINYINT UNSIGNED NOT NULL DEFAULT 100,
  `last_checked`  TIMESTAMP     NULL DEFAULT NULL,
  `status`        ENUM('online','offline','buffering','error') NOT NULL DEFAULT 'online',
  `bitrate`       INT UNSIGNED  NULL DEFAULT NULL,
  `resolution`    VARCHAR(20)   NULL DEFAULT NULL,
  `error_count`   INT UNSIGNED  NOT NULL DEFAULT 0,
  `created_at`    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_stream_sources_channel_id` (`channel_id`),
  KEY `idx_stream_sources_is_primary` (`is_primary`),
  KEY `idx_stream_sources_status` (`status`),
  KEY `idx_stream_sources_is_active` (`is_active`),
  KEY `idx_stream_sources_health_score` (`health_score`),
  CONSTRAINT `fk_stream_sources_channel` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 7. subscriptions
-- ============================================================
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `id`            INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(100)  NOT NULL,
  `slug`          VARCHAR(120)  NOT NULL,
  `description`   TEXT          NULL,
  `price`         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `duration_days` INT UNSIGNED  NOT NULL DEFAULT 30,
  `max_devices`   INT UNSIGNED  NOT NULL DEFAULT 1,
  `features`      JSON          NULL,
  `is_active`     TINYINT(1)    NOT NULL DEFAULT 1,
  `sort_order`    INT           NOT NULL DEFAULT 0,
  `created_at`    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_subscriptions_slug` (`slug`),
  KEY `idx_subscriptions_is_active` (`is_active`),
  KEY `idx_subscriptions_sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 8. user_subscriptions
-- ============================================================
DROP TABLE IF EXISTS `user_subscriptions`;
CREATE TABLE `user_subscriptions` (
  `id`              INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `user_id`         INT UNSIGNED  NOT NULL,
  `subscription_id` INT UNSIGNED  NOT NULL,
  `status`          ENUM('active','expired','cancelled','pending') NOT NULL DEFAULT 'pending',
  `start_date`      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date`        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `auto_renew`      TINYINT(1)    NOT NULL DEFAULT 0,
  `payment_method`  VARCHAR(50)   NULL DEFAULT NULL,
  `created_at`      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_subscriptions_user_id` (`user_id`),
  KEY `idx_user_subscriptions_subscription_id` (`subscription_id`),
  KEY `idx_user_subscriptions_status` (`status`),
  KEY `idx_user_subscriptions_end_date` (`end_date`),
  KEY `idx_user_subscriptions_user_status` (`user_id`, `status`),
  CONSTRAINT `fk_user_subscriptions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_subscriptions_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 9. transactions
-- ============================================================
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id`                    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `uuid`                  CHAR(36)      NOT NULL,
  `user_id`               INT UNSIGNED  NOT NULL,
  `subscription_id`       INT UNSIGNED  NULL DEFAULT NULL,
  `user_subscription_id`  INT UNSIGNED  NULL DEFAULT NULL,
  `amount`                DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `currency`              VARCHAR(10)   NOT NULL DEFAULT 'USD',
  `payment_method`        VARCHAR(50)   NULL DEFAULT NULL,
  `payment_gateway`       VARCHAR(50)   NULL DEFAULT NULL,
  `gateway_transaction_id` VARCHAR(255) NULL DEFAULT NULL,
  `status`                ENUM('pending','completed','failed','refunded') NOT NULL DEFAULT 'pending',
  `invoice_number`        VARCHAR(50)   NULL DEFAULT NULL,
  `notes`                 TEXT          NULL,
  `metadata`              JSON          NULL,
  `created_at`            TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`            TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_transactions_uuid` (`uuid`),
  UNIQUE KEY `uq_transactions_invoice` (`invoice_number`),
  KEY `idx_transactions_user_id` (`user_id`),
  KEY `idx_transactions_subscription_id` (`subscription_id`),
  KEY `idx_transactions_user_subscription_id` (`user_subscription_id`),
  KEY `idx_transactions_status` (`status`),
  KEY `idx_transactions_created_at` (`created_at`),
  KEY `idx_transactions_gateway_id` (`gateway_transaction_id`),
  CONSTRAINT `fk_transactions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_transactions_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_transactions_user_subscription` FOREIGN KEY (`user_subscription_id`) REFERENCES `user_subscriptions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 10. favorites
-- ============================================================
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`    INT UNSIGNED NOT NULL,
  `channel_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_favorites_user_channel` (`user_id`, `channel_id`),
  KEY `idx_favorites_channel_id` (`channel_id`),
  CONSTRAINT `fk_favorites_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_favorites_channel` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 11. watch_history
-- ============================================================
DROP TABLE IF EXISTS `watch_history`;
CREATE TABLE `watch_history` (
  `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`    INT UNSIGNED NOT NULL,
  `channel_id` INT UNSIGNED NOT NULL,
  `watched_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `duration`   INT UNSIGNED NOT NULL DEFAULT 0,
  `progress`   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_watch_history_user_id` (`user_id`),
  KEY `idx_watch_history_channel_id` (`channel_id`),
  KEY `idx_watch_history_watched_at` (`watched_at`),
  KEY `idx_watch_history_user_watched` (`user_id`, `watched_at`),
  CONSTRAINT `fk_watch_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_watch_history_channel` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 12. device_sessions
-- ============================================================
DROP TABLE IF EXISTS `device_sessions`;
CREATE TABLE `device_sessions` (
  `id`          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `user_id`     INT UNSIGNED  NOT NULL,
  `device_name` VARCHAR(255)  NOT NULL,
  `device_type` VARCHAR(50)   NOT NULL DEFAULT 'unknown',
  `ip_address`  VARCHAR(45)   NOT NULL,
  `user_agent`  VARCHAR(500)  NULL DEFAULT NULL,
  `last_active` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active`   TINYINT(1)    NOT NULL DEFAULT 1,
  `created_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_device_sessions_user_id` (`user_id`),
  KEY `idx_device_sessions_is_active` (`is_active`),
  KEY `idx_device_sessions_last_active` (`last_active`),
  KEY `idx_device_sessions_user_active` (`user_id`, `is_active`),
  CONSTRAINT `fk_device_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 13. epg
-- ============================================================
DROP TABLE IF EXISTS `epg`;
CREATE TABLE `epg` (
  `id`         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `channel_id` INT UNSIGNED  NOT NULL,
  `title`      VARCHAR(500)  NOT NULL,
  `description` TEXT         NULL,
  `start_time` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time`   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `episode`    VARCHAR(255)  NULL DEFAULT NULL,
  `is_new`     TINYINT(1)    NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_epg_channel_id` (`channel_id`),
  KEY `idx_epg_start_time` (`start_time`),
  KEY `idx_epg_end_time` (`end_time`),
  KEY `idx_epg_channel_time` (`channel_id`, `start_time`, `end_time`),
  CONSTRAINT `fk_epg_channel` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 14. activity_logs
-- ============================================================
DROP TABLE IF EXISTS `activity_logs`;
CREATE TABLE `activity_logs` (
  `id`           INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `user_id`      INT UNSIGNED  NULL DEFAULT NULL,
  `action`       VARCHAR(100)  NOT NULL,
  `subject_type` VARCHAR(100)  NULL DEFAULT NULL,
  `subject_id`   INT UNSIGNED  NULL DEFAULT NULL,
  `metadata`     JSON          NULL,
  `ip_address`   VARCHAR(45)   NULL DEFAULT NULL,
  `user_agent`   VARCHAR(500)  NULL DEFAULT NULL,
  `created_at`   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_activity_logs_user_id` (`user_id`),
  KEY `idx_activity_logs_action` (`action`),
  KEY `idx_activity_logs_subject` (`subject_type`, `subject_id`),
  KEY `idx_activity_logs_created_at` (`created_at`),
  CONSTRAINT `fk_activity_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 15. settings
-- ============================================================
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id`         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `key`        VARCHAR(100)  NOT NULL,
  `value`      TEXT          NULL,
  `group_name` VARCHAR(50)   NOT NULL DEFAULT 'general',
  `type`       VARCHAR(20)   NOT NULL DEFAULT 'string',
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_settings_key` (`key`),
  KEY `idx_settings_group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 16. notifications
-- ============================================================
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id`         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `user_id`    INT UNSIGNED  NOT NULL,
  `title`      VARCHAR(255)  NOT NULL,
  `message`    TEXT          NOT NULL,
  `type`       VARCHAR(50)   NOT NULL DEFAULT 'info',
  `is_read`    TINYINT(1)    NOT NULL DEFAULT 0,
  `metadata`   JSON          NULL,
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_notifications_user_id` (`user_id`),
  KEY `idx_notifications_is_read` (`is_read`),
  KEY `idx_notifications_user_read` (`user_id`, `is_read`),
  KEY `idx_notifications_created_at` (`created_at`),
  CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- SEED DATA
-- ============================================================

-- Default roles
INSERT INTO `roles` (`name`, `slug`, `permissions`) VALUES
('Super Admin',  'super_admin', '{"all": true}'),
('Admin',        'admin',       '{"channels": true, "categories": true, "users": true, "subscriptions": true, "reports": true}'),
('User',         'user',        '{"view_channels": true, "manage_profile": true}');

-- Default admin user (password: Admin@123)
-- bcrypt hash for Admin@123
INSERT INTO `users` (`uuid`, `name`, `email`, `password_hash`, `role`, `is_active`, `email_verified`, `created_at`) VALUES
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Super Admin', 'admin@hoichoi.com', '$2y$12$L4E0KjN8ZvQaX5x9bJ3KduR7Gp2VtY8mH6cW1eF4nA0kO9jL2sM6q', 'super_admin', 1, 1, NOW());

-- Default subscription plans
INSERT INTO `subscriptions` (`name`, `slug`, `description`, `price`, `duration_days`, `max_devices`, `features`, `is_active`, `sort_order`) VALUES
('Basic',   'basic',   'Access to standard definition streams on 1 device.',   9.99,  30, 1, '{"sd_quality": true, "hd_quality": false, "uhd_quality": false, "simultaneous_streams": 1}', 1, 1),
('Premium', 'premium', 'HD streaming on up to 2 devices simultaneously.',      19.99, 30, 2, '{"sd_quality": true, "hd_quality": true, "uhd_quality": false, "simultaneous_streams": 2}', 1, 2),
('Pro',     'pro',     'UHD streaming on up to 5 devices simultaneously.',    29.99, 30, 5, '{"sd_quality": true, "hd_quality": true, "uhd_quality": true, "simultaneous_streams": 5}', 1, 3);

-- Default categories
INSERT INTO `categories` (`name`, `slug`, `description`, `icon`, `sort_order`, `is_active`) VALUES
('Sports',       'sports',       'Live sports channels and events.',      'sports-icon',       1, 1),
('News',         'news',         'Breaking news and live news channels.',  'news-icon',         2, 1),
('Entertainment','entertainment','General entertainment channels.',       'entertainment-icon',3, 1),
('Movies',       'movies',       'Movie channels and on-demand films.',   'movies-icon',       4, 1),
('Kids',         'kids',         'Children-safe channels and cartoons.',  'kids-icon',         5, 1),
('International','international','Channels from around the world.',       'international-icon',6, 1),
('Music',        'music',        'Music videos and live concerts.',       'music-icon',        7, 1),
('Documentary',  'documentary',  'Documentary and educational content.',  'documentary-icon',  8, 1),
('Shopping',     'shopping',     'Live shopping and product channels.',   'shopping-icon',     9, 1);

-- Default settings
INSERT INTO `settings` (`key`, `value`, `group_name`, `type`) VALUES
('site_name',           'Hoichoi IPTV',       'general',  'string'),
('site_tagline',        'Watch Everything',    'general',  'string'),
('site_logo',           '/images/logo.png',    'general',  'string'),
('maintenance_mode',    '0',                   'general',  'boolean'),
('registration_enabled','1',                   'general',  'boolean'),
('max_login_attempts',  '5',                   'security', 'integer'),
('session_timeout',     '3600',                'security', 'integer'),
('default_language',    'en',                  'general',  'string'),
('timezone',            'Asia/Dhaka',          'general',  'string'),
('currency',            'USD',                 'general',  'string'),
('contact_email',       'support@hoichoi.com', 'general',  'string'),
('smtp_host',           '',                    'email',    'string'),
('smtp_port',           '587',                 'email',    'integer'),
('smtp_username',       '',                    'email',    'string'),
('smtp_password',       '',                    'email',    'string'),
('smtp_encryption',     'tls',                 'email',    'string');

SET FOREIGN_KEY_CHECKS = 1;
