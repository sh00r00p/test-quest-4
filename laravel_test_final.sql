-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Авг 28 2016 г., 21:18
-- Версия сервера: 5.5.50-0ubuntu0.14.04.1
-- Версия PHP: 5.6.23-1+deprecated+dontuse+deb.sury.org~trusty+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `laravel_test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `activations`
--

CREATE TABLE IF NOT EXISTS `activations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `activations`
--

INSERT INTO `activations` (`id`, `user_id`, `code`, `completed`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 1, '2aHshdf7cEJjE6AOEimEfPTXCNuBRVaU', 1, '2016-08-28 10:17:49', '2016-08-28 10:17:49', '2016-08-28 10:17:49'),
(2, 2, 'RnIClDYB08ciuujvhOiBx5siWzBGZE9y', 1, '2016-08-28 10:19:44', '2016-08-28 10:19:18', '2016-08-28 10:19:44'),
(3, 3, '1DODfveDAKZJoCU2XHhuiQEgPn2moQxr', 1, '2016-08-28 10:23:24', '2016-08-28 10:23:03', '2016-08-28 10:23:24'),
(4, 4, 'TcJDySbBTXqae2auxzAd109McNqIlGD5', 1, '2016-08-28 12:54:57', '2016-08-28 12:54:37', '2016-08-28 12:54:57');

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_07_02_230147_migration_cartalyst_sentinel', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `persistences`
--

CREATE TABLE IF NOT EXISTS `persistences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `persistences_code_unique` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=38 ;

--
-- Дамп данных таблицы `persistences`
--

INSERT INTO `persistences` (`id`, `user_id`, `code`, `created_at`, `updated_at`) VALUES
(1, 1, 'YKFVnNtZ9bvnPqyy6tIfK9WfHuBP0AiC', '2016-08-28 10:18:25', '2016-08-28 10:18:25'),
(2, 2, '62qH4GO4xPxnnUZJZRVWDeQgAeBCDHWB', '2016-08-28 10:19:54', '2016-08-28 10:19:54'),
(3, 3, 'KPMDwbj2kiffj2s7Rnvb6qEFBnkDyobS', '2016-08-28 10:23:33', '2016-08-28 10:23:33'),
(4, 3, 'ltQ6B0GSZwTEG9gy6bhLOMww2XjsAFR6', '2016-08-28 10:24:06', '2016-08-28 10:24:06'),
(5, 3, 'ZxheY0n2gWYW9R1DTOdgvdBjwABXHYRW', '2016-08-28 10:24:37', '2016-08-28 10:24:37'),
(6, 1, 'MUywwjSbvXmBP9OveN7OgYG6RCMLVf9J', '2016-08-28 10:24:58', '2016-08-28 10:24:58'),
(7, 1, '4JDco9dw67oDXcuVdUOvyG99aYQNal6r', '2016-08-28 10:30:16', '2016-08-28 10:30:16'),
(8, 1, 'MpGfhn0G2fUOOzEKR5uJ4j267B9ELUcB', '2016-08-28 10:30:28', '2016-08-28 10:30:28'),
(9, 1, 'KmeA6zjc4sm2q0iv5x0W1O5eIrYclKWJ', '2016-08-28 10:33:34', '2016-08-28 10:33:34'),
(10, 1, 'S41tCRegYxSjZL6thW91Kn7GD0sTbPgI', '2016-08-28 10:34:15', '2016-08-28 10:34:15'),
(11, 1, 'hbWlfGUAFpSogKZgXIQbITpogtHWtbjz', '2016-08-28 10:38:29', '2016-08-28 10:38:29'),
(12, 1, 'VzFkb7xnUq5lvATc4J9RHg7teqMdRczT', '2016-08-28 10:40:06', '2016-08-28 10:40:06'),
(13, 2, 'nM68gOpYKG8yr7NAyOCxde2gBaD5qa1e', '2016-08-28 10:40:40', '2016-08-28 10:40:40'),
(14, 1, 'yDVS51TAa1tXzNwn571J51T1QU9Bi52H', '2016-08-28 10:41:31', '2016-08-28 10:41:31'),
(15, 1, 'jxlG0OAQm7VjJvupUiO2nlSFcpY05Fn1', '2016-08-28 10:42:05', '2016-08-28 10:42:05'),
(16, 1, '2qTsIFBHIlD6oHudlO5s0dq3AoXuh67F', '2016-08-28 10:43:44', '2016-08-28 10:43:44'),
(17, 1, 'dVw1BNLvseo1c6O7cshyCfaOLZ3iveyF', '2016-08-28 10:44:30', '2016-08-28 10:44:30'),
(18, 1, 's6gh456SB10h59Fju8OiDV5yKwmWprBt', '2016-08-28 10:44:56', '2016-08-28 10:44:56'),
(19, 1, 'PuN8JO8IGxi7s1z6gK8UHeQTVu9R4NvF', '2016-08-28 10:45:51', '2016-08-28 10:45:51'),
(20, 1, 'jAwQqVuf4ckh0lUv77CbIMQoiOedy6dV', '2016-08-28 10:52:51', '2016-08-28 10:52:51'),
(21, 1, 'wy8cjcB1p4JyqbTKHtmgo7zrD2fV4KsS', '2016-08-28 11:03:54', '2016-08-28 11:03:54'),
(22, 1, 'xNBI00QnEoyEeZyYDXhHPLsBzie3jHCJ', '2016-08-28 11:06:30', '2016-08-28 11:06:30'),
(23, 1, 'dmOPk4iAtVZuL4NnXylFpXVS9K9GbuOi', '2016-08-28 11:08:32', '2016-08-28 11:08:32'),
(24, 1, 'X0we14whtVprTYZsv6dSECHteHIZpFW8', '2016-08-28 11:08:42', '2016-08-28 11:08:42'),
(25, 1, 'i9d3UX6ldRLKAJstfRHwFar0ZWRo0SNv', '2016-08-28 11:10:06', '2016-08-28 11:10:06'),
(26, 1, 'AaU5zcrnX80vpT5LwFA3kf4XvUu35ELB', '2016-08-28 11:10:18', '2016-08-28 11:10:18'),
(27, 1, 'qj4wkQPTGVuj5934mnoBgvi3W5ikXpYd', '2016-08-28 11:18:33', '2016-08-28 11:18:33'),
(28, 1, 'UWwjzFw5TenvmAS2VoquJPysa5Nj7pUa', '2016-08-28 11:22:26', '2016-08-28 11:22:26'),
(29, 1, '6OlP4B1nQos8OQry1IJ1gI3uOv1jNEAP', '2016-08-28 11:23:39', '2016-08-28 11:23:39'),
(30, 1, '2x1sr1D5KvG3PhNIa5bz3mfFv5wdD5T5', '2016-08-28 11:30:52', '2016-08-28 11:30:52'),
(31, 1, 'bwq44QMLLkaa27PwasU99BvBKqo6Uc3Q', '2016-08-28 11:31:09', '2016-08-28 11:31:09');

-- --------------------------------------------------------

--
-- Структура таблицы `reminders`
--

CREATE TABLE IF NOT EXISTS `reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `slug`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Администратор', '{"admin":true}', '2016-08-28 10:17:49', '2016-08-28 10:17:49'),
(2, 'user', 'Пользователь', NULL, '2016-08-28 10:17:49', '2016-08-28 10:17:49'),
(3, 'banned', 'Забанен', NULL, '2016-08-28 10:17:49', '2016-08-28 10:17:49');

