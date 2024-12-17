CREATE DATABASE  IF NOT EXISTS `candyshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `candyshop`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: candyshop
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
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `idCargo` int NOT NULL,
  `nomeCargo` varchar(45) NOT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,'Gerente'),(2,'Vendedor'),(3,'Auxiliar de limpeza');
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `rendaCliente` double NOT NULL,
  `dataDeCadastroCliente` date NOT NULL,
  `PessoaCpfPessoa` varchar(20) NOT NULL,
  PRIMARY KEY (`PessoaCpfPessoa`),
  CONSTRAINT `fk_Cliente_Pessoa1` FOREIGN KEY (`PessoaCpfPessoa`) REFERENCES `pessoa` (`cpfPessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (5698,'2000-10-14','123'),(10000,'2024-05-06','222'),(5000,'2024-06-05','333'),(5000,'2022-12-15','555'),(2500,'2020-04-15','777'),(3500,'2021-01-11','999');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `idEndereco` int NOT NULL,
  `logradouro` varchar(100) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `referencia` varchar(45) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`idEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'Rua do tropeços','10','nenhuma','87300400'),(2,'Rua dos buracos','50','lá no fim do mundo','89800899'),(3,'Rua do brejo','25','perto do rio','87912369'),(4,'Av. Fim da linha',NULL,'perto do trilho','87546936');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formadepagamento`
--

