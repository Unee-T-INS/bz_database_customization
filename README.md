# bz_database_customization:

These are the SQL scripts we need to customize the BZ database for the Unee-T INS environment.

We need to run these scripts in sequence logged in as the root user ([BZDB_ROOT_USERNAME]) for the BZ database.

- 1_customize_categories_and_sub_categories.sql
- 2_dummy_users_by_environments.sql
- 3_replace_the_term_unit_with_policy.sql

## For the DEV/Staging environment:

This is specific to the AWS environment for Unee-T INS DEV/Staging.
The script has been written for AWS account nber 182387550209 (DEV/Staging for Unee-T INS)
- 4_DEV_add_all_lambda_related_objects_v5.39.2_DEV_Staging.sql

## For the PROD environment:

This is specific to the AWS environment for Unee-T INS PROD.
The script has been written for AWS account nber 846324192534 (DEV/Staging for Unee-T INS)
- 4_PROD_add_all_lambda_related_objects_v5.39.2_PROD.sql
