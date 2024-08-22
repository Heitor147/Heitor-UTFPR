CREATE DATABASE  IF NOT EXISTS `lojinha_do_heitorzinho_2024` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lojinha_do_heitorzinho_2024`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: lojinha_do_heitorzinho_2024
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
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `id_cargo` int NOT NULL,
  `nome_cargo` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,'Dono'),(2,'CEO'),(3,'Presidente'),(4,'Diretor de Vendas'),(5,'Diretor de Marketing & Relações Públicas'),(6,'Marketing'),(7,'Porta-voz e Representante'),(8,'Vendedor'),(9,'Motoboy'),(10,'Cozinheiro'),(11,'Chefe de Cozinha'),(12,'Diretor de Produção'),(13,'Supervisor');
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `pessoa_cpf_pessoa` varchar(15) NOT NULL,
  `data_cadastro` date NOT NULL,
  `renda_cliente` double DEFAULT NULL,
  `status_id_status` int NOT NULL,
  PRIMARY KEY (`pessoa_cpf_pessoa`),
  KEY `fk_cliente_pessoa1_idx` (`pessoa_cpf_pessoa`),
  KEY `fk_status_id_status_3_idx` (`status_id_status`),
  CONSTRAINT `fk_pessoa_cpf_pessoa` FOREIGN KEY (`pessoa_cpf_pessoa`) REFERENCES `pessoa` (`cpf_pessoa`),
  CONSTRAINT `fk_status_id_status_3` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('0712520401','2024-01-01',1000000,1),('7015145001','2024-05-12',1000000,1),('9751502401','2024-05-12',1000000,1);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `id_entrega` int NOT NULL,
  `pedido_id_pedido` int NOT NULL,
  `tipo_entrega_id_tipo_entrega` int NOT NULL,
  `status_entrega_id_status_entrega` int NOT NULL,
  PRIMARY KEY (`id_entrega`),
  KEY `fk_pedido_id_pedido_idx` (`pedido_id_pedido`),
  KEY `fk_tipo_entrega_id_tipo_entrega_idx` (`tipo_entrega_id_tipo_entrega`),
  KEY `fk_status_entrega_id_status_entrega_idx` (`status_entrega_id_status_entrega`),
  CONSTRAINT `fk_pedido_id_pedido` FOREIGN KEY (`pedido_id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `fk_status_entrega_id_status_entrega` FOREIGN KEY (`status_entrega_id_status_entrega`) REFERENCES `status_entrega` (`id_status_entrega`),
  CONSTRAINT `fk_tipo_entrega_id_tipo_entrega` FOREIGN KEY (`tipo_entrega_id_tipo_entrega`) REFERENCES `tipo_entrega` (`id_tipo_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega`
--

LOCK TABLES `entrega` WRITE;
/*!40000 ALTER TABLE `entrega` DISABLE KEYS */;
INSERT INTO `entrega` VALUES (1,1,1,1),(2,2,1,1),(3,3,2,1),(4,4,2,1),(5,5,2,3),(6,6,2,3);
/*!40000 ALTER TABLE `entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `pessoa_cpf_pessoa` varchar(15) NOT NULL,
  `data_cadastro` date NOT NULL,
  `cargo_id_cargo` int NOT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `status_id_status` int NOT NULL,
  PRIMARY KEY (`pessoa_cpf_pessoa`),
  KEY `fk_usuario_pessoa1_idx` (`pessoa_cpf_pessoa`),
  KEY `fk_status_id_status_idx` (`status_id_status`),
  KEY `fk_cargo_id_cargo_idx` (`cargo_id_cargo`),
  CONSTRAINT `fk_cargo_id_cargo` FOREIGN KEY (`cargo_id_cargo`) REFERENCES `cargo` (`id_cargo`),
  CONSTRAINT `fk_pessoa_cpf_pessoa_2` FOREIGN KEY (`pessoa_cpf_pessoa`) REFERENCES `pessoa` (`cpf_pessoa`),
  CONSTRAINT `fk_status_id_status_2` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES ('4587814701','2010-05-08',2,'N',4),('6661504801','2007-03-12',9,'N',4),('6666666666','2000-01-01',3,'N',4),('8716148501','2007-05-16',4,'N',4),('8741024101','2007-10-12',1,'N',4),('9045145101','2008-02-13',2,'N',7),('9812347101','2024-04-05',5,'N',4);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `listadeempregados`
--

DROP TABLE IF EXISTS `listadeempregados`;
/*!50001 DROP VIEW IF EXISTS `listadeempregados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `listadeempregados` AS SELECT 
 1 AS `pessoa_cpf_pessoa`,
 1 AS `nome_pessoa`,
 1 AS `nome_cargo`,
 1 AS `nome_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL,
  `data_pedido` date NOT NULL,
  `cliente_pessoa_cpf_pessoa` varchar(15) NOT NULL,
  `naoSei` varchar(45) DEFAULT NULL,
  `funcionario_pessoa_cpf_pessoa` varchar(15) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `fk_funcionario_pessoa_cpf_pessoa_idx` (`funcionario_pessoa_cpf_pessoa`),
  KEY `fk_cliente_pessoa_cpf_pessoa_idx` (`cliente_pessoa_cpf_pessoa`),
  CONSTRAINT `fk_cliente_pessoa_cpf_pessoa` FOREIGN KEY (`cliente_pessoa_cpf_pessoa`) REFERENCES `cliente` (`pessoa_cpf_pessoa`),
  CONSTRAINT `fk_funcionario_pessoa_cpf_pessoa` FOREIGN KEY (`funcionario_pessoa_cpf_pessoa`) REFERENCES `funcionario` (`pessoa_cpf_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2024-05-12','0712520401','A','6661504801'),(2,'2024-05-12','0712520401','A','6661504801'),(3,'2024-05-12','9751502401','a','6661504801'),(4,'2024-05-12','9751502401','a','6661504801'),(5,'2024-05-12','7015145001','a','6661504801'),(6,'2024-05-12','7015145001','a','6661504801');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_has_produto`
--

DROP TABLE IF EXISTS `pedido_has_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_has_produto` (
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade_produto_pedido` int DEFAULT NULL,
  `preco_unitario` double DEFAULT NULL,
  `desconto_unitario` double DEFAULT NULL,
  PRIMARY KEY (`id_pedido`,`id_produto`),
  KEY `fk_pedido_has_produto_pedido1_idx` (`id_pedido`),
  KEY `fk_produto_id_produto_idx` (`id_produto`),
  CONSTRAINT `fk_pedido_id_pedido_2` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `fk_produto_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_has_produto`
--

LOCK TABLES `pedido_has_produto` WRITE;
/*!40000 ALTER TABLE `pedido_has_produto` DISABLE KEYS */;
INSERT INTO `pedido_has_produto` VALUES (1,1,1,10,0),(2,6,1,5,0),(3,1,1,10,5),(4,6,1,5,0),(5,1,1,10,0),(6,6,1,5,0);
/*!40000 ALTER TABLE `pedido_has_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `cpf_pessoa` varchar(15) NOT NULL,
  `nome_pessoa` varchar(100) NOT NULL,
  `foto_pessoa` text,
  `e_mail_pessoa` varchar(100) DEFAULT NULL,
  `status_id_status` int NOT NULL,
  PRIMARY KEY (`cpf_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES ('0712520401','Luiza Marcassini','f','o',1),('4587814701','Adrianna Salermann','a','a',1),('6661504801','Rafaela Zilotti','e','yy',2),('6666666666','Lucifer Morningstar','c','h',1),('7015145001','Marta Aparecida Sampaio','l','u',1),('8716148501','Andrei Abner','d','kl',1),('8741024101','Heitor Henrique','b','p',1),('9045145101','Alexandre Damasco','h','mn',1),('9751502401','Ezequiel de Oliveira Chagas','j','k',1),('9812347101','Cassandra Webb','g','j',1);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preco_produto`
--

DROP TABLE IF EXISTS `preco_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preco_produto` (
  `produto_id_produto` int NOT NULL,
  `data_preco_produto` date NOT NULL,
  `preco_produto` double NOT NULL,
  PRIMARY KEY (`produto_id_produto`,`data_preco_produto`),
  KEY `fk_preco_produto_produto_idx` (`produto_id_produto`),
  CONSTRAINT `fk_produto_id_produto_2` FOREIGN KEY (`produto_id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preco_produto`
--

LOCK TABLES `preco_produto` WRITE;
/*!40000 ALTER TABLE `preco_produto` DISABLE KEYS */;
INSERT INTO `preco_produto` VALUES (1,'2024-01-01',10),(6,'2024-01-01',5);
/*!40000 ALTER TABLE `preco_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL,
  `nome_produto` varchar(45) NOT NULL,
  `quantidade_estoque_produto` int NOT NULL,
  `status_id_status` int NOT NULL,
  `unidade_de_medida_id_unidade_de_medida` varchar(2) NOT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `fk_status_id_status_idx` (`status_id_status`),
  KEY `fk_unidade_de_medida_id_unidade_de_medida_idx` (`unidade_de_medida_id_unidade_de_medida`),
  CONSTRAINT `fk_status_id_status` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`),
  CONSTRAINT `fk_unidade_de_medida_id_unidade_de_medida` FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida`) REFERENCES `unidade_de_medida` (`id_unidade_de_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Batata frita',80,4,'1'),(2,'Hamburger',40,4,'1'),(3,'Pizza',10,4,'2'),(4,'Miojo',0,5,'1'),(5,'Pastel',20,4,'1'),(6,'Refrigerante',15,4,'3');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id_status` int NOT NULL,
  `nome_status` varchar(45) NOT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Vivo'),(2,'Morto-vivo'),(3,'Morto'),(4,'Ativo'),(5,'Suspenso'),(6,'Demitido'),(7,'Aposentado');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_entrega`
--

DROP TABLE IF EXISTS `status_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_entrega` (
  `id_status_entrega` int NOT NULL,
  `nome_status_entrega` varchar(45) NOT NULL,
  PRIMARY KEY (`id_status_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_entrega`
--

LOCK TABLES `status_entrega` WRITE;
/*!40000 ALTER TABLE `status_entrega` DISABLE KEYS */;
INSERT INTO `status_entrega` VALUES (1,'Concluída'),(2,'Pendente'),(3,'Cancelada');
/*!40000 ALTER TABLE `status_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_entrega`
--

DROP TABLE IF EXISTS `tipo_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_entrega` (
  `id_tipo_entrega` int NOT NULL,
  `nome_tipo_entrega` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_entrega`
--

LOCK TABLES `tipo_entrega` WRITE;
/*!40000 ALTER TABLE `tipo_entrega` DISABLE KEYS */;
INSERT INTO `tipo_entrega` VALUES (1,'Presencial'),(2,'Entrega');
/*!40000 ALTER TABLE `tipo_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_de_medida`
--

DROP TABLE IF EXISTS `unidade_de_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_de_medida` (
  `id_unidade_de_medida` varchar(2) NOT NULL,
  `nome_unidade_de_medida` varchar(45) NOT NULL,
  PRIMARY KEY (`id_unidade_de_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_de_medida`
--

LOCK TABLES `unidade_de_medida` WRITE;
/*!40000 ALTER TABLE `unidade_de_medida` DISABLE KEYS */;
INSERT INTO `unidade_de_medida` VALUES ('1','g'),('2','kg'),('3','l'),('4','ml'),('5','cm'),('6','m');
/*!40000 ALTER TABLE `unidade_de_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `listadeempregados`
--

/*!50001 DROP VIEW IF EXISTS `listadeempregados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `listadeempregados` AS select `funcionario`.`pessoa_cpf_pessoa` AS `pessoa_cpf_pessoa`,`pessoa`.`nome_pessoa` AS `nome_pessoa`,`cargo`.`nome_cargo` AS `nome_cargo`,`status`.`nome_status` AS `nome_status` from (((`pessoa` join `funcionario`) join `cargo`) join `status`) where ((`pessoa`.`cpf_pessoa` = `funcionario`.`pessoa_cpf_pessoa`) and (`cargo`.`id_cargo` = `funcionario`.`cargo_id_cargo`) and (`status`.`id_status` = `funcionario`.`status_id_status`)) */;
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

-- Dump completed on 2024-05-17 20:16:33
