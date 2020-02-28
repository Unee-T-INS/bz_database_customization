# This update allows us to replace the term 'unit' with the term 'policy' when an invitation is sent
# See GH issue: https://github.com/Unee-T-INS/frontend/issues/24
#
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
	SET @this_script = 'replace_the_term_unit_with_policy';
#
#
###############################
#
# We have everything we need
#
###############################

DROP PROCEDURE IF EXISTS finalize_invitation_to_a_case;
DELIMITER $$
CREATE PROCEDURE finalize_invitation_to_a_case()
SQL SECURITY INVOKER
BEGIN
	
	# Add a comment to inform users that the invitation has been processed.
	# WARNING - This should happen AFTER the invitation is processed in the MEFE API.

	# We record the name of this procedure for future debugging and audit_log
		SET @script = 'PROCEDURE - finalize_invitation_to_a_case';
		SET @timestamp = NOW();
	
	# We add a new comment to the case.
		INSERT INTO `longdescs`
			(`bug_id`
			, `who`
			, `bug_when`
			, `thetext`
			)
			VALUES
			(@bz_case_id
			, @creator_bz_id
			, @timestamp
			, CONCAT ('An invitation to collaborate on this case has been sent to '
				, @user_role_type_name 
				, ' for this policy'
				)
			)
			;
		# Log the actions of the script.
			SET @script_log_message = CONCAT('A message has been added to the case #'
										, @bz_case_id
										, ' to inform users that an inviation has been sent'
										)
										;
				
			INSERT INTO `ut_script_log`
					(`datetime`
					, `script`
					, `log`
					)
					VALUES
					(@timestamp, @script, @script_log_message)
					;
			
			SET @script_log_message = NULL;

	# Update the table 'ut_data_to_add_user_to_a_case' so that we record what we have done
		INSERT INTO `ut_data_to_add_user_to_a_case`
			( `mefe_invitation_id`
			, `mefe_invitor_user_id`
			, `bzfe_invitor_user_id`
			, `bz_user_id`
			, `bz_case_id`
			, `bz_created_date`
			, `comment`
			)
		VALUES
			(@mefe_invitation_id
			, @mefe_invitor_user_id
			, @creator_bz_id
			, @bz_user_id
			, @bz_case_id
			, @timestamp
			, CONCAT ('inserted in BZ with the script \''
					, @script
					, '\'\r\ '
					, IFNULL(`comment`, '')
					)
			)
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
		, @the_timestamp
		, @this_script
		, @comment_update_schema_version
		)
		;
