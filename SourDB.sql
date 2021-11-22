-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
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
CREATE TABLE IF NOT EXISTS `SourNotes`.`users` (
  `id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SourNotes`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`Reviews` (
  `idReviews` INT NOT NULL,
  `userID` INT NOT NULL,
  `content` VARCHAR(450) NULL,
  `rating` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `SongID` VARCHAR(45) NULL,
  `AlbumID` VARCHAR(45) NULL,
  `Favorites` INT NULL,
  PRIMARY KEY (`idReviews`),
  UNIQUE INDEX `idReviews_UNIQUE` (`idReviews` ASC) VISIBLE,
  UNIQUE INDEX `SongID_UNIQUE` (`SongID` ASC) VISIBLE,
  UNIQUE INDEX `AlbumID_UNIQUE` (`AlbumID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SourNotes`.`Song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`Song` (
  `idSong` INT NOT NULL,
  `DeezerLink` VARCHAR(45) NOT NULL,
  `AverageRating` DECIMAL(1) NULL,
  PRIMARY KEY (`idSong`),
  UNIQUE INDEX `idSong_UNIQUE` (`idSong` ASC) VISIBLE,
  UNIQUE INDEX `DeezerLink_UNIQUE` (`DeezerLink` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SourNotes`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SourNotes`.`Album` (
  `idAlbum` INT NOT NULL,
  `DeezerLink` VARCHAR(45) NOT NULL,
  `AverageRating` DECIMAL(1) NOT NULL,
  PRIMARY KEY (`idAlbum`),
  UNIQUE INDEX `idAlbum_UNIQUE` (`idAlbum` ASC) VISIBLE,
  UNIQUE INDEX `DeezerLink_UNIQUE` (`DeezerLink` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
