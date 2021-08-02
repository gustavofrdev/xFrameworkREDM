/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	
	('item_bull_horn', 'Ram Horn', 1, 1, 1),
	('item_feather', 'Feather', 1, 0, 1),	
	('item_meat_angus', 'Angus Meat', 1, 0, 1),
	('item_meat_beef', 'Bovine Meat', 1, 0, 1),
	('item_meat_biggame', 'Big Game Meat', 1, 0, 1),
	('item_meat_bison', 'Bison Meat', 1, 0, 1),
	('item_meat_chicken', 'Chicken Breast', 1, 0, 1),
	('item_meat_deer', 'Venison', 1, 0, 1),
	('item_meat_pork', 'Pork tenderloin', 1, 0, 1),
	('item_meat_stringy', 'Stringy Meat', 1, 0, 1),
	('item_meat_turkey', 'Turkey Breast', 1, 0, 1),
	('item_pelt_bear', 'Bear Pelt', 1, 0, 1),
	('item_pelt_bear_black', 'Black Bear Pelt', 1, 1, 1),
	('item_pelt_coyote', 'Coyote Pelt', 1, 1, 1),
	('item_pelt_fox', 'Fox Pelt', 1, 1, 1),
	('item_pelt_panther', 'Wolf Pelt', 1, 1, 1),
	('item_pelt_wolf_large', 'Wolf Pelt (Large)', 1, 1, 1),
	('item_pelt_wolf_medium', 'Wolf Pelt (Medium)', 1, 1, 1),
	('item_pelt_wolf_small', 'Wolf Pelt', 1, 1, 1),
	('item_ram_horn', 'Ram Horn', 1, 1, 1),
	('item_skin_alligator', 'Alligator Skin', 1, 1, 1),
	('item_turtle_shell', 'Turtle Shell', 1, 1, 1),
	('item_vemon', 'Snake Vemon', 1, 1, 1),
	('item_wool', 'Wool', 1, 1, 1);
                ('item_fish', 'Fish', 1, 1, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
