
# This script makes sure that we use the correct dummy users when we send invite
# This is to fix GH issue https://github.com/Unee-T-INS/frontend/issues/11#issuecomment-575612058

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
	SET @this_script = '2_dummy_users_by_environments.sql';

# When are we doing this?
	SET @timestamp = NOW();

###############################
#
# We have everything we need
#
###############################

DROP PROCEDURE IF EXISTS `table_to_list_dummy_user_by_environment` ;

DELIMITER $$

CREATE PROCEDURE `table_to_list_dummy_user_by_environment`()
	SQL SECURITY INVOKER
BEGIN

	# We create a temporary table to record the ids of the dummy users in each environments:
		/*Table structure for table `ut_temp_dummy_users_for_roles` */
			DROP TEMPORARY TABLE IF EXISTS `ut_temp_dummy_users_for_roles`;

			CREATE TEMPORARY TABLE `ut_temp_dummy_users_for_roles` (
				`environment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id of the environment',
				`environment_name` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
				`tenant_id` int(11) NOT NULL,
				`landlord_id` int(11) NOT NULL,
				`contractor_id` int(11) NOT NULL,
				`mgt_cny_id` int(11) NOT NULL,
				`agent_id` int(11) DEFAULT NULL,
				PRIMARY KEY (`environment_id`)
			) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

		/*Data for the table `ut_temp_dummy_users_for_roles` */
			INSERT INTO `ut_temp_dummy_users_for_roles`
				(`environment_id`
				, `environment_name`
				, `tenant_id`
				, `landlord_id`
				, `contractor_id`
				, `mgt_cny_id`
				, `agent_id`
				) 
				VALUES
					(1,'DEV/Staging', 4, 3, 5, 6, 2),
					(2,'Prod', 4, 3, 5, 6, 2),
					(3,'demo/dev', 4, 3, 5, 6, 2)
				;

END $$
DELIMITER ;

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