# This script customize the values of the Role types we need

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
	SET @this_script = '4_customize_the_role_types.sql';

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

# We truncate the existing role types

    TRUNCATE TABLE `ut_role_types`;

# We update the role types

    INSERT INTO `ut_role_types`
        (`id_role_type`
        ,`created`
        ,`role_type`
        ,`bz_description`
        ,`description`
        )
        VALUES
            (1,NOW(),'The Policyholder/Beneficiary','The Tenant','The person or entity who signed the tenancy agreement.'),
            (2,NOW(),'The Insurance company','The Landlord','The person(s) or entity that are the registered owner of the property.'),
            (3,NOW(),'Other','A contractor','A company or a person that can or will do work in the unit (electricity, plumbing, Aircon Maintenance, Housekeeping, etc...).'),
            (4,NOW(),'The HR / Employee Benefit manager','The management Company','Is in charge of day to day operations and responsible to fix things if something happens in a unit.'),
            (5,NOW(),'The Insurance Agent','An agent','The user who act as either the representative for the Tenant or for the Landlord. It is possible to have 2 agents attached to the same unit.')
        ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

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