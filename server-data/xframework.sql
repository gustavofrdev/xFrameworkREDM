-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18-Jul-2021 às 20:58
-- Versão do servidor: 10.4.19-MariaDB
-- versão do PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `xframework`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_cartas`
--

CREATE TABLE `xframework_cartas` (
  `hash` longtext NOT NULL,
  `autorID` int(11) NOT NULL,
  `recebedorID` int(11) NOT NULL,
  `conteudo` longtext NOT NULL,
  `sql_pri` int(11) NOT NULL,
  `autorNAME` longtext DEFAULT NULL,
  `recebedorNAME` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_cartas_correspondencias`
--

CREATE TABLE `xframework_cartas_correspondencias` (
  `id` int(11) NOT NULL,
  `data` longtext NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_cavalos`
--

CREATE TABLE `xframework_cavalos` (
  `id` int(11) NOT NULL,
  `horsedata` longtext DEFAULT '[]',
  `horses` longtext NOT NULL DEFAULT '[]',
  `vehicles` longtext NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_clothestore`
--

CREATE TABLE `xframework_clothestore` (
  `owner` int(11) NOT NULL,
  `storeid` int(11) NOT NULL,
  `storedata` longtext NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_jornal`
--

CREATE TABLE `xframework_jornal` (
  `noticia_id` int(11) NOT NULL,
  `noticia_capa` longtext NOT NULL,
  `noticia_html` longtext NOT NULL DEFAULT '[]',
  `title` longtext NOT NULL,
  `noticia_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_personagens`
--

CREATE TABLE `xframework_personagens` (
  `id` int(11) NOT NULL,
  `ownerhex` text NOT NULL,
  `data` text NOT NULL DEFAULT '[]',
  `name` text NOT NULL,
  `banco` int(11) NOT NULL,
  `idade` int(11) NOT NULL,
  `RG` text NOT NULL,
  `firstname` text NOT NULL,
  `characterdata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `grupos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`grupos`)),
  `inventario` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`inventario`)),
  `house` int(11) DEFAULT NULL,
  `clothedata` longtext DEFAULT '[]',
  `armas_equipadas` longtext NOT NULL DEFAULT '[]',
  `municoes_equipadas` longtext NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `xframework_usuarios`
--

CREATE TABLE `xframework_usuarios` (
  `hexid` int(11) NOT NULL,
  `identifier` text NOT NULL,
  `whitelist` int(11) NOT NULL DEFAULT 0,
  `banido` int(11) NOT NULL DEFAULT 0,
  `VIP` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `xframework_usuarios`
--

INSERT INTO `xframework_usuarios` (`hexid`, `identifier`, `whitelist`, `banido`, `VIP`) VALUES
(5, 'steam:1100001151ff68b', 0, 0, 0),
(6, 'steam:11000011a3cdc8a', 1, 0, 0),
(7, 'steam:11000010e89a137', 1, 0, 0),
(8, 'steam:11000010f5f81f1', 1, 0, 0),
(9, 'steam:11000013f999a4e', 1, 0, 0),
(10, 'steam:11000010c1236b2', 1, 0, 0),
(11, 'steam:11000013d3da52f', 1, 0, 0),
(12, 'steam:11000013ffeea3e', 1, 0, 0),
(13, 'steam:11000010db67763', 1, 0, 0),
(14, 'steam:110000134eb4983', 1, 0, 0),
(15, 'steam:11000010a190094', 1, 0, 0),
(16, 'steam:1100001076e2b89', 1, 0, 0),
(17, 'steam:11000011988d02c', 1, 0, 1),
(18, 'steam:1100001346d2608', 1, 0, 0),
(19, 'steam:110000141b9460a', 1, 0, 0),
(20, 'steam:11000013798b5cd', 0, 0, 0),
(21, 'steam:1100001157cbdd3', 1, 0, 0),
(22, 'steam:11000013301bd08', 1, 0, 0),
(23, 'steam:11000010b66f2a3', 1, 0, 0),
(24, 'steam:11000010bfc252d', 1, 0, 0),
(25, 'steam:11000011351cb4e', 0, 0, 0),
(26, 'steam:110000117c12d79', 0, 0, 0),
(27, 'steam:11000013b3cbafd', 1, 0, 0),
(28, 'steam:11000011aa612ba', 1, 0, 0),
(29, 'steam:110000141df548d', 1, 0, 0),
(30, 'steam:11000014219ac68', 0, 0, 0),
(31, 'steam:11000013ca7e4c7', 1, 0, 0),
(32, 'steam:11000013613b2b4', 1, 0, 0),
(33, 'steam:11000010988b215', 1, 0, 0),
(34, 'steam:11000011deb1114', 1, 0, 0),
(35, 'steam:11000010c3eef50', 1, 0, 0),
(36, 'steam:11000010b266e3e', 0, 0, 0),
(37, 'steam:11000011137d9bc', 0, 0, 0),
(38, 'steam:110000107156247', 1, 0, 0),
(39, 'steam:1100001143baf8f', 0, 0, 0),
(40, 'steam:11000013e883e9a', 0, 0, 0),
(41, 'steam:1100001346da3d1', 0, 0, 0),
(42, 'steam:11000010b25cb8e', 0, 0, 0),
(43, 'steam:110000132b81375', 0, 0, 0),
(44, 'steam:110000115efaec1', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `x_fort`
--

CREATE TABLE `x_fort` (
  `fort_id` int(11) NOT NULL,
  `bando_dominou` longtext NOT NULL,
  `fort` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `x_fort`
--

INSERT INTO `x_fort` (`fort_id`, `bando_dominou`, `fort`) VALUES
(2, '[]', 'wallace');

-- --------------------------------------------------------

--
-- Estrutura da tabela `x_houses`
--

CREATE TABLE `x_houses` (
  `id` int(11) NOT NULL,
  `bau` longtext COLLATE utf8_bin NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `xframework_cartas`
--
ALTER TABLE `xframework_cartas`
  ADD PRIMARY KEY (`sql_pri`);

--
-- Índices para tabela `xframework_cartas_correspondencias`
--
ALTER TABLE `xframework_cartas_correspondencias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `xframework_cavalos`
--
ALTER TABLE `xframework_cavalos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `xframework_clothestore`
--
ALTER TABLE `xframework_clothestore`
  ADD PRIMARY KEY (`owner`);

--
-- Índices para tabela `xframework_jornal`
--
ALTER TABLE `xframework_jornal`
  ADD PRIMARY KEY (`noticia_id`);

--
-- Índices para tabela `xframework_personagens`
--
ALTER TABLE `xframework_personagens`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `xframework_usuarios`
--
ALTER TABLE `xframework_usuarios`
  ADD PRIMARY KEY (`hexid`);

--
-- Índices para tabela `x_fort`
--
ALTER TABLE `x_fort`
  ADD PRIMARY KEY (`fort_id`);

--
-- Índices para tabela `x_houses`
--
ALTER TABLE `x_houses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `xframework_cartas`
--
ALTER TABLE `xframework_cartas`
  MODIFY `sql_pri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de tabela `xframework_jornal`
--
ALTER TABLE `xframework_jornal`
  MODIFY `noticia_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `xframework_personagens`
--
ALTER TABLE `xframework_personagens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `xframework_usuarios`
--
ALTER TABLE `xframework_usuarios`
  MODIFY `hexid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `x_fort`
--
ALTER TABLE `x_fort`
  MODIFY `fort_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
