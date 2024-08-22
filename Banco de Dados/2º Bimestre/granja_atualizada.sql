CREATE DATABASE  IF NOT EXISTS `granja_foda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `granja_foda`;
-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: granja_foda
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Temporary view structure for view `AgruparPorTamanhoEData`
--

DROP TABLE IF EXISTS `AgruparPorTamanhoEData`;
/*!50001 DROP VIEW IF EXISTS `AgruparPorTamanhoEData`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `AgruparPorTamanhoEData` AS SELECT 
 1 AS `tipo_ovos_id_tipo_ovos`,
 1 AS `mes`,
 1 AS `quantidade_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `AgrupePorCorEData`
--

DROP TABLE IF EXISTS `AgrupePorCorEData`;
/*!50001 DROP VIEW IF EXISTS `AgrupePorCorEData`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `AgrupePorCorEData` AS SELECT 
 1 AS `cor`,
 1 AS `id_producao`,
 1 AS `quantidade_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `AgrupePorTamanho`
--

DROP TABLE IF EXISTS `AgrupePorTamanho`;
/*!50001 DROP VIEW IF EXISTS `AgrupePorTamanho`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `AgrupePorTamanho` AS SELECT 
 1 AS `tipo_ovos_id_tipo_ovos`,
 1 AS `quantidade_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OvosDeUmTipoEmUmPeriodo`
--

DROP TABLE IF EXISTS `OvosDeUmTipoEmUmPeriodo`;
/*!50001 DROP VIEW IF EXISTS `OvosDeUmTipoEmUmPeriodo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OvosDeUmTipoEmUmPeriodo` AS SELECT 
 1 AS `data_producao`,
 1 AS `id_producao`,
 1 AS `quantidade`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `QuantoTemNoEstoqueGaraio`
--

DROP TABLE IF EXISTS `QuantoTemNoEstoqueGaraio`;
/*!50001 DROP VIEW IF EXISTS `QuantoTemNoEstoqueGaraio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `QuantoTemNoEstoqueGaraio` AS SELECT 
 1 AS `peso_total_estoque`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `QuantosOvosPorData`
--

DROP TABLE IF EXISTS `QuantosOvosPorData`;
/*!50001 DROP VIEW IF EXISTS `QuantosOvosPorData`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `QuantosOvosPorData` AS SELECT 
 1 AS `data_producao`,
 1 AS `id_producao`,
 1 AS `quantidade`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id_producao` int NOT NULL,
  `nome_produto` varchar(45) NOT NULL,
  `tipo_ovos_id_tipo_ovos` int NOT NULL,
  `quantidade` varchar(45) NOT NULL,
  `data_entrada` date NOT NULL,
  `peso_unitario` varchar(45) NOT NULL,
  `cor` varchar(45) NOT NULL,
  PRIMARY KEY (`id_producao`),
  KEY `fk_estoque_1_idx` (`tipo_ovos_id_tipo_ovos`),
  CONSTRAINT `fk_estoque_1` FOREIGN KEY (`tipo_ovos_id_tipo_ovos`) REFERENCES `tipo_ovos` (`id_tipo_ovos`),
  CONSTRAINT `fk_estoque_2` FOREIGN KEY (`id_producao`) REFERENCES `producao` (`id_producao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,'A',1,'10','2024-05-07','60','Branco'),(2,'B',3,'6','2024-05-14','50','Branco'),(3,'C',2,'8','2024-05-27','55','Branco'),(4,'D',1,'40','2024-01-15','60','Branco');
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galinha`
--

DROP TABLE IF EXISTS `galinha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `galinha` (
  `id_galinha` int NOT NULL,
  `nome_galinha` varchar(45) NOT NULL,
  PRIMARY KEY (`id_galinha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galinha`
--

LOCK TABLES `galinha` WRITE;
/*!40000 ALTER TABLE `galinha` DISABLE KEYS */;
/*!40000 ALTER TABLE `galinha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovos`
--

DROP TABLE IF EXISTS `ovos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ovos` (
  `id_ovos` int NOT NULL,
  `producao_id_producao` int NOT NULL,
  `tipo_ovos_id_tipo_ovos` int NOT NULL,
  `galinha_id_galinha` int NOT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`id_ovos`),
  KEY `fk_ovos_1_idx` (`tipo_ovos_id_tipo_ovos`),
  KEY `fk_ovos_2_idx` (`galinha_id_galinha`),
  KEY `fk_ovos_3_idx` (`producao_id_producao`),
  CONSTRAINT `fk_ovos_1` FOREIGN KEY (`tipo_ovos_id_tipo_ovos`) REFERENCES `tipo_ovos` (`id_tipo_ovos`),
  CONSTRAINT `fk_ovos_2` FOREIGN KEY (`galinha_id_galinha`) REFERENCES `galinha` (`id_galinha`),
  CONSTRAINT `fk_ovos_3` FOREIGN KEY (`producao_id_producao`) REFERENCES `producao` (`id_producao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovos`
--

LOCK TABLES `ovos` WRITE;
/*!40000 ALTER TABLE `ovos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ovos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preco`
--

DROP TABLE IF EXISTS `preco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preco` (
  `ovos_id_ovos` int NOT NULL,
  `data_preco` varchar(45) NOT NULL,
  `preco_ovo` double NOT NULL,
  PRIMARY KEY (`ovos_id_ovos`,`data_preco`),
  CONSTRAINT `fk_preço_1` FOREIGN KEY (`ovos_id_ovos`) REFERENCES `ovos` (`id_ovos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preco`
--

LOCK TABLES `preco` WRITE;
/*!40000 ALTER TABLE `preco` DISABLE KEYS */;
/*!40000 ALTER TABLE `preco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producao`
--

DROP TABLE IF EXISTS `producao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producao` (
  `id_producao` int NOT NULL,
  `data_producao` date NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id_producao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producao`
--

LOCK TABLES `producao` WRITE;
/*!40000 ALTER TABLE `producao` DISABLE KEYS */;
INSERT INTO `producao` VALUES (1,'2024-05-07',10),(2,'2024-05-14',6),(3,'2024-05-27',8),(4,'2024-01-15',40);
/*!40000 ALTER TABLE `producao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_ovos`
--

DROP TABLE IF EXISTS `tipo_ovos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_ovos` (
  `id_tipo_ovos` int NOT NULL,
  `nome_tipo_ovos` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo_ovos`),
  UNIQUE KEY `id_tipo_ovos_UNIQUE` (`id_tipo_ovos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_ovos`
--

LOCK TABLES `tipo_ovos` WRITE;
/*!40000 ALTER TABLE `tipo_ovos` DISABLE KEYS */;
INSERT INTO `tipo_ovos` VALUES (1,'Extra'),(2,'Grande'),(3,'Médio'),(4,'Pequeno');
/*!40000 ALTER TABLE `tipo_ovos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_de_medida`
--

DROP TABLE IF EXISTS `unidade_de_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_de_medida` (
  `id_unidade_de_medida` int NOT NULL,
  `nome_unidade_de_medida` varchar(45) NOT NULL,
  PRIMARY KEY (`id_unidade_de_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_de_medida`
--

LOCK TABLES `unidade_de_medida` WRITE;
/*!40000 ALTER TABLE `unidade_de_medida` DISABLE KEYS */;
INSERT INTO `unidade_de_medida` VALUES (1,'g');
/*!40000 ALTER TABLE `unidade_de_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `AgruparPorTamanhoEData`
--

/*!50001 DROP VIEW IF EXISTS `AgruparPorTamanhoEData`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AgruparPorTamanhoEData` AS select `estoque`.`tipo_ovos_id_tipo_ovos` AS `tipo_ovos_id_tipo_ovos`,date_format(`estoque`.`data_entrada`,'%Y-%m-01') AS `mes`,sum(`estoque`.`quantidade`) AS `quantidade_total` from `estoque` group by `estoque`.`tipo_ovos_id_tipo_ovos`,date_format(`estoque`.`data_entrada`,'%Y-%m-01') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AgrupePorCorEData`
--

/*!50001 DROP VIEW IF EXISTS `AgrupePorCorEData`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AgrupePorCorEData` AS select `estoque`.`cor` AS `cor`,`estoque`.`id_producao` AS `id_producao`,sum(`estoque`.`quantidade`) AS `quantidade_total` from `estoque` group by `estoque`.`cor`,`estoque`.`id_producao` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AgrupePorTamanho`
--

/*!50001 DROP VIEW IF EXISTS `AgrupePorTamanho`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AgrupePorTamanho` AS select `estoque`.`tipo_ovos_id_tipo_ovos` AS `tipo_ovos_id_tipo_ovos`,sum(`estoque`.`quantidade`) AS `quantidade_total` from `estoque` group by `estoque`.`tipo_ovos_id_tipo_ovos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OvosDeUmTipoEmUmPeriodo`
--

/*!50001 DROP VIEW IF EXISTS `OvosDeUmTipoEmUmPeriodo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `OvosDeUmTipoEmUmPeriodo` AS select `p`.`data_producao` AS `data_producao`,`p`.`id_producao` AS `id_producao`,`p`.`quantidade` AS `quantidade` from `producao` `p` where (`p`.`data_producao` between '2024-01-01' and '2024-12-31') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `QuantoTemNoEstoqueGaraio`
--

/*!50001 DROP VIEW IF EXISTS `QuantoTemNoEstoqueGaraio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `QuantoTemNoEstoqueGaraio` AS select sum((`estoque`.`quantidade` * `estoque`.`peso_unitario`)) AS `peso_total_estoque` from `estoque` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `QuantosOvosPorData`
--

/*!50001 DROP VIEW IF EXISTS `QuantosOvosPorData`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `QuantosOvosPorData` AS select `p`.`data_producao` AS `data_producao`,`p`.`id_producao` AS `id_producao`,`p`.`quantidade` AS `quantidade` from `producao` `p` where (`p`.`data_producao` = '2024-05-27') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-28  8:43:57
