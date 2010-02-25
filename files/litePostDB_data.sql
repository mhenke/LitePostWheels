-- phpMyAdmin SQL Dump
-- version 2.11.8.1deb5+lenny3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 19, 2010 at 04:55 PM
-- Server version: 5.0.51
-- PHP Version: 5.2.6-1+lenny3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE IF NOT EXISTS `bookmarks` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `name`, `url`) VALUES
(1, 'Utah State University', 'http://www.usu.edu'),
(2, 'Information Technology', 'http://it.usu.edu'),
(3, 'Programming & Design', 'http://it.usu.edu/pad');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL auto_increment,
  `category` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime default NULL,
  `deletedAt` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1, 'Documentation', '2010-01-15 15:28:28', NULL, NULL),
(2, 'Community', '2010-01-15 15:28:49', '2010-02-03 09:59:52', NULL),
(3, 'Tutorials', '2010-01-15 15:29:10', NULL, NULL),
(4, 'Events', '2010-01-15 15:29:22', NULL, NULL),
(5, 'Contests', '2010-01-15 15:29:48', NULL, NULL),
(6, 'Website', '2010-01-15 15:30:07', NULL, '2010-02-03 10:00:12'),
(7, 'test', '2010-02-02 17:11:18', NULL, '2010-02-08 10:31:41'),
(8, 'Website', '2010-02-03 10:00:23', '2010-02-08 11:02:32', NULL),
(9, 'TJ rocks!', '2010-02-03 11:46:20', NULL, '2010-02-08 10:31:36'),
(10, 'Test Category', '2010-02-08 10:51:53', '2010-02-08 10:52:03', '2010-02-08 10:52:17'),
(11, 'Bogus', '2010-02-08 10:52:11', NULL, '2010-02-08 10:52:15'),
(12, 'Test Category', '2010-02-08 11:02:41', NULL, '2010-02-08 11:02:48');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL auto_increment,
  `entryid` int(11) NOT NULL,
  `comment` text NOT NULL,
  `name` varchar(80) NOT NULL,
  `email` varchar(100) default NULL,
  `url` varchar(150) default NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime default NULL,
  `deletedAt` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `comments_entryID_fk` (`entryid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `entryid`, `comment`, `name`, `email`, `url`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1, 5, 'It is going to rock! Bigtime. Test edit.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-08 12:32:27', '2010-02-17 14:19:21', NULL),
(2, 2, 'Yeah he did.', 'Scott', 'awells@gmail.com', 'http://www.usu.edu', '2010-02-08 12:44:10', NULL, NULL),
(3, 5, 'Can''t wait to go!', 'Aaron', 'awells@gmail.com', 'http://id.usu.edu', '2010-02-16 15:20:16', NULL, NULL),
(4, 5, 'testing the comment', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 13:46:23', NULL, NULL),
(5, 5, 'Yet another test comment!', 'Scott', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 13:53:30', NULL, NULL),
(6, 5, 'Testing.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 14:04:19', NULL, NULL),
(7, 5, 'Another test.', 'Scott', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 14:06:40', NULL, NULL),
(8, 2, 'Testing another comment.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 14:35:15', NULL, NULL),
(9, 2, 'Testing.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 14:36:56', NULL, NULL),
(10, 3, 'Twas epic.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 14:38:22', NULL, NULL),
(11, 4, 'Testing another comment.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 16:24:24', NULL, NULL),
(12, 4, 'Testing another comment.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 16:28:55', NULL, NULL),
(13, 6, 'No really, he really is the coolest.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 17:27:25', '2010-02-18 11:49:22', NULL),
(14, 6, 'testing another comment.', 'Aaron', 'awells@gmail.com', 'http://it.usu.edu', '2010-02-17 18:27:35', NULL, '2010-02-18 11:11:46'),
(15, 6, 'Testing', 'Aaron', NULL, NULL, '2010-02-17 18:34:20', NULL, NULL),
(16, 6, 'testing', 'Aaron', NULL, NULL, '2010-02-17 18:37:40', NULL, NULL),
(17, 6, 'test\r\n', 'Aaron', NULL, NULL, '2010-02-17 18:54:19', NULL, NULL),
(18, 5, 'Testing the date\r\n', 'Jay', NULL, NULL, '2010-02-18 11:02:37', NULL, NULL),
(19, 6, 'testing again', 'Aaron', NULL, NULL, '2010-02-18 11:08:24', NULL, NULL),
(20, 1, 'testing', 'Aaron', NULL, NULL, '2010-02-18 14:54:35', NULL, NULL),
(21, 1, 'Awesome.', 'Scott', NULL, NULL, '2010-02-18 14:56:44', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `entries`
--

CREATE TABLE IF NOT EXISTS `entries` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime default NULL,
  `deletedAt` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `entries_categoryID_fk` (`categoryid`),
  KEY `entries_userID_fk` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `entries`
--

INSERT INTO `entries` (`id`, `userid`, `categoryid`, `title`, `body`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1, 1, 2, 'TJ got pwned!', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum..', '2010-01-15 16:06:26', '2010-02-02 16:54:37', NULL),
(2, 2, 2, 'TF2 is awesome!', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2010-01-31 15:09:44', '2010-02-17 16:33:04', NULL),
(3, 2, 2, 'Fury rocked Beast!', 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ', '2010-01-31 15:11:15', '2010-02-03 10:42:00', NULL),
(4, 1, 4, 'TJ is going to GoogleIO!', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.', '2010-02-03 09:31:49', '2010-02-17 16:32:13', NULL),
(5, 1, 4, 'Aaron is going to GoogleIO!', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae...', '2010-02-08 10:36:31', '2010-02-17 16:30:18', NULL),
(6, 1, 3, 'TJ is COOL!', 'He is the coolest guy you will ever meet. And possibly the funniest. On a scale of 1-10 TJ is a 12. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2010-02-17 17:26:15', '2010-02-18 11:45:44', NULL),
(7, 1, 2, 'Just another blog post', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum..', '2010-02-19 10:55:41', NULL, NULL),
(8, 1, 2, 'Scott rocks!', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum..', '2010-02-19 10:56:03', NULL, NULL),
(9, 1, 2, 'Steph is the best!', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum..', '2010-02-19 10:58:14', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL auto_increment,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `accountname` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL default 'admin',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime default NULL,
  `deletedAt` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `accountname`, `password`, `role`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1, 'Aaron', 'Wells', 'awells@gmail.com', 'aaron', 'dc724af18fbdd4e59189f5fe768a5f8311527050', 'admin', '2010-01-15 03:37:04', '2010-02-19 15:29:48', NULL),
(2, 'Scott', 'McAllister', 'awells@gmail.com', 'Scott', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-01-15 03:57:29', '2010-01-15 04:47:57', NULL),
(3, 'Jay', 'McEntire', 'awells@gmail.com', 'JayM', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-01-15 04:42:24', '2010-01-15 14:15:40', NULL),
(6, 'Doug', 'Waite', 'awells@gmail.com', 'dougw', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-01-15 12:42:00', '2010-01-15 14:15:57', NULL),
(7, 'Chuck', 'Kimber', 'awells@gmail.com', 'chuck', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-02-03 11:27:54', '2010-02-03 11:29:15', NULL),
(10, 'Steph', 'Wilson', 'awells@gmail.com', 'steph', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-02-03 15:03:18', '2010-02-03 15:03:59', NULL),
(11, 'Robert', 'Holloway', 'awells@gmail.com', 'robert', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-02-04 16:56:02', '2010-02-04 16:57:19', NULL),
(12, 'Stacey', 'Larsen', 'awells@gmail.com', 'stacey', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '2010-02-04 16:58:00', NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`entryID`) REFERENCES `entries` (`id`);

--
-- Constraints for table `entries`
--
ALTER TABLE `entries`
  ADD CONSTRAINT `entries_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `entries_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`id`);
