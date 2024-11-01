CREATE DATABASE  IF NOT EXISTS `lojinha_do_salim_2024` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lojinha_do_salim_2024`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: lojinha_do_salim_2024
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
INSERT INTO `cargo` VALUES (1,'CEO'),(2,'Presidente'),(3,'COO'),(4,'Gerente de Vendas'),(5,'Vendedores'),(6,'Caixa'),(7,'Motoboy'),(8,'CMO'),(9,'Administrador de Redes Sociais'),(10,'Suporte'),(11,'Diretor Culinário'),(12,'Chef Cozinheiro'),(13,'Cozinheiro'),(14,'CPO'),(15,'CFO'),(16,'Contador');
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
  KEY `fk_cliente_status1_idx` (`status_id_status`),
  CONSTRAINT `fk_cliente_pessoa1` FOREIGN KEY (`pessoa_cpf_pessoa`) REFERENCES `pessoa` (`cpf_pessoa`),
  CONSTRAINT `fk_cliente_status1` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('45089420101','2024-04-16',100000.75,3),('80456198001','2024-04-19',800,1);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
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
  KEY `fk_funcionario_cargo1_idx` (`cargo_id_cargo`),
  KEY `fk_funcionario_status1_idx` (`status_id_status`),
  CONSTRAINT `fk_funcionario_cargo1` FOREIGN KEY (`cargo_id_cargo`) REFERENCES `cargo` (`id_cargo`),
  CONSTRAINT `fk_funcionario_status1` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`),
  CONSTRAINT `fk_usuario_pessoa1` FOREIGN KEY (`pessoa_cpf_pessoa`) REFERENCES `pessoa` (`cpf_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES ('50796601501','2024-04-19',5,'N',2),('74100480001','2012-07-04',1,'N',1),('91490045101','2012-07-04',7,'N',1);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `fk_pedido_cliente1_idx` (`cliente_pessoa_cpf_pessoa`),
  KEY `fk_pedido_funcionario1_idx` (`funcionario_pessoa_cpf_pessoa`),
  CONSTRAINT `fk_pedido_cliente1` FOREIGN KEY (`cliente_pessoa_cpf_pessoa`) REFERENCES `cliente` (`pessoa_cpf_pessoa`),
  CONSTRAINT `fk_pedido_funcionario1` FOREIGN KEY (`funcionario_pessoa_cpf_pessoa`) REFERENCES `funcionario` (`pessoa_cpf_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2024-04-19','80456198001','a','50796601501'),(2,'2024-04-19','80456198001','b','50796601501'),(3,'2024-04-19','80456198001','c','50796601501');
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
  KEY `fk_pedido_has_produto_produto1` (`id_produto`),
  CONSTRAINT `fk_pedido_has_produto_pedido1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `fk_pedido_has_produto_produto1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_has_produto`
--

LOCK TABLES `pedido_has_produto` WRITE;
/*!40000 ALTER TABLE `pedido_has_produto` DISABLE KEYS */;
INSERT INTO `pedido_has_produto` VALUES (1,1,1,10,20),(1,2,1,10,20),(1,3,1,15,20),(1,4,1,5,20),(2,2,1,10,20),(2,3,1,15,20),(2,4,1,5,20),(2,5,1,10,20),(3,1,1,10,20),(3,3,1,15,20),(3,4,1,5,20);
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
  PRIMARY KEY (`cpf_pessoa`),
  UNIQUE KEY `e_mail_pessoa_UNIQUE` (`e_mail_pessoa`),
  KEY `fk_pessoa_status1_idx` (`status_id_status`),
  CONSTRAINT `fk_pessoa_status1` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES ('45089420101','Alexander Damasco','b','alexdama@gmail.com',5),('50796601501','Rafaela Zilotti','d','kimalien306@gmail.com',7),('74100480001','Adriana Salmann','a','adrianasalmann@gmail.com',5),('80456198001','Luiza','e','luiza78@gmail.com',5),('91490045101','Daniel Alves','c','danialve2007@gmail.com',5);
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
  CONSTRAINT `fk_preco_produto_produto` FOREIGN KEY (`produto_id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preco_produto`
--

LOCK TABLES `preco_produto` WRITE;
/*!40000 ALTER TABLE `preco_produto` DISABLE KEYS */;
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
  KEY `fk_produto_status1_idx` (`status_id_status`),
  KEY `fk_produto_unidade_de_medida1_idx` (`unidade_de_medida_id_unidade_de_medida`),
  CONSTRAINT `fk_produto_status1` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`),
  CONSTRAINT `fk_produto_unidade_de_medida1` FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida`) REFERENCES `unidade_de_medida` (`id_unidade_de_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Hamburger',20,1,'1'),(2,'Batata Frita',20,1,'2'),(3,'Pizza',40,1,'1'),(4,'Sanduíche',0,3,'5'),(5,'Pastel',5,2,'5');
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
INSERT INTO `status` VALUES (1,'Ativo'),(2,'Suspenso'),(3,'Desligado'),(4,'Demitido'),(5,'Vivo'),(6,'Morto'),(7,'Morto-vivo');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
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
INSERT INTO `unidade_de_medida` VALUES ('1','kg'),('2','g'),('3','l'),('4','ml'),('5','cm'),('6','m');
/*!40000 ALTER TABLE `unidade_de_medida` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-19 21:05:23
