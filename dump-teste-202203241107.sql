-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: teste
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `codigo` int NOT NULL AUTO_INCREMENT COMMENT 'Codigo do Cliente',
  `nome` varchar(100) NOT NULL COMMENT 'Nome do Cliente',
  `cidade` varchar(100) NOT NULL COMMENT 'Cidade do Cliente',
  `uf` varchar(2) NOT NULL COMMENT 'UF do Cliente',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'CLAUDIO TADEU CHAVES','CONCORDIA','SC'),(2,'JOAO DA SILVA','CHAPECO ','SC'),(3,'ADRIANA RODRIGUES','FLORIANOPOLIS','SC'),(4,'FERNANDA ANTUNES','CONCORDIA','SC'),(5,'LUCAS DE ALMEIDA','CHAPECO','SC'),(6,'PEDRO ANGELO','PORTO ALEGRE','RS'),(7,'PLINIO DE SOUZA','CURITIBA','RS'),(8,'ANDERSON SANTOS','SAO PAULO','SP'),(9,'AMERICO LUIZ FLAN','CONCORDIA','SC'),(10,'LUIS HENRIQUE ','CONCORDIA','SC'),(11,'AMELIA DOS SANTOS PEREIRA','CHAPECO','SC'),(12,'RICARDO SILVA','CONCORDIA','SC'),(13,'LUGIA MARA PINHO','FLORIANOPOLIS','SC'),(14,'LETICIA JULIA CHAVES','CONCORDIA','SC'),(15,'LAURA DE SOUZA CHAVES','CONCORDIA','SC'),(16,'VANDERLEI ANDERSON MATTOS','CHAPECO','SC'),(17,'MARIA DAS GRACAS','CONCORDIA','SC'),(18,'LUIZA FRANK','FLORIANOPOLIS','SC'),(19,'ARNALDO ANTUNES','CHAPECO','SC'),(20,'ALINE RODRIGUES PEREIRA','CONCORDIA','SC');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `numero` int NOT NULL COMMENT 'Numero do Pedido',
  `dtemissao` date NOT NULL COMMENT 'Data de Emissao',
  `cliente` int DEFAULT NULL COMMENT 'Codigo do Cliente',
  `vlrtotal` float NOT NULL DEFAULT '0' COMMENT 'Valor do Pedido',
  PRIMARY KEY (`numero`),
  KEY `pedidos_FK_1` (`cliente`),
  CONSTRAINT `pedidos_FK` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`codigo`),
  CONSTRAINT `pedidos_FK_1` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_itens`
--

DROP TABLE IF EXISTS `pedidos_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_itens` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID dos itens do pedido',
  `pedido` int NOT NULL COMMENT 'Numero do Pedido',
  `produto` int NOT NULL COMMENT 'Codigo do Produto',
  `quantidade` float NOT NULL,
  `vlrunitario` float NOT NULL COMMENT 'Valor Unitario',
  `vlrtotal` float NOT NULL COMMENT 'Valor Total',
  PRIMARY KEY (`id`),
  KEY `pedidos_itens_FK` (`pedido`),
  KEY `pedidos_itens_FK_1` (`produto`),
  CONSTRAINT `pedidos_itens_FK` FOREIGN KEY (`pedido`) REFERENCES `pedidos` (`numero`),
  CONSTRAINT `pedidos_itens_FK_1` FOREIGN KEY (`produto`) REFERENCES `produtos` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_itens`
--

LOCK TABLES `pedidos_itens` WRITE;
/*!40000 ALTER TABLE `pedidos_itens` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT COMMENT 'Codigo do Produto',
  `descricao` varchar(100) NOT NULL COMMENT 'Descricao do Produto',
  `precovenda` float NOT NULL DEFAULT '0' COMMENT 'Preço de Venda',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'ESPONJA MULTIUSO',10.9),(2,'COPO DESCARTAVEL 180ML C/25UND',6.98),(3,'ALCOOL LIQUIDO 70 12X1L',748),(4,'PAPEL FILME 28X300M',26.1),(5,'BARRA CER MEL 23G',99),(6,'ROSQUINHA MARILAN LEITE 400G',1174),(7,'TAPIOCA COM QUEIJO E PRESUNTO G UN',1280),(8,'MARATA DE UVA 200ML',6.7),(9,'PAO DE FORMA TRADICIONAL 280G',3.95),(10,'PAO DE FORMA TRADICIONAL 280G',4.95),(11,'MUSCULO LIMPESA PESADA 500ML',36.9),(12,'SUCO VIGOR UVA 200ML',15.74),(13,'LEITE PO NINHO FASES 3 400G',9.45),(14,'OVOS VERMELHO C/12UND GRANJA DO OV',10.96),(15,'LEITE EM PO PIRACANJUBA 200G',4.9),(16,'OLEO DE ARGAN',7.12),(17,'TAMBOR 50L',48.9),(18,'COLCHETE GANCHO LLD 304 N02',17.2),(19,'WAFER MINUETO CH.BAU.30X115G',6.48),(20,'DESINF CAMPESTRE DRAGAO 2L',4.2);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'teste'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-24 11:07:29