DROP TABLE IF EXISTS `formadepagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formadepagamento` (
  `idFormaPagamento` int NOT NULL,
  `nomeFormaPagamento` varchar(100) NOT NULL,
  PRIMARY KEY (`idFormaPagamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Meio de pagamento utilizado para efetivar o pagamento';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formadepagamento`
--

LOCK TABLES `formadepagamento` WRITE;
/*!40000 ALTER TABLE `formadepagamento` DISABLE KEYS */;
INSERT INTO `formadepagamento` VALUES (1,'Dinheiro'),(2,'Cartão de Crédito'),(3,'PIX'),(4,'Boleto');
/*!40000 ALTER TABLE `formadepagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `PessoaCpfPessoa` varchar(20) NOT NULL,
  `salario` double DEFAULT NULL,
  `CargosIdCargo` int NOT NULL,
  `porcentagemComissao` double DEFAULT NULL COMMENT 'Número de zero a um representando a comissão de venda do funcionário.',
  PRIMARY KEY (`PessoaCpfPessoa`),
  KEY `fk_Funcionario_Cargos1_idx` (`CargosIdCargo`),
  CONSTRAINT `fk_Funcionario_Cargos1` FOREIGN KEY (`CargosIdCargo`) REFERENCES `cargo` (`idCargo`),
  CONSTRAINT `fk_funcionario_pessoa1` FOREIGN KEY (`PessoaCpfPessoa`) REFERENCES `pessoa` (`cpfPessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES ('222',2500,2,0.03),('333',2700,2,0.04);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `PedidoIdPedido` int NOT NULL,
  `dataPagamento` timestamp NOT NULL COMMENT 'Data de efetivação do pagamento',
  `valorTotalPagamento` double DEFAULT NULL COMMENT 'Soma de todas as formas de pagamento. Tem que coincidir com o total do pedido.',
  PRIMARY KEY (`PedidoIdPedido`),
  CONSTRAINT `Pagamento_Pedido_FK` FOREIGN KEY (`PedidoIdPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela para controlar os pagamentos. Se o id de um pedido está na tabela pagamento é por que o pagamento foi efetivado.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES (2,'2024-10-01 03:00:00',15.75),(5,'2024-10-10 03:00:00',168.5),(7,'2024-10-14 03:00:00',66);
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentohasformapagamento`
--

DROP TABLE IF EXISTS `pagamentohasformapagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentohasformapagamento` (
  `PagamentoIdPedido` int NOT NULL,
  `FormaPagamentoIdFormaPagamento` int NOT NULL,
  `valorPago` double DEFAULT NULL COMMENT 'valor que foi pago em um pedido com uma forma de pagamento.',
  PRIMARY KEY (`PagamentoIdPedido`,`FormaPagamentoIdFormaPagamento`),
  KEY `PagamentoHasFormaPagamento_Pagamento_FK` (`PagamentoIdPedido`),
  KEY `PagamentoHasFormaPagamento_FormaDePagamento_FK` (`FormaPagamentoIdFormaPagamento`),
  CONSTRAINT `PagamentoHasFormaPagamento_FormaDePagamento_FK` FOREIGN KEY (`FormaPagamentoIdFormaPagamento`) REFERENCES `formadepagamento` (`idFormaPagamento`),
  CONSTRAINT `PagamentoHasFormaPagamento_Pagamento_FK` FOREIGN KEY (`PagamentoIdPedido`) REFERENCES `pagamento` (`PedidoIdPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentohasformapagamento`
--

LOCK TABLES `pagamentohasformapagamento` WRITE;
/*!40000 ALTER TABLE `pagamentohasformapagamento` DISABLE KEYS */;
INSERT INTO `pagamentohasformapagamento` VALUES (2,2,22),(5,1,100),(5,2,68.5);
/*!40000 ALTER TABLE `pagamentohasformapagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `idPedido` int NOT NULL,
  `dataDoPedido` date NOT NULL,
  `ClientePessoaCpfPessoa` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FuncionarioPessoaCpfPessoa` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `fk_Pedido_Cliente1_idx` (`ClientePessoaCpfPessoa`),
  KEY `Pedido_Funcionario_FK` (`FuncionarioPessoaCpfPessoa`),
  CONSTRAINT `fk_Pedido_Cliente1` FOREIGN KEY (`ClientePessoaCpfPessoa`) REFERENCES `cliente` (`PessoaCpfPessoa`),
  CONSTRAINT `Pedido_Funcionario_FK` FOREIGN KEY (`FuncionarioPessoaCpfPessoa`) REFERENCES `funcionario` (`PessoaCpfPessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2024-09-05','333','222'),(2,'2024-04-20','222','333'),(5,'2024-05-20','222','333'),(7,'2024-10-05','555','222');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidohasproduto`
--

DROP TABLE IF EXISTS `pedidohasproduto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidohasproduto` (
  `PedidoIdPedido` int NOT NULL,
  `ProdutoIdProduto` int NOT NULL,
  `quantidade` double NOT NULL,
  `precoUnitario` double NOT NULL,
  PRIMARY KEY (`PedidoIdPedido`,`ProdutoIdProduto`),
  KEY `fk_pedido_has_produto_produto1_idx` (`ProdutoIdProduto`),
  KEY `fk_PedidoHasProduto_Pedido1_idx` (`PedidoIdPedido`),
  CONSTRAINT `fk_pedido_has_produto_produto1` FOREIGN KEY (`ProdutoIdProduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_PedidoHasProduto_Pedido1` FOREIGN KEY (`PedidoIdPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidohasproduto`
--

LOCK TABLES `pedidohasproduto` WRITE;
/*!40000 ALTER TABLE `pedidohasproduto` DISABLE KEYS */;
INSERT INTO `pedidohasproduto` VALUES (1,1,0.2,25),(1,2,0.5,50),(2,1,0.3,25),(2,5,0.15,55),(5,1,0.35,25),(5,2,0.5,50),(5,4,2,55),(5,5,0.45,55),(7,12,0.5,14),(7,28,1.5,29);
/*!40000 ALTER TABLE `pedidohasproduto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `cpfPessoa` varchar(20) NOT NULL,
  `nomePessoa` varchar(60) NOT NULL,
  `dataNascimentoPessoa` date NOT NULL,
  `EnderecoIdEndereco` int NOT NULL,
  PRIMARY KEY (`cpfPessoa`),
  KEY `fk_Pessoa_Endereco1_idx` (`EnderecoIdEndereco`),
  CONSTRAINT `fk_Pessoa_Endereco1` FOREIGN KEY (`EnderecoIdEndereco`) REFERENCES `endereco` (`idEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES ('111','Berola','2024-05-23',1),('123','Zé Bonitinho','1950-06-11',2),('222','Zózoio Cego','2024-05-23',1),('333','xeroncio da silva','2000-05-10',2),('555','Belzelinda','1990-10-10',1),('777','Bernardete da Veiga','2000-12-25',3),('999','Timocréia ','1905-02-13',4);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `idProduto` int NOT NULL,
  `nomeProduto` varchar(45) NOT NULL,
  `quantidadeEmEstoque` int NOT NULL,
  `precoUnitario` double DEFAULT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Cocada branca',100,25),(2,'Jujuba sortida',50,50),(4,'Cocada de coco queimado',25,44),(5,'Doce de leite',12,55),(7,'Paçoquinha rolha',100,22),(9,'Doce de abóbora coração',33,33),(11,'Marshmallow',45,13.5),(12,'Pé de moleque',90,14),(13,'Amendoim açucarado',100,11),(14,'Gelatina de frutas',50,16),(15,'Jujuba',120,10),(16,'Bala de coco',75,12),(17,'Doce de leite pastoso',40,18),(18,'Brigadeiro',65,25),(19,'Beijinho',55,24),(20,'Doce de amendoim',90,20),(21,'Bala de tamarindo',200,7.5),(22,'Bala de hortelã',180,6),(23,'Caramelo',100,15),(24,'Cajuzinho',50,21),(25,'Doce de batata roxa',30,19),(26,'Pipoca doce',110,8),(27,'Suspiro',70,5.5),(28,'Doce de figo',45,29),(29,'Doce de abóbora com coco',50,32),(30,'Goiabada cascão',60,17),(31,'Chocolate branco',95,20),(32,'Torta de limão',40,35),(33,'Doce de leite com coco',55,27),(34,'Doce de abacaxi',35,23),(35,'Doce de banana',65,26),(36,'Doce de maracujá',25,22),(37,'Bala de mel',150,9),(38,'Goma de mascar',180,12),(39,'Torrone de amendoim',85,14),(40,'Doce de caju',45,28);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-01 16:44:35
