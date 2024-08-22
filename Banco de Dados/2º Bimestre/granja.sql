-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema granja_foda
-- -----------------------------------------------------
-- a
-- 
-- 
DROP SCHEMA IF EXISTS `granja_foda` ;

-- -----------------------------------------------------
-- Schema granja_foda
--
-- a
-- 
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `granja_foda` ;
SHOW WARNINGS;
USE `granja_foda` ;

-- -----------------------------------------------------
-- Table `unidade_de_medida`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidade_de_medida` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `unidade_de_medida` (
  `id_unidade_de_medida` INT NOT NULL,
  `nome_unidade_de_medida` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_unidade_de_medida`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tipo_ovos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_ovos` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tipo_ovos` (
  `id_tipo_ovos` INT NOT NULL,
  `nome_tipo_ovos` VARCHAR(45) NOT NULL,
  `unidade_de_medida_id_unidade_de_medida` INT NOT NULL,
  PRIMARY KEY (`id_tipo_ovos`),
  UNIQUE INDEX `id_tipo_ovos_UNIQUE` (`id_tipo_ovos` ASC) VISIBLE,
  INDEX `fk_tipo_ovos_unidade_de_medida_idx` (`unidade_de_medida_id_unidade_de_medida` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_ovos_unidade_de_medida`
    FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida`)
    REFERENCES `unidade_de_medida` (`id_unidade_de_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `galinha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `galinha` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `galinha` (
  `id_galinha` INT NOT NULL,
  `nome_galinha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_galinha`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `producao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `producao` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `producao` (
  `id_producao` INT NOT NULL,
  `data_producao` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id_producao`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ovos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ovos` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ovos` (
  `id_ovos` INT NOT NULL,
  `producao_id_producao` INT NOT NULL,
  `tipo_ovos_id_tipo_ovos` INT NOT NULL,
  `galinha_id_galinha` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_ovos`),
  INDEX `fk_ovos_1_idx` (`tipo_ovos_id_tipo_ovos` ASC) VISIBLE,
  INDEX `fk_ovos_2_idx` (`galinha_id_galinha` ASC) VISIBLE,
  INDEX `fk_ovos_3_idx` (`producao_id_producao` ASC) VISIBLE,
  CONSTRAINT `fk_ovos_1`
    FOREIGN KEY (`tipo_ovos_id_tipo_ovos`)
    REFERENCES `tipo_ovos` (`id_tipo_ovos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ovos_2`
    FOREIGN KEY (`galinha_id_galinha`)
    REFERENCES `galinha` (`id_galinha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ovos_3`
    FOREIGN KEY (`producao_id_producao`)
    REFERENCES `producao` (`id_producao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `preco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `preco` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `preco` (
  `ovos_id_ovos` INT NOT NULL,
  `data_preco` VARCHAR(45) NOT NULL,
  `preco_ovo` DOUBLE NOT NULL,
  PRIMARY KEY (`ovos_id_ovos`, `data_preco`),
  CONSTRAINT `fk_preço_1`
    FOREIGN KEY (`ovos_id_ovos`)
    REFERENCES `ovos` (`id_ovos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
