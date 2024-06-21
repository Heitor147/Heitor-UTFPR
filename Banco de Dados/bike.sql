CREATE DATABASE  IF NOT EXISTS `bikes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bikes`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: bikes
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargos` (
  `id_cargos` int NOT NULL,
  `nome_cargos` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cargos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,'Vendedor');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_clientes` int NOT NULL,
  `nome_clientes` varchar(45) NOT NULL,
  `endereco_clientes` varchar(45) NOT NULL,
  `telefone_clientes` char(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `preferencia_clientes` varchar(45) NOT NULL,
  `historico_clientes` int NOT NULL,
  PRIMARY KEY (`id_clientes`),
  UNIQUE KEY `id_clientes_UNIQUE` (`id_clientes`),
  KEY `fk_historico_vendas_idx` (`historico_clientes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Luiza','Araruna','44997366495','Bicicletas',1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descontos`
--

DROP TABLE IF EXISTS `descontos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descontos` (
  `id_descontos` int NOT NULL,
  `porcentagem` varchar(45) NOT NULL,
  PRIMARY KEY (`id_descontos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descontos`
--

LOCK TABLES `descontos` WRITE;
/*!40000 ALTER TABLE `descontos` DISABLE KEYS */;
INSERT INTO `descontos` VALUES (1,'20');
/*!40000 ALTER TABLE `descontos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forma_pagamentos`
--

DROP TABLE IF EXISTS `forma_pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forma_pagamentos` (
  `id_forma_pagamentos` int NOT NULL,
  `nome_forma_pagamentos` varchar(45) NOT NULL,
  PRIMARY KEY (`id_forma_pagamentos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forma_pagamentos`
--

LOCK TABLES `forma_pagamentos` WRITE;
/*!40000 ALTER TABLE `forma_pagamentos` DISABLE KEYS */;
INSERT INTO `forma_pagamentos` VALUES (1,'Cartão de Crédito');
/*!40000 ALTER TABLE `forma_pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores` (
  `id_fornecedores` int NOT NULL,
  `nome_fornecedores` varchar(45) NOT NULL,
  `endereco_fornecedores` varchar(45) NOT NULL,
  `telefone_fornecedores` char(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `contato_principal` varchar(45) NOT NULL,
  `produto_fornecido` varchar(45) NOT NULL,
  PRIMARY KEY (`id_fornecedores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
INSERT INTO `fornecedores` VALUES (1,'Galeith','Peabiru','44987658438','E-mail','Bicicletas');
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `id_funcionarios` int NOT NULL,
  `nome_funcionarios` varchar(45) NOT NULL,
  `endereco_funcionarios` varchar(45) NOT NULL,
  `telefone_funcionarios` char(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `cargo` int NOT NULL,
  `salario` double NOT NULL,
  `data_contratacao` date NOT NULL,
  PRIMARY KEY (`id_funcionarios`),
  KEY `fk_cargos_idx` (`cargo`),
  CONSTRAINT `fk_cargos` FOREIGN KEY (`cargo`) REFERENCES `cargos` (`id_cargos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (1,'Rafael ','Engenheiro Beltrão','44997487456',1,500,'2024-06-16');
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id_produtos` int NOT NULL,
  `marca` varchar(45) NOT NULL,
  `modelo` varchar(45) NOT NULL,
  `preco` double NOT NULL,
  `estoque` int NOT NULL,
  `fornecedor` int NOT NULL,
  PRIMARY KEY (`id_produtos`),
  KEY `fk_fornecedor_idx` (`fornecedor`),
  CONSTRAINT `fk_fornecedor` FOREIGN KEY (`fornecedor`) REFERENCES `fornecedores` (`id_fornecedores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'BIKE','Bicicleta',40,5,1);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendas`
--

DROP TABLE IF EXISTS `vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendas` (
  `id_vendas` int NOT NULL,
  `codigo_vendas` int NOT NULL,
  `data` date NOT NULL,
  `valor_total` double NOT NULL,
  `item_vendido` int NOT NULL,
  `forma_pagamento` int NOT NULL,
  `descontos` int NOT NULL,
  `vendedor` int NOT NULL,
  `registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_vendas`),
  UNIQUE KEY `codigo_vendas_UNIQUE` (`codigo_vendas`),
  KEY `fk_funcionario_idx` (`vendedor`),
  KEY `fk_venda_idx` (`item_vendido`),
  KEY `fk_pagamento_idx` (`forma_pagamento`),
  KEY `fk_desconto_idx` (`descontos`),
  CONSTRAINT `fk_compras` FOREIGN KEY (`item_vendido`) REFERENCES `produtos` (`id_produtos`),
  CONSTRAINT `fk_desconto` FOREIGN KEY (`descontos`) REFERENCES `descontos` (`id_descontos`),
  CONSTRAINT `fk_funcionario` FOREIGN KEY (`vendedor`) REFERENCES `funcionarios` (`id_funcionarios`),
  CONSTRAINT `fk_pagamento` FOREIGN KEY (`forma_pagamento`) REFERENCES `forma_pagamentos` (`id_forma_pagamentos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendas`
--

LOCK TABLES `vendas` WRITE;
/*!40000 ALTER TABLE `vendas` DISABLE KEYS */;
INSERT INTO `vendas` VALUES (1,4578145,'2024-06-21',40,1,1,1,1,'2024-06-21 17:18:16');
/*!40000 ALTER TABLE `vendas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-21 17:26:17