-- --------------------------------------------------------

--
-- Структура таблицы `role_users`
--

CREATE TABLE IF NOT EXISTS `role_users` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `role_users`
--

INSERT INTO `role_users` (`user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2016-08-28 10:17:49', '2016-08-28 10:17:49'),
(2, 2, '2016-08-28 10:19:18', '2016-08-28 10:19:18'),
(3, 2, '2016-08-28 10:23:03', '2016-08-28 10:23:03'),
(4, 2, '2016-08-28 12:54:37', '2016-08-28 12:54:37');

-- --------------------------------------------------------

--
-- Структура таблицы `throttle`
--

CREATE TABLE IF NOT EXISTS `throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `throttle`
--

INSERT INTO `throttle` (`id`, `user_id`, `type`, `ip`, `created_at`, `updated_at`) VALUES
(1, NULL, 'global', NULL, '2016-08-28 10:20:30', '2016-08-28 10:20:30'),
(2, NULL, 'ip', '127.0.0.1', '2016-08-28 10:20:30', '2016-08-28 10:20:30'),
(3, NULL, 'global', NULL, '2016-08-28 10:24:46', '2016-08-28 10:24:46'),
(4, NULL, 'ip', '127.0.0.1', '2016-08-28 10:24:46', '2016-08-28 10:24:46'),
(5, 1, 'user', NULL, '2016-08-28 10:24:46', '2016-08-28 10:24:46'),
(6, NULL, 'global', NULL, '2016-08-28 10:41:58', '2016-08-28 10:41:58'),
(7, NULL, 'ip', '127.0.0.1', '2016-08-28 10:41:58', '2016-08-28 10:41:58'),
(8, 1, 'user', NULL, '2016-08-28 10:41:58', '2016-08-28 10:41:58');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `permissions`, `last_login`, `first_name`, `last_name`, `created_at`, `updated_at`) VALUES
(1, 'admin@admin.com', '$2y$10$GK6kTmeDVpV/ke0yoidCsu.JKTXUjKhXFeU4zvPqvgKQIRfxwFbU2', NULL, '2016-08-28 14:52:55', 'Admin', NULL, '2016-08-28 10:17:49', '2016-08-28 14:52:55'),
(4, 'nicholaev@gmail.com', '$2y$10$ZN6r.XqCCJ6BsXnbsWRz0.RWBW/Z/TpQZbH/APkz.7HOhkpQ7SeOG', NULL, '2016-08-28 14:51:58', 'Alexey', NULL, '2016-08-28 12:54:37', '2016-08-28 14:51:58');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
