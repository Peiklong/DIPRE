-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2019-10-18 12:52:53
-- 服务器版本： 10.1.9-MariaDB
-- PHP Version: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dipre`
--

-- --------------------------------------------------------

--
-- 表的结构 `patterns`
--

CREATE TABLE `patterns` (
  `id` int(11) NOT NULL,
  `order_p` tinyint(1) NOT NULL,
  `urlprefix` varchar(1024) NOT NULL,
  `prefix` varchar(255) NOT NULL,
  `middle` varchar(1024) NOT NULL,
  `suffix` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `patterns`
--

INSERT INTO `patterns` (`id`, `order_p`, `urlprefix`, `prefix`, `middle`, `suffix`) VALUES
(1, 1, 'www.books.com', ' writer', 'wrote', 'book'),
(2, 1, 'www.books.com', 'writer', 'wrote', 'book');

-- --------------------------------------------------------

--
-- 表的结构 `seeds`
--

CREATE TABLE `seeds` (
  `id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `seeds`
--

INSERT INTO `seeds` (`id`, `author`, `title`) VALUES
(16, 'Ernest Miller Hemingway', 'The ''Old'' "Man" and\\'' the Sea'),
(17, 'W. William Shakespeare', 'A Midsummer Night''s Dream'),
(20, 'Jonathan Swift', 'GULLIVERâS TRAVELS'),
(21, 'Charles Dickens', 'Pickwick Papers'),
(22, 'Nicholas Sparks', 'The Last Song'),
(23, 'Charles Dickens', 'Great Expectations'),
(27, 'Adams, Richard', 'Plague Dogs'),
(28, 'Barry, John, Shepherd, Nigel', 'Rock Climbing (Adventure Sports)'),
(29, 'David Hays, Daniel Hays', 'My Old Man and the Sea: A Father and Son Sail Around Cape Horn'),
(33, '林清玄', '在这坚硬的世界里,修得一颗柔软心'),
(43, '兰陵笑笑生', '金瓶梅(全两册)(崇祯版)(简体横排、无批评)'),
(46, '余华', '余华：我们生活在巨大的差距里'),
(47, '蒙曼', '蒙曼品最美唐诗：人生五味'),
(48, '慈怀读书会', '你最好的样子就是做自己'),
(49, '蔡崇达', '皮囊'),
(50, '蒋方舟', '东京一年'),
(51, '慈怀读书会', '把生活过成你想要的样子'),
(52, '张岱', '年轻人要熟知的4248个文化常识：夜航船(作家榜经典文库，贾平凹推荐！读过《夜航船》，灵魂才有趣！未删节插图珍藏版)大星文化出品'),
(53, '上彊村民', '宋词三百首(作家榜经典文库，马未都推荐版！直抵生活美学的源头，遇见内心向往的生活！全新未删节插图珍藏版)大星文化出品'),
(54, '鲁迅', '鲁迅自编文集（套装共21册）'),
(55, '贾平凹', '自在独行【百万册精装纪念版】'),
(56, '（美）德博拉·海登,（英）乔治·奥威尔,鲁思·本尼迪克特 等', '私家珍藏人文书库(套装共16册)'),
(57, '（日）村上春树', '假如真有时光机'),
(58, '乔瑞玲', '董卿：做一个有才情的女子'),
(59, '于谦', '玩儿'),
(60, '海子', '海子的诗'),
(61, '冯唐', '无所畏'),
(62, '[日]村上春树(著);施小炜(译)', '我的职业是小说家'),
(63, '李诞', '笑场'),
(64, 'myself', 'this`s a kind of "joke"'),
(65, 'myself', 'this`s kind of "joke"'),
(66, 'myself', 'this`s kind\\` of "joke"');

-- --------------------------------------------------------

--
-- 表的结构 `webpage`
--

CREATE TABLE `webpage` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `webpage`
--

INSERT INTO `webpage` (`id`, `url`, `text`) VALUES
(12, 'http://localhost/DIPRE/BestSeller.html', ''),
(13, 'http://localhost/DIPRE/TopRated.html', ''),
(15, '', 'http://e.dangdang.com/list-WX-dd_sale-0-1.html');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `patterns`
--
ALTER TABLE `patterns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seeds`
--
ALTER TABLE `seeds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `webpage`
--
ALTER TABLE `webpage`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `patterns`
--
ALTER TABLE `patterns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `seeds`
--
ALTER TABLE `seeds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
--
-- 使用表AUTO_INCREMENT `webpage`
--
ALTER TABLE `webpage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
