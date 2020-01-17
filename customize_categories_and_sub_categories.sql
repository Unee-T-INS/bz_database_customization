# This script customize the values of
#   - Categories
#   - Sub-Categories
#   - Variables names in the UX for the BZFE

/*!40101 SET NAMES utf8mb4 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# We truncate the Sub-Categories

    TRUNCATE TABLE `cf_ipi_clust_6_claim_type`;

# We truncate the categories

    TRUNCATE TABLE `rep_platform`;

# We need at least 1 category

    INSERT INTO `rep_platform`
        (`id`
        ,`value`
        ,`sortkey`
        ,`isactive`
        ,`visibility_value_id`
        ) 
        VALUES
            (1,'---',0,1,NULL)
        ;

# We neet at least 1 sub-category

    INSERT INTO `cf_ipi_clust_6_claim_type`
        (`id`
        ,`value`
        ,`sortkey`
        ,`isactive`
        ,`visibility_value_id`
        ) 
        VALUES
            (1,'---',0,1,NULL)
        ;

# We now add the rest of the categories


    INSERT INTO `rep_platform`
        (`id`
        ,`value`
        ,`sortkey`
        ,`isactive`
        ,`visibility_value_id`
        ) 
        VALUES
            (2,'Repair',9999,0,NULL),
            (3,'Maintenance',9999,0,NULL),
            (4,'Housekeeping',40,1,NULL),
            (5,'Devices',9999,0,NULL),
            (6,'Renovation',9999,0,NULL),
            (7,'Projects',50,1,NULL),
            (8,'Extra Service',45,1,NULL),
            (9,'Utilities',60,1,NULL),
            (10,'Other',55,1,NULL),
            (11,'Furnitures/Fixtures',5,1,NULL),
            (12,'Appliances/Equipment',10,1,NULL),
            (13,'Electrical',15,1,NULL),
            (14,'Plumbing',20,1,NULL),
            (15,'Aircon/Heating',25,1,NULL),
            (16,'Structural',30,1,NULL),
            (17,'Landscape',35,1,NULL)
        ;

# We now do the sub-categories:

    INSERT INTO `cf_ipi_clust_6_claim_type`
        (`id`
        ,`value`
        ,`sortkey`
        ,`isactive`
        ,`visibility_value_id`
        ) 
        VALUES
            (2,'Electrical',9999,0,2),
            (3,'Plumbing Rep',9999,0,2),
            (4,'Aircon Rep',9999,0,2),
            (5,'Furniture Rep',9999,0,2),
            (6,'Carpentry Rep',9999,0,2),
            (7,'Internet Rep',9999,0,2),
            (8,'Cable TV Rep',9999,0,2),
            (9,'Other Rep',9999,0,2),
            (10,'Aircon M',9999,0,3),
            (11,'Equipment M',9999,0,3),
            (12,'Plumbing M',9999,0,3),
            (13,'Battery repl.',9999,0,3),
            (14,'Other M',9999,0,3),
            (15,'Linens',110,1,4),
            (16,'Textile',115,1,4),
            (17,'Curtains',120,1,4),
            (18,'Cleaning',105,1,4),
            (19,'Other H',9999,0,4),
            (20,'Key',9999,0,5),
            (21,'Resident Card',9999,0,5),
            (22,'Car Transponder',9999,0,5),
            (23,'Kitchen Utensils',9999,0,5),
            (24,'Furniture D',9999,0,5),
            (25,'Safe box',9999,0,5),
            (26,'Equipment D',9999,0,5),
            (27,'Other D',9999,0,5),
            (28,'Structural Defect',9999,0,6),
            (29,'Carpentry Ren',9999,0,6),
            (30,'Parquet Polishing',9999,0,6),
            (31,'Painting',9999,0,6),
            (32,'Other Ren',9999,0,6),
            (33,'Set Up',405,1,7),
            (34,'Light Renovation',420,1,7),
            (35,'Refurbishing',410,1,7),
            (36,'Hand Over',430,1,7),
            (37,'Check',415,1,7),
            (38,'Store room Clearance',9999,0,7),
            (39,'Other CP',9999,0,7),
            (40,'Laundry',225,1,8),
            (41,'Ironing',220,1,8),
            (42,'Housekeeping',215,1,8),
            (43,'Cable Upgrade',230,1,8),
            (44,'Internet Upgrade',235,1,8),
            (45,'Beds',9999,0,8),
            (46,'Baby Cot',9999,0,8),
            (47,'Transportation',240,1,8),
            (48,'Welcome Basket',9999,0,8),
            (49,'Dish Washing',9999,0,8),
            (50,'Other ES',9999,0,8),
            (51,'NOT SPECIFIED',200,1,8),
            (52,'Electricity',305,1,9),
            (53,'Gas',315,1,9),
            (54,'Meter Reading',9999,0,9),
            (55,'Other U',9999,0,9),
            (56,'Internet',320,1,9),
            (57,'Cable',325,1,9),
            (58,'Viewing',525,1,10),
            (59,'Other_obsolete',9999,0,10),
            (60,'Early/Late',245,1,8),
            (61,'Early Check IN/OUT',9999,0,8),
            (62,'High Chair',9999,0,8),
            (63,'Equipment',9999,0,2),
            (64,'Repair',5,1,NULL),
            (65,'Maintenance',10,1,NULL),
            (66,'Replace',15,1,NULL),
            (67,'Security',520,1,10),
            (68,'Other',999,1,NULL),
            (69,'Water',310,1,9),
            (70,'Renovation',425,1,7),
            (71,'Extra Furnitures/Fixtures',210,1,8)
        ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

# We update the Procedure `update_bz_fielddefs` */

DROP PROCEDURE IF EXISTS `update_bz_fielddefs` ;

DELIMITER $$

CREATE PROCEDURE `update_bz_fielddefs`()
	SQL SECURITY INVOKER
BEGIN

	# Update the name for the field `bug_id`
	UPDATE `fielddefs`
	SET `description` = 'Claim #'
	WHERE `id` = 1;

	# Update the name for the field `classification`
	UPDATE `fielddefs`
	SET `description` = 'Policy Group'
	WHERE `id` = 3;

	# Update the name for the field `product`
	UPDATE `fielddefs`
	SET `description` = 'Policy'
	WHERE `id` = 4;

	# Update the name for the field `rep_platform`
	UPDATE `fielddefs`
	SET `description` = 'Claim Category'
	WHERE `id` = 6;

	# Update the name for the field `cf_ipi_clust_6_claim_type`
	UPDATE `fielddefs`
	SET `description` = 'Claim Type'
	WHERE `id` = 63;

	# Update the name for the field `component`
	UPDATE `fielddefs`
	SET `description` = 'Role'
	WHERE `id` = 15;

	# Update the name for the field `days_elapsed`
	UPDATE `fielddefs`
	SET `description` = 'Days since claim changed'
	WHERE `id` = 59;

END $$
DELIMITER ;

# We call the procedure to update the fielddefs

    CALL `update_bz_fielddefs`;