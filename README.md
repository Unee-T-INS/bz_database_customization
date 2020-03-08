# bz_database_customization:

These are the SQL scripts we need to customize the BZ database for the Unee-T INS environment.

We need to run these scripts in sequence logged in as the root user ([BZDB_ROOT_USERNAME]) for the BZ database.

- `1_customize_categories_and_sub_categories.sql` (see GH issue https://github.com/Unee-T-INS/frontend/issues/21)
- `2_dummy_users_by_environments.sql` (see GH issue https://github.com/Unee-T-INS/frontend/issues/11#issuecomment-575612058)
- `3_replace_the_term_unit_with_policy.sql` (see GH issue https://github.com/Unee-T-INS/frontend/issues/24)
- `4_customize_the_role_types.sql` (see GH issue https://github.com/Unee-T-INS/frontend/issues/20)

## For the DEV/Staging environment:

This is specific to the AWS environment for Unee-T INS DEV/Staging.

### email addresses for seed users

- Make sure that the email address exist for
  - dashboard.administrator DEV
  - temporary.agent DEV
  - temporary.insurer DEV
  - temporary.policyholder DEV
  - temporary.other DEV
  - temporary.hr DEV
- Update the email addresses in the table `profiles`

### lambda calls:

The script has been written for AWS account nber 182387550209 (DEV/Staging for Unee-T INS)
- `5_DEV_add_all_lambda_related_objects_v5.39.2_DEV_Staging.sql`

## For the PROD environment:

This is specific to the AWS environment for Unee-T INS PROD.

### email addresses for seed users

- Make sure that the following email address exist:
  - dashboard.administrator PROD
  - temporary.agent PROD
  - temporary.insurer PROD
  - temporary.policyholder PROD
  - temporary.other PROD
  - temporary.hr PROD
- Update the email addresses in the table `profiles`

### lambda calls:

The script has been written for AWS account nber 846324192534 (DEV/Staging for Unee-T INS)
- `5_PROD_add_all_lambda_related_objects_v5.39.2_PROD.sql`
