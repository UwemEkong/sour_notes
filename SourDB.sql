-- MySQL Workbench Forward Engineering
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SourNotes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SourNotes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SourNotes` DEFAULT CHARACTER SET utf8 ;
USE `SourNotes` ;

-- -----------------------------------------------------
-- Table `SourNotes`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`user` (
  `id` INT NOT NULL auto_increment,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SourNotes`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`review` (
  `id` INT NOT NULL auto_increment,
  `user_id` INT NOT NULL,
  `content` VARCHAR(450) NULL,
  `rating` INT NOT NULL,
  `song_id` VARCHAR(45) NULL,
  `album_id` VARCHAR(45) NULL,
  `favorites` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `song_id_UNIQUE` (`song_id` ASC) VISIBLE,
  UNIQUE INDEX `album_id_UNIQUE` (`album_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SourNotes`.`Song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`song` (
  `id` INT NOT NULL auto_increment,
  `deezer_url` VARCHAR(100) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `artist` VARCHAR(45) NOT NULL,
  `average_rating` DECIMAL(1) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `deezer_url_UNIQUE` (`deezer_url` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SourNotes`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`Album` (
  `idAlbum` INT NOT NULL,
  `DeezerLink` VARCHAR(100) NOT NULL,
  `AverageRating` DECIMAL(1) NOT NULL,
  PRIMARY KEY (`idAlbum`),
  UNIQUE INDEX `idAlbum_UNIQUE` (`idAlbum` ASC) VISIBLE,
  UNIQUE INDEX `DeezerLink_UNIQUE` (`DeezerLink` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
