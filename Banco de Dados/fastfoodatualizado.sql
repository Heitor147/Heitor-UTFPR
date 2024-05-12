-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lojinha_do_heitorzinho_2024
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lojinha_do_heitorzinho_2024
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lojinha_do_heitorzinho_2024` DEFAULT CHARACTER SET utf8mb3 ;
USE `lojinha_do_heitorzinho_2024` ;

-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`cargo` (
  `id_cargo` INT NOT NULL,
  `nome_cargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cargo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`status` (
  `id_status` INT NOT NULL,
  `nome_status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`pessoa` (
  `cpf_pessoa` VARCHAR(15) NOT NULL,
  `nome_pessoa` VARCHAR(100) NOT NULL,
  `foto_pessoa` TEXT NULL DEFAULT NULL,
  `e_mail_pessoa` VARCHAR(100) NULL DEFAULT NULL,
  `status_id_status` INT NOT NULL,
  PRIMARY KEY (`cpf_pessoa`),
  UNIQUE INDEX `e_mail_pessoa_UNIQUE` (`e_mail_pessoa` ASC) VISIBLE,
  INDEX `fk_pessoa_status1_idx` (`status_id_status` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_status1`
    FOREIGN KEY (`status_id_status`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`status` (`id_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`cliente` (
  `pessoa_cpf_pessoa` VARCHAR(15) NOT NULL,
  `data_cadastro` DATE NOT NULL,
  `renda_cliente` DOUBLE NULL DEFAULT NULL,
  `status_id_status` INT NOT NULL,
  PRIMARY KEY (`pessoa_cpf_pessoa`),
  INDEX `fk_cliente_pessoa1_idx` (`pessoa_cpf_pessoa` ASC) VISIBLE,
  INDEX `fk_cliente_status1_idx` (`status_id_status` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_pessoa1`
    FOREIGN KEY (`pessoa_cpf_pessoa`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`pessoa` (`cpf_pessoa`),
  CONSTRAINT `fk_cliente_status1`
    FOREIGN KEY (`status_id_status`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`status` (`id_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`entrega` (
  `id_entrega` INT NOT NULL,
  `id_pedido` VARCHAR(45) NOT NULL,
  `tipo_entrega` VARCHAR(45) NOT NULL,
  `status_entrega` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_entrega`, `id_pedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`funcionario` (
  `pessoa_cpf_pessoa` VARCHAR(15) NOT NULL,
  `data_cadastro` DATE NOT NULL,
  `cargo_id_cargo` INT NOT NULL,
  `observacao` VARCHAR(200) NULL DEFAULT NULL,
  `status_id_status` INT NOT NULL,
  PRIMARY KEY (`pessoa_cpf_pessoa`),
  INDEX `fk_usuario_pessoa1_idx` (`pessoa_cpf_pessoa` ASC) VISIBLE,
  INDEX `fk_funcionario_cargo1_idx` (`cargo_id_cargo` ASC) VISIBLE,
  INDEX `fk_funcionario_status1_idx` (`status_id_status` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`cargo_id_cargo`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`cargo` (`id_cargo`),
  CONSTRAINT `fk_funcionario_status1`
    FOREIGN KEY (`status_id_status`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`status` (`id_status`),
  CONSTRAINT `fk_usuario_pessoa1`
    FOREIGN KEY (`pessoa_cpf_pessoa`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`pessoa` (`cpf_pessoa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`pedido` (
  `id_pedido` INT NOT NULL,
  `data_pedido` DATE NOT NULL,
  `cliente_pessoa_cpf_pessoa` VARCHAR(15) NOT NULL,
  `naoSei` VARCHAR(45) NULL DEFAULT NULL,
  `funcionario_pessoa_cpf_pessoa` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_pessoa_cpf_pessoa` ASC) VISIBLE,
  INDEX `fk_pedido_funcionario1_idx` (`funcionario_pessoa_cpf_pessoa` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_pessoa_cpf_pessoa`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`cliente` (`pessoa_cpf_pessoa`),
  CONSTRAINT `fk_pedido_funcionario1`
    FOREIGN KEY (`funcionario_pessoa_cpf_pessoa`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`funcionario` (`pessoa_cpf_pessoa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`unidade_de_medida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`unidade_de_medida` (
  `id_unidade_de_medida` VARCHAR(2) NOT NULL,
  `nome_unidade_de_medida` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_unidade_de_medida`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`produto` (
  `id_produto` INT NOT NULL,
  `nome_produto` VARCHAR(45) NOT NULL,
  `quantidade_estoque_produto` INT NOT NULL,
  `status_id_status` INT NOT NULL,
  `unidade_de_medida_id_unidade_de_medida` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_produto_status1_idx` (`status_id_status` ASC) VISIBLE,
  INDEX `fk_produto_unidade_de_medida1_idx` (`unidade_de_medida_id_unidade_de_medida` ASC) VISIBLE,
  CONSTRAINT `fk_produto_status1`
    FOREIGN KEY (`status_id_status`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`status` (`id_status`),
  CONSTRAINT `fk_produto_unidade_de_medida1`
    FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`unidade_de_medida` (`id_unidade_de_medida`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`pedido_has_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`pedido_has_produto` (
  `id_pedido` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade_produto_pedido` INT NULL DEFAULT NULL,
  `preco_unitario` DOUBLE NULL DEFAULT NULL,
  `desconto_unitario` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido`, `id_produto`),
  INDEX `fk_pedido_has_produto_pedido1_idx` (`id_pedido` ASC) VISIBLE,
  INDEX `fk_pedido_has_produto_produto1` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_has_produto_pedido1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`pedido` (`id_pedido`),
  CONSTRAINT `fk_pedido_has_produto_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`produto` (`id_produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`preco_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`preco_produto` (
  `produto_id_produto` INT NOT NULL,
  `data_preco_produto` DATE NOT NULL,
  `preco_produto` DOUBLE NOT NULL,
  PRIMARY KEY (`produto_id_produto`, `data_preco_produto`),
  INDEX `fk_preco_produto_produto_idx` (`produto_id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_preco_produto_produto`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `lojinha_do_heitorzinho_2024`.`produto` (`id_produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`status_entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`status_entrega` (
  `id_status_entrega` INT NOT NULL,
  `nome_status_entrega` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_status_entrega`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojinha_do_heitorzinho_2024`.`tipo_entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`tipo_entrega` (
  `id_tipo_entrega` INT NOT NULL,
  `nome_tipo_entrega` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_entrega`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `lojinha_do_heitorzinho_2024` ;

-- -----------------------------------------------------
-- Placeholder table for view `lojinha_do_heitorzinho_2024`.`listadeempregados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`listadeempregados` (`pessoa_cpf_pessoa` INT, `nome_pessoa` INT, `nome_cargo` INT, `nome_status` INT);

-- -----------------------------------------------------
-- Placeholder table for view `lojinha_do_heitorzinho_2024`.`listadeentregas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojinha_do_heitorzinho_2024`.`listadeentregas` (`id_entrega` INT, `id_pedido` INT, `tipo_entrega` INT, `status_entrega` INT);

-- -----------------------------------------------------
-- View `lojinha_do_heitorzinho_2024`.`listadeempregados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lojinha_do_heitorzinho_2024`.`listadeempregados`;
USE `lojinha_do_heitorzinho_2024`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lojinha_do_heitorzinho_2024`.`listadeempregados` AS select `lojinha_do_heitorzinho_2024`.`funcionario`.`pessoa_cpf_pessoa` AS `pessoa_cpf_pessoa`,`lojinha_do_heitorzinho_2024`.`pessoa`.`nome_pessoa` AS `nome_pessoa`,`lojinha_do_heitorzinho_2024`.`cargo`.`nome_cargo` AS `nome_cargo`,`lojinha_do_heitorzinho_2024`.`status`.`nome_status` AS `nome_status` from (((`lojinha_do_heitorzinho_2024`.`pessoa` join `lojinha_do_heitorzinho_2024`.`funcionario`) join `lojinha_do_heitorzinho_2024`.`cargo`) join `lojinha_do_heitorzinho_2024`.`status`) where ((`lojinha_do_heitorzinho_2024`.`pessoa`.`cpf_pessoa` = `lojinha_do_heitorzinho_2024`.`funcionario`.`pessoa_cpf_pessoa`) and (`lojinha_do_heitorzinho_2024`.`cargo`.`id_cargo` = `lojinha_do_heitorzinho_2024`.`funcionario`.`cargo_id_cargo`) and (`lojinha_do_heitorzinho_2024`.`status`.`id_status` = `lojinha_do_heitorzinho_2024`.`funcionario`.`status_id_status`));

-- -----------------------------------------------------
-- View `lojinha_do_heitorzinho_2024`.`listadeentregas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lojinha_do_heitorzinho_2024`.`listadeentregas`;
USE `lojinha_do_heitorzinho_2024`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lojinha_do_heitorzinho_2024`.`listadeentregas` AS select `lojinha_do_heitorzinho_2024`.`entrega`.`id_entrega` AS `id_entrega`,`lojinha_do_heitorzinho_2024`.`entrega`.`id_pedido` AS `id_pedido`,`lojinha_do_heitorzinho_2024`.`tipo_entrega`.`nome_tipo_entrega` AS `tipo_entrega`,`lojinha_do_heitorzinho_2024`.`status_entrega`.`nome_status_entrega` AS `status_entrega` from ((`lojinha_do_heitorzinho_2024`.`entrega` join `lojinha_do_heitorzinho_2024`.`tipo_entrega`) join `lojinha_do_heitorzinho_2024`.`status_entrega`);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
