CREATE DATABASE  IF NOT EXISTS `granda_twink` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `granda_twink`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: granda_twink
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Temporary view structure for view `agruparportamanhoedata`
--

DROP TABLE IF EXISTS `agruparportamanhoedata`;
/*!50001 DROP VIEW IF EXISTS `agruparportamanhoedata`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `agruparportamanhoedata` AS SELECT 
 1 AS `tipo_ovos_id_tipo_ovos`,
 1 AS `mes`,
 1 AS `quantidade_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `agrupeporcor_id_coredata`
--

DROP TABLE IF EXISTS `agrupeporcor_id_coredata`;
/*!50001 DROP VIEW IF EXISTS `agrupeporcor_id_coredata`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `agrupeporcor_id_coredata` AS SELECT 
 1 AS `cor_id_cor`,
 1 AS `id_producao`,
 1 AS `quantidade_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `agrupeportamanho`
--

DROP TABLE IF EXISTS `agrupeportamanho`;
/*!50001 DROP VIEW IF EXISTS `agrupeportamanho`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `agrupeportamanho` AS SELECT 
 1 AS `tipo_ovos_id_tipo_ovos`,
 1 AS `quantidade_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cor`
--

DROP TABLE IF EXISTS `cor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cor` (
  `id_cor` int NOT NULL,
  `nome_cor` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cor`
--

LOCK TABLES `cor` WRITE;
/*!40000 ALTER TABLE `cor` DISABLE KEYS */;
INSERT INTO `cor` VALUES (1,'Branco');
/*!40000 ALTER TABLE `cor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `despesas`
--

DROP TABLE IF EXISTS `despesas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesas` (
  `data_despesa` date NOT NULL,
  `insumos_id_insumos` int NOT NULL,
  `quantidade` varchar(45) NOT NULL,
  `valor` double NOT NULL,
  PRIMARY KEY (`data_despesa`,`insumos_id_insumos`),
  KEY `insumos_id_insumos_idx` (`insumos_id_insumos`),
  CONSTRAINT `insumos_id_insumo` FOREIGN KEY (`insumos_id_insumos`) REFERENCES `insumos` (`id_insumos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despesas`
--

LOCK TABLES `despesas` WRITE;
/*!40000 ALTER TABLE `despesas` DISABLE KEYS */;
/*!40000 ALTER TABLE `despesas` ENABLE KEYS */;
UNLOCK TABLES;

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
  `cor_id_cor` int NOT NULL,
  PRIMARY KEY (`id_producao`),
  KEY `fk_estoque_1_idx` (`tipo_ovos_id_tipo_ovos`),
  KEY `fk_estoque_3_idx` (`cor_id_cor`),
  CONSTRAINT `fk_estoque_1` FOREIGN KEY (`tipo_ovos_id_tipo_ovos`) REFERENCES `tipo_ovos` (`id_tipo_ovos`),
  CONSTRAINT `fk_estoque_2` FOREIGN KEY (`id_producao`) REFERENCES `producao` (`id_producao`),
  CONSTRAINT `fk_estoque_3` FOREIGN KEY (`cor_id_cor`) REFERENCES `cor` (`id_cor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,'A',1,'10','2024-05-07','60',1),(2,'B',3,'6','2024-05-14','50',1),(3,'C',2,'8','2024-05-27','55',1),(4,'D',1,'40','2024-01-15','60',1);
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
-- Table structure for table `gastos`
--

DROP TABLE IF EXISTS `gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gastos` (
  `insumos_id_insumos` int NOT NULL,
  `data` date NOT NULL,
  `valor_unidade` double NOT NULL,
  `quantidade` varchar(45) NOT NULL,
  `motivo` varchar(45) NOT NULL,
  PRIMARY KEY (`insumos_id_insumos`),
  CONSTRAINT `insumos_id_insumos` FOREIGN KEY (`insumos_id_insumos`) REFERENCES `insumos` (`id_insumos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gastos`
--

LOCK TABLES `gastos` WRITE;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos`
--

DROP TABLE IF EXISTS `insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insumos` (
  `id_insumos` int NOT NULL,
  `nome_insumos` varchar(45) NOT NULL,
  `unidade_de_medida_id_unidade_de_medida` int NOT NULL,
  `tipo_insumos_id_tipo_insumos` int NOT NULL,
  PRIMARY KEY (`id_insumos`),
  KEY `unidade_de_medida_id_unidade_de_medida_idx` (`unidade_de_medida_id_unidade_de_medida`),
  KEY `tipo_insumos_id_tipo_insumos_idx` (`tipo_insumos_id_tipo_insumos`),
  CONSTRAINT `tipo_insumos_id_tipo_insumos` FOREIGN KEY (`tipo_insumos_id_tipo_insumos`) REFERENCES `tipo_insumos` (`id_tipo_insumos`),
  CONSTRAINT `unidade_de_medida_id_unidade_de_medida` FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida`) REFERENCES `unidade_de_medida` (`id_unidade_de_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (0,'Ração',1,2),(1,'Água',4,2),(2,'Energia',5,2),(3,'Medicamento',4,2),(4,'Vacina',0,2),(5,'Cama',2,2),(6,'Material de ninho',0,2),(7,'Equipamento',2,1),(8,'Material de limpeza',0,2),(9,'Manutenção',0,1),(10,'Mão-de-obra',0,1);
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
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
  `cor_id_cor` int NOT NULL,
  `galinha_id_galinha` int NOT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`id_ovos`),
  KEY `fk_ovos_1_idx` (`tipo_ovos_id_tipo_ovos`),
  KEY `fk_ovos_2_idx` (`galinha_id_galinha`),
  KEY `fk_ovos_3_idx` (`producao_id_producao`),
  KEY `fk_ovos_4_idx` (`cor_id_cor`),
  CONSTRAINT `fk_ovos_1` FOREIGN KEY (`tipo_ovos_id_tipo_ovos`) REFERENCES `tipo_ovos` (`id_tipo_ovos`),
  CONSTRAINT `fk_ovos_2` FOREIGN KEY (`galinha_id_galinha`) REFERENCES `galinha` (`id_galinha`),
  CONSTRAINT `fk_ovos_3` FOREIGN KEY (`producao_id_producao`) REFERENCES `producao` (`id_producao`),
  CONSTRAINT `fk_ovos_4` FOREIGN KEY (`cor_id_cor`) REFERENCES `cor` (`id_cor`)
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
-- Temporary view structure for view `ovosdeumtipoemumperiodo`
--

DROP TABLE IF EXISTS `ovosdeumtipoemumperiodo`;
/*!50001 DROP VIEW IF EXISTS `ovosdeumtipoemumperiodo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ovosdeumtipoemumperiodo` AS SELECT 
 1 AS `data_producao`,
 1 AS `id_producao`,
 1 AS `quantidade`*/;
SET character_set_client = @saved_cs_client;

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
-- Temporary view structure for view `quantosovospordata`
--

DROP TABLE IF EXISTS `quantosovospordata`;
/*!50001 DROP VIEW IF EXISTS `quantosovospordata`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `quantosovospordata` AS SELECT 
 1 AS `data_producao`,
 1 AS `id_producao`,
 1 AS `quantidade`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `quantotemnoestoquegaraio`
--

DROP TABLE IF EXISTS `quantotemnoestoquegaraio`;
/*!50001 DROP VIEW IF EXISTS `quantotemnoestoquegaraio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `quantotemnoestoquegaraio` AS SELECT 
 1 AS `peso_total_estoque`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tipo_insumos`
--

DROP TABLE IF EXISTS `tipo_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_insumos` (
  `id_tipo_insumos` int NOT NULL,
  `nome_tipo_insumos` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo_insumos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_insumos`
--

LOCK TABLES `tipo_insumos` WRITE;
/*!40000 ALTER TABLE `tipo_insumos` DISABLE KEYS */;
INSERT INTO `tipo_insumos` VALUES (1,'Fixo'),(2,'Variável');
/*!40000 ALTER TABLE `tipo_insumos` ENABLE KEYS */;
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
INSERT INTO `unidade_de_medida` VALUES (0,'Indefinido'),(1,'g'),(2,'kg'),(3,'mL'),(4,'L'),(5,'kWh');
/*!40000 ALTER TABLE `unidade_de_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `agruparportamanhoedata`
--

/*!50001 DROP VIEW IF EXISTS `agruparportamanhoedata`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `agruparportamanhoedata` AS select `estoque`.`tipo_ovos_id_tipo_ovos` AS `tipo_ovos_id_tipo_ovos`,date_format(`estoque`.`data_entrada`,'%Y-%m-01') AS `mes`,sum(`estoque`.`quantidade`) AS `quantidade_total` from `estoque` group by `estoque`.`tipo_ovos_id_tipo_ovos`,date_format(`estoque`.`data_entrada`,'%Y-%m-01') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `agrupeporcor_id_coredata`
--

/*!50001 DROP VIEW IF EXISTS `agrupeporcor_id_coredata`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `agrupeporcor_id_coredata` AS select `estoque`.`cor_id_cor` AS `cor_id_cor`,`estoque`.`id_producao` AS `id_producao`,sum(`estoque`.`quantidade`) AS `quantidade_total` from `estoque` group by `estoque`.`cor_id_cor`,`estoque`.`id_producao` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `agrupeportamanho`
--

/*!50001 DROP VIEW IF EXISTS `agrupeportamanho`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `agrupeportamanho` AS select `estoque`.`tipo_ovos_id_tipo_ovos` AS `tipo_ovos_id_tipo_ovos`,sum(`estoque`.`quantidade`) AS `quantidade_total` from `estoque` group by `estoque`.`tipo_ovos_id_tipo_ovos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ovosdeumtipoemumperiodo`
--

/*!50001 DROP VIEW IF EXISTS `ovosdeumtipoemumperiodo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ovosdeumtipoemumperiodo` AS select `p`.`data_producao` AS `data_producao`,`p`.`id_producao` AS `id_producao`,`p`.`quantidade` AS `quantidade` from `producao` `p` where (`p`.`data_producao` between '2024-01-01' and '2024-12-31') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `quantosovospordata`
--

/*!50001 DROP VIEW IF EXISTS `quantosovospordata`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `quantosovospordata` AS select `p`.`data_producao` AS `data_producao`,`p`.`id_producao` AS `id_producao`,`p`.`quantidade` AS `quantidade` from `producao` `p` where (`p`.`data_producao` = '2024-05-27') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `quantotemnoestoquegaraio`
--

/*!50001 DROP VIEW IF EXISTS `quantotemnoestoquegaraio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `quantotemnoestoquegaraio` AS select sum((`estoque`.`quantidade` * `estoque`.`peso_unitario`)) AS `peso_total_estoque` from `estoque` */;
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

-- Dump completed on 2024-06-10 19:57:12
