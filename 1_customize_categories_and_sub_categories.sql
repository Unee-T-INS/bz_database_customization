# This script customize the values of
#   - Categories
#   - Sub-Categories
#   - Variables names in the UX for the BZFE

############################################
#
# Make sure to update the below variable(s)
#
############################################
#
# What is the version of the Unee-T BZ Database schema AFTER this update?
	SET @old_schema_version = 'v5.39.1';
	SET @new_schema_version = 'v5.39.2';

# What is the name of this script?
	SET @this_script = '1_customize_categories_and_sub_categories.sql';

# When are we doing this?
	SET @timestamp = NOW();

###############################
#
# We have everything we need
#
###############################

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
            (2,'Other',55,1,NULL),
            (3,'New business',5,1,NULL),
            (4,'Renewal',10,1,NULL),
            (5,'Endorsement',15,1,NULL),
            (6,'Claims',20,1,NULL)
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
            (2,'Payment/Reimbursement',5,1,NULL),
            (3,'Documents',10,1,NULL),
            (4,'Other',999,1,NULL),
            (5,'Quotation',105,1,3),
            (6,'Submission',110,1,3),
            (7,'Change in policy',115,1,4),
            (8,'Addition',120,1,5),
            (9,'Deletion',200,1,5),
            (10,'Urgent question',210,1,6)
            (11,'Standard question',215,1,6),
            (12,'Urgent submission',220,1,6),
            (13,'Standard submission',225,1,6),
            (15,'Reimbursement',230,1,6),
            (15,'Request for LOG',235,1,6),
            (16,'Investigation',240,1,6),
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

# We can now update the version of the database schema
	# A comment for the update
		SET @comment_update_schema_version = CONCAT (
			'Database updated from '
			, @old_schema_version
			, ' to '
			, @new_schema_version
		)
		;

	# We record that the table has been updated to the new version.
	INSERT INTO `ut_db_schema_version`
		(`schema_version`
		, `update_datetime`
		, `update_script`
		, `comment`
		)
		VALUES
		(@new_schema_version
		, @timestamp
		, @this_script
		, @comment_update_schema_version
		)
		;