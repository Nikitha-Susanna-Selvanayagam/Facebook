/*HB BASIC DETAILS */
CREATE TABLE IF NOT EXISTS `hb_policy` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT, 
  `LOCAL_POLICY_HOLDER`VARCHAR(120) DEFAULT NULL, 
  `LOCAL_ADDRESS`VARCHAR(120) DEFAULT NULL,
  `POLICY_NUMBER` VARCHAR(50) DEFAULT NULL,
  `INSURANCE_COMPANY` VARCHAR(120) DEFAULT NULL,
  `CURRENCY_ID` INT(11) DEFAULT NULL,
  `EFFECTIVE_DATE` DATETIME DEFAULT NULL,
  `RENEWAL_DATE` DATETIME DEFAULT NULL,
  `NUMBER_OF_CLASSES` INT(11) DEFAULT NULL,
  `TACIT_RENEWAL` BOOLEAN DEFAULT NULL,--dropdown
  `TACIT_RENEWAL_DATE` DATETIME DEFAULT NULL,
  `OPEN_TO_NEW_HIRES`BOOLEAN DEFAULT NULL,--dropdown
  `NEW_ACCT_SETUP_ID` INT(11) DEFAULT NULL,
  `CREATED_BY` INT(11) DEFAULT NULL,
  `CREATED_DATE` DATETIME DEFAULT NULL,
  `ACTIVE_STATUS` BOOLEAN DEFAULT NULL,
  `DELETED_STATUS` BOOLEAN DEFAULT NULL,
  `MODIFIED_BY` INT(11) DEFAULT NULL,
  `MODIFIED_DATE` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `CURRENCY_ID` (`CURRENCY_ID`),
  KEY `NEW_ACCT_SETUP_ID` (`NEW_ACCT_SETUP_ID`),
  KEY `TACIT_RENEWAL` (`TACIT_RENEWAL`),
  KEY `OPEN_TO_NEW_HIRES` (`OPEN_TO_NEW_HIRES`),
  CONSTRAINT `FK_hb_policy_currency` FOREIGN KEY (`CURRENCY_ID`) REFERENCES `currency_master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_hb_policy_new_acct_setup` FOREIGN KEY (`NEW_ACCT_SETUP_ID`) REFERENCES `new_account_setup` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_hb_policy_tacit_renewal` FOREIGN KEY (`TACIT_RENEWAL`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_hb_policy_open_to_new_hires` FOREIGN KEY (`OPEN_TO_NEW_HIRES`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `coverage_db_pension` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown
   `SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown
   `SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
   `STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown
   `NORMAL_RETIREMENT_AGE` INT (11) DEFAULT NULL,
   `EARLY_RETIREMENT_AGE` INT (11) DEFAULT NULL,
   `PENSIONABLE_EARNINGS_DEFINITION` INT (11) DEFAULT NULL,--dropdown
   `PENSIONABLE_EARNINGS_DEFINITION_OTHER` VARCHAR(50) DEFAULT NULL, 
   `BENEFIT_FORMULA_AT_NORMAL_RETIREMENT` VARCHAR(50) DEFAULT NULL,
   `BENEFIT_FORMULA_AT_EARLY_RETIREMENT` VARCHAR(50) DEFAULT NULL,
   `DEATH_IN_SERVICE_BENEFITS` VARCHAR(50) DEFAULT NULL,
   `DISABILITY_BENEFITS` VARCHAR(50) DEFAULT NULL,
   `BENEFIT_FINANCED_TYPE` INT(11) DEFAULT NULL,--dropdown
   `EMPLOYEE_CONTRIBUTIONS_TYPE` INT(11) DEFAULT NULL,--dropdown
   `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown
   `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE
   `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
   `ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
   `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
   `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
   `TAXES`DECIMAL(10,2) DEFAULT NULL,
   `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
   `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
   `COMMENTS` VARCHAR(100) DEFAULT NULL,
   `HB_POLICY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
   KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
   KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
   KEY `PENSIONABLE_EARNINGS_DEFINITION` (`PENSIONABLE_EARNINGS_DEFINITION`),
   KEY `BENEFIT_FINANCED_TYPE` (`BENEFIT_FINANCED_TYPE`),
   KEY `EMPLOYEE_CONTRIBUTIONS_TYPE` (`EMPLOYEE_CONTRIBUTIONS_TYPE`),
   KEY `EMPLOYEE_CONTRIBUTIONS_EXISTS` (`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
   KEY `CONTRIBUTIONS_MANDATORY` (`CONTRIBUTIONS_MANDATORY`),
   KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
   CONSTRAINT `FK_db_pension_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_pensionable_earnings_definition` FOREIGN KEY (`PENSIONABLE_EARNINGS_DEFINITION`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_benefit_financed_type` FOREIGN KEY (`BENEFIT_FINANCED_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_employee_contributions_type` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_employee_contributions_exists` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_EXISTS`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_employee_contributions_mandatory` FOREIGN KEY (`CONTRIBUTIONS_MANDATORY`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `coverage_db_pension_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `CREATED_DATE` DATETIME DEFAULT NULL,
   `FILE_NAME` VARCHAR(50) DEFAULT NULL,
   `DELETED_STATUS` BOOLEAN DEFAULT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `CATEGORY_ID` INT(11) DEFAULT NULL,
   `COVERAGE_DB_PENSION_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   KEY `COVERAGE_DB_PENSION_ID` (`COVERAGE_DB_PENSION_ID`),
   CONSTRAINT `FK_db_pension` FOREIGN KEY (`COVERAGE_DB_PENSION_ID`) REFERENCES `coverage_db_pension` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_db_pension_attachments` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `coverage_dc_pension` (
 `ID` INT(11) NOT NULL AUTO_INCREMENT,
 `EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown
 `SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown
 `SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
 `STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown
 `NORMAL_RETIREMENT_AGE` INT (11) DEFAULT NULL,
 `EARLY_RETIREMENT_AGE` INT (11) DEFAULT NULL,
 `PENSIONABLE_EARNINGS_DEFINITION` INT (11) DEFAULT NULL,--dropdown
 `PENSIONABLE_EARNINGS_DEFINITION_OTHER` VARCHAR(50) DEFAULT NULL, 
 `BENEFIT_FORMULA_AT_NORMAL_RETIREMENT` VARCHAR(50) DEFAULT NULL,
 `BENEFIT_FORMULA_AT_EARLY_RETIREMENT` VARCHAR(50) DEFAULT NULL,
 `DEATH_IN_SERVICE_BENEFITS` VARCHAR(50) DEFAULT NULL,
 `DISABILITY_BENEFITS` VARCHAR(50) DEFAULT NULL,
 `EMPLOYEE_CONTRIBUTIONS_TYPE` INT(11) DEFAULT NULL,--dropdown
 `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown
 `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE
 `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
 `ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
 `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
 `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
 `TAXES`DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
 `COMMENTS` VARCHAR(100) DEFAULT NULL,
 `HB_POLICY_ID` INT(11) DEFAULT NULL,
 PRIMARY KEY (`id`),
 KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
 KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
 KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
 KEY `PENSIONABLE_EARNINGS_DEFINITION` (`PENSIONABLE_EARNINGS_DEFINITION`),
 KEY `BENEFIT_FINANCED_TYPE` (`BENEFIT_FINANCED_TYPE`),
 KEY `EMPLOYEE_CONTRIBUTIONS_TYPE` (`EMPLOYEE_CONTRIBUTIONS_TYPE`),
 KEY `EMPLOYEE_CONTRIBUTIONS_EXISTS` (`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
 KEY `CONTRIBUTIONS_MANDATORY` (`CONTRIBUTIONS_MANDATORY`),
 KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
 CONSTRAINT `FK_dc_pension_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_pensionable_earnings_definition` FOREIGN KEY (`PENSIONABLE_EARNINGS_DEFINITION`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_employee_contributions_type` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_employee_contributions_exists` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_EXISTS`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_employee_contributions_mandatory` FOREIGN KEY (`CONTRIBUTIONS_MANDATORY`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_dc_pension_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_dc_pension_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `CREATED_DATE` DATETIME DEFAULT NULL,
   `FILE_NAME` VARCHAR(50) DEFAULT NULL,
   `DELETED_STATUS` BOOLEAN DEFAULT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `CATEGORY_ID` INT(11) DEFAULT NULL,
   `COVERAGE_DC_PENSION_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   KEY `COVERAGE_DC_PENSION_ID` (`COVERAGE_DC_PENSION_ID`),
   CONSTRAINT `FK_dc_pension` FOREIGN KEY (`COVERAGE_DC_PENSION_ID`) REFERENCES `coverage_dc_pension` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_dc_pension_attachments_master` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_life` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown
  `SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown
  `SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
  `STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown
  `FREECOVER_NO_EVIDENCE_GUARANTEED_ISSUE_LIMIT`INT(11) DEFAULT NULL,
  `MAXIMUM_SUM_INSURED`INT(11) DEFAULT NULL,
  `DEATH_BENEFIT`INT(11) NOT NULL,--dropdown
  `DEPENDENT_LIFE`INT(11) NOT NULL,--dropdown
  `ACCIDENTAL_DEATH_AND_DISMEMBERMENT`VARCHAR(50) DEFAULT NULL,
  `TOTAL_PERMANENT_DISABILITY`INT(11) NOT NULL,--dropdown
  `MEDICAL_RIDER`INT(11) NOT NULL,--dropdown
  `BENEFIT_OTHER`VARCHAR(50) DEFAULT NULL,
  `PLAN_FINANCED_TYPE` INT(11) DEFAULT NULL,--dropdown
 `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown
 `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE
 `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
  `PREMIUM_DEATH_BENEFIT`INT(11) NOT NULL,--dropdown
  `PREMIUM_DEPENDENT_LIFE`INT(11) NOT NULL,--dropdown
  `PREMIUM_ACCIDENTAL_DEATH_AND_DISMEMBERMENT`INT(11) NOT NULL,--dropdown
  `PREMIUM_TOTAL_PERMANENT_DISABILITY`INT(11) NOT NULL,--dropdown
  `PREMIUM_MEDICAL_RIDER`VARCHAR(50) DEFAULT NULL,
  `PREMIUM_OTHER`VARCHAR(50) DEFAULT NULL,
`ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
 `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
 `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
 `TAXES`DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
 `COMMENTS` VARCHAR(100) DEFAULT NULL,
  `HB_POLICY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
   KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
   KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
   KEY`DEATH_BENEFIT`(`DEATH_BENEFIT`),
   KEY`DEPENDENT_LIFE`(`DEPENDENT_LIFE`),
   KEY`TOTAL_PERMANENT_DISABILITY`(`TOTAL_PERMANENT_DISABILITY`),
   KEY`MEDICAL_RIDER`(`MEDICAL_RIDER`),
   KEY`PLAN_FINANCED_TYPE`(`PLAN_FINANCED_TYPE`),
   KEY`EMPLOYEE_CONTRIBUTIONS_EXISTS`(`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
   KEY`CONTRIBUTIONS_MANDATORY`(`CONTRIBUTIONS_MANDATORY`),
   KEY`PREMIUM_DEATH_BENEFIT`(`PREMIUM_DEATH_BENEFIT`),
   KEY`PREMIUM_DEPENDENT_LIFE`(`PREMIUM_DEPENDENT_LIFE`),
   KEY`PREMIUM_ACCIDENTAL_DEATH_AND_DISMEMBERMENT`(`PREMIUM_ACCIDENTAL_DEATH_AND_DISMEMBERMENT`),
   KEY`PREMIUM_TOTAL_PERMANENT_DISABILITY`(`PREMIUM_TOTAL_PERMANENT_DISABILITY`),
   KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
   CONSTRAINT `FK_life_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_life_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `FK_life_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_death_benefit` FOREIGN KEY (`DEATH_BENEFIT`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_dependent_life` FOREIGN KEY (`DEPENDENT_LIFE`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_total_permanent_disability` FOREIGN KEY (`TOTAL_PERMANENT_DISABILITY`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_medical_rider` FOREIGN KEY (`MEDICAL_RIDER`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_premium_accidental_premium_death_benefit` FOREIGN KEY (`PREMIUM_DEATH_BENEFIT`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_premium_accidental_death_and_dismemberment` FOREIGN KEY (`PREMIUM_ACCIDENTAL_DEATH_AND_DISMEMBERMENT`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_premium_total_permanent_disability` FOREIGN KEY (`PREMIUM_TOTAL_PERMANENT_DISABILITY`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life_life_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_life_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `CREATED_DATE` DATETIME DEFAULT NULL,
   `FILE_NAME` VARCHAR(50) DEFAULT NULL,
   `DELETED_STATUS` BOOLEAN DEFAULT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `CATEGORY_ID` INT(11) DEFAULT NULL,
   `COVERAGE_LIFE_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`ID`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   KEY `COVERAGE_LIFE_ID` (`COVERAGE_LIFE_ID`),
   CONSTRAINT `FK_life_attachments_master_category` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_life` FOREIGN KEY (`COVERAGE_LIFE_ID`) REFERENCES `coverage_life` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_personal_accident` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown*
  `SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown*
  `SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
  `STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown*
  `FREECOVER_NO_EVIDENCE_GUARANTEED_ISSUE_LIMIT`INT(11) DEFAULT NULL,
  `MAXIMUM_SUM_INSURED`INT(11) DEFAULT NULL,
  `ACCIDENTAL_DEATH_BENEFIT`INT(11) DEFAULT NULL,--dropdown
  `ACCIDENTAL_DISMEMBERMENT`VARCHAR(50) DEFAULT NULL,
  `TOTAL_PERMANENT_DISABILITY`INT(11) DEFAULT NULL,--dropdown
  `TOTAL_TEMPORARY_DISABILITY`VARCHAR(50) DEFAULT NULL,
  `ACCIDENTAL_MEDICAL`VARCHAR(50) DEFAULT NULL,
  `BENEFIT_OTHER`VARCHAR(50) DEFAULT NULL,
`PLAN_FINANCED_TYPE` INT(11) DEFAULT NULL,--dropdown*
 `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown*
 `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE*
 `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
  `PREMIUM_ACCIDENTAL_DEATH_BENEFIT`INT(11) DEFAULT NULL,--dropdown
  `PREMIUM_ACCIDENTAL_DISMEMBERMENT`INT(11) DEFAULT NULL,--dropdown
  `PREMIUM_TOTAL_PERMANENT_DISABILITY`INT(11) DEFAULT NULL,--dropdown
  `PREMIUM_TOTAL_TEMPORARY_DISABILITY`INT(11) DEFAULT NULL,--dropdown
  `PREMIUM_ACCIDENTAL_MEDICAL`VARCHAR(50) DEFAULT NULL,
  `PREMIUM_OTHER`VARCHAR(50) DEFAULT NULL,
  `ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
 `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
 `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
 `TAXES`DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
 `COMMENTS` VARCHAR(100) DEFAULT NULL,
   `HB_POLICY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`ID`),
   KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
   KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
   KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
   KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
   KEY `PLAN_FINANCED_TYPE` (`PLAN_FINANCED_TYPE`),
   KEY `EMPLOYEE_CONTRIBUTIONS_EXISTS` (`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
   KEY `CONTRIBUTIONS_MANDATORY` (`CONTRIBUTIONS_MANDATORY`),
   KEY `ACCIDENTAL_DEATH_BENEFIT`(`ACCIDENTAL_DEATH_BENEFIT`),
   KEY `TOTAL_PERMANENT_DISABILITY`(`TOTAL_PERMANENT_DISABILITY`),
   KEY `PREMIUM_ACCIDENTAL_DEATH_BENEFIT`(`PREMIUM_ACCIDENTAL_DEATH_BENEFIT`),
   KEY `PREMIUM_ACCIDENTAL_DISMEMBERMENT`(`PREMIUM_ACCIDENTAL_DISMEMBERMENT`),
   KEY `PREMIUM_TOTAL_PERMANENT_DISABILITY`(`PREMIUM_TOTAL_PERMANENT_DISABILITY`),
   KEY `PREMIUM_TOTAL_TEMPORARY_DISABILITY`(`PREMIUM_TOTAL_TEMPORARY_DISABILITY`),
   CONSTRAINT`FK_personal_accident_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accidental_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT`FK_personal_accidental_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accidental_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accidental_plan_financed_type` FOREIGN KEY (`PLAN_FINANCED_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accidental_employee_contributions_exists` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_EXISTS`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accidental_contributions_mandatory` FOREIGN KEY (`CONTRIBUTIONS_MANDATORY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accidental_death_benefit` FOREIGN KEY (`ACCIDENTAL_DEATH_BENEFIT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accident_total_permanent_disability`FOREIGN KEY (`TOTAL_PERMANENT_DISABILITY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accident_premium_accidental_death_benefit`FOREIGN KEY (`PREMIUM_ACCIDENTAL_DEATH_BENEFIT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accident_premium_accidental_dismemberment`FOREIGN KEY (`PREMIUM_ACCIDENTAL_DISMEMBERMENT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accident_premium_total_permanent_disability`FOREIGN KEY (`PREMIUM_TOTAL_PERMANENT_DISABILITY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT`FK_personal_accident_premium_total_temporary_disability`FOREIGN KEY (`PREMIUM_TOTAL_TEMPORARY_DISABILITY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_personal_accident_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `COVERAGE_ACCIDENT_ID` INT(11) NOT NULL,
   `CATEGORY_ID` INT(11) NOT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `FILE_NAME` VARCHAR(200) DEFAULT NULL,
   `CREATED_DATE` DATETIME NOT NULL, 
   `DELETED_STATUS` BOOLEAN NOT NULL,
   PRIMARY KEY (`ID`),
   KEY `COVERAGE_ACCIDENT_ID` (`COVERAGE_ACCIDENT_ID`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   CONSTRAINT `FK_personal_accident` FOREIGN KEY (`COVERAGE_ACCIDENT_ID`) REFERENCES `coverage_accident` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_personal_accident_attachments_master_category` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;


  CREATE TABLE IF NOT EXISTS `coverage_short_term_disability` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown*
  `SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown*
  `SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
  `STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown*
  `FREECOVER_NO_EVIDENCE_GUARANTEED_ISSUE_LIMIT`INT(11) DEFAULT NULL,
  `MAXIMUM_SUM_INSURED`INT(11) DEFAULT NULL,
   `SHORT_TERM_SUM_INSURED`INT(11) DEFAULT NULL,
   `WAITING_PERIOD_BEFORE_BENEFITS_COMMENCE`INT(11) DEFAULT NULL,
   `BENEFIT_PAYMENT_DURATION`INT(11) DEFAULT NULL,
 `PLAN_FINANCED_TYPE` INT(11) DEFAULT NULL,--dropdown*
 `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown*
 `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE*
 `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
  `PREMIUM_RATES`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE*
`ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
 `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
 `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
 `TAXES`DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
 `COMMENTS` VARCHAR(100) DEFAULT NULL,
   `HB_POLICY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`ID`),
   KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
    KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
   KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
   KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
   KEY `SHORT_TERM_SUM_INSURED` (`SHORT_TERM_SUM_INSURED`),
   KEY `WAITING_PERIOD_BEFORE_BENEFITS_COMMENCE` (`WAITING_PERIOD_BEFORE_BENEFITS_COMMENCE`),
    KEY `PLAN_FINANCED_TYPE` (`PLAN_FINANCED_TYPE`),
   KEY `EMPLOYEE_CONTRIBUTIONS_EXISTS` (`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
   KEY `CONTRIBUTIONS_MANDATORY` (`CONTRIBUTIONS_MANDATORY`),
   KEY `BENEFIT_PAYMENT_DURATION` (`BENEFIT_PAYMENT_DURATION`),
   KEY `PREMIUM_RATES` (`PREMIUM_RATES`),
CONSTRAINT `FK_short_term_disability_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_short_term_disability_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_short_term_disability_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_short_term_disability_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `FK_short_term_disability_sum_insurede` FOREIGN KEY (`SHORT_TERM_SUM_INSURED`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `FK_short_term_disability_waiting_period_before_benefits_commence` FOREIGN KEY (`WAITING_PERIOD_BEFORE_BENEFITS_COMMENCE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_short_term_disability_plan_financed_type` FOREIGN KEY (`PLAN_FINANCED_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_short_term_disability_employee_contributions_exists` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_EXISTS`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_short_term_disability_contributions_mandatory` FOREIGN KEY (`CONTRIBUTIONS_MANDATORY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `FK_short_term_disability_payment_duration` FOREIGN KEY (`BENEFIT_PAYMENT_DURATION`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
CONSTRAINT`FK_short_term_disability_premium_rates` FOREIGN KEY (`PREMIUM_RATES`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,

 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 CREATE TABLE IF NOT EXISTS `coverage_short_term_disability_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `CREATED_DATE` DATETIME DEFAULT NULL,
   `FILE_NAME` VARCHAR(50) DEFAULT NULL,
   `DELETED_STATUS` BOOLEAN DEFAULT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `CATEGORY_ID` INT(11) DEFAULT NULL,
   `COVERAGE_SHORT_TERM_DISABILITY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`ID`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   KEY `COVERAGE_SHORT_TERM_DISABILITY_ID` (`COVERAGE_SHORT_TERM_DISABILITY_ID`),
   CONSTRAINT `FK_short_term_disability_attachments_master_category` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_short_term_disability` FOREIGN KEY (`COVERAGE_SHORT_TERM_DISABILITY_ID`) REFERENCES `coverage_short_term_disability` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_long_term_disability` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown*
  `SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown*
  `SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
  `STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown*
   `FREECOVER_NO_EVIDENCE_GUARANTEED_ISSUE_LIMIT`INT(11) DEFAULT NULL,
   `MAXIMUM_SUM_INSURED`INT(11) DEFAULT NULL,
   `LONG_TERM_SUM_INSURED`INT(11) DEFAULT NULL --DROPDOWN
   `ELIMINATION_PERIOD`INT(11) DEFAULT NULL--DROPDOWN
   `BENEFIT_PAYMENT_DURATION`INT(11) DEFAULT NULL--DROPDOWN
   `DISABILITY_DEFINITION`INT(11) DEFAULT NULL--DROPDOWN
    `PLAN_FINANCED_TYPE` INT(11) DEFAULT NULL,--dropdown*
 `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown*
 `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE*
 `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
  `PREMIUM_RATES`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE*
`ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
 `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
 `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
 `TAXES`DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
 `COMMENTS` VARCHAR(100) DEFAULT NULL,
   `HB_POLICY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
   KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
   KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
   KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
   KEY `LONG_TERM_SUM_INSURED` (`LONG_TERM_SUM_INSURED`),
   KEY `ELIMINATION_PERIOD` (`ELIMINATION_PERIOD`),
   KEY `BENEFIT_PAYMENT_DURATION` (`BENEFIT_PAYMENT_DURATION`),
   KEY `DISABILITY_DEFINITION` (`DISABILITY_DEFINITION`),
    KEY `PLAN_FINANCED_TYPE` (`PLAN_FINANCED_TYPE`),
   KEY `EMPLOYEE_CONTRIBUTIONS_EXISTS` (`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
   KEY `CONTRIBUTIONS_MANDATORY` (`CONTRIBUTIONS_MANDATORY`),
   CONSTRAINT `FK_long_term_disability_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT`FK_long_term_disability_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_long_term_disability_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_long_term_disability_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_long_term_disability_long_term_sum_insured` FOREIGN KEY (`LONG_TERM_SUM_INSURED`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_long_term_disability_elimination_period` FOREIGN KEY (`ELIMINATION_PERIOD`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT`FK_long_term_disability_plan_financed_type` FOREIGN KEY (`PLAN_FINANCED_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_long_term_disability_employee_contributions_exists` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_EXISTS`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_long_term_disability_contributions_mandatory` FOREIGN KEY (`CONTRIBUTIONS_MANDATORY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_long_term_disability_premium_rates` FOREIGN KEY (`PREMIUM_RATES`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_long_term_disability_benefit_payment_duration` FOREIGN KEY (`BENEFIT_PAYMENT_DURATION`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_long_term_disability_definition` FOREIGN KEY (`DISABILITY_DEFINITION`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE IF NOT EXISTS `coverage_long_term_disability_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `CREATED_DATE` DATETIME DEFAULT NULL,
   `FILE_NAME` VARCHAR(50) DEFAULT NULL,
   `DELETED_STATUS` BOOLEAN DEFAULT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `CATEGORY_ID` INT(11) DEFAULT NULL,
   `COVERAGE_LONG_TERM_DISABILITY_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`ID`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   KEY `COVERAGE_LONG_TERM_DISABILITY_ID` (`COVERAGE_LONG_TERM_DISABILITY_ID`),
   CONSTRAINT `FK_long_term_disability_attachments_master_category` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_long_term_disability` FOREIGN KEY (`COVERAGE_LONG_TERM_DISABILITY_ID`) REFERENCES `coverage_long_term_disability` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `coverage_critical_illness` (
`ID` INT(11) NOT NULL AUTO_INCREMENT,
`EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown*
`SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown*
`SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
`STATUTORY_BENEFIT` BOOLEAN DEFAULT NULL, --dropdown*
`FREECOVER_NO_EVIDENCE_GUARANTEED_ISSUE_LIMIT`INT(11) DEFAULT NULL,
`MAXIMUM_SUM_INSURED`INT(11) DEFAULT NULL,
`CRITICAL_ILLNESS_SUM_INSURED`INT(11) DEFAULT NULL --DROPDOWN
`PLAN_FINANCED_TYPE` INT(11) DEFAULT NULL,--dropdown*
 `EMPLOYEE_CONTRIBUTIONS_EXISTS`INT(11) DEFAULT NULL,--dropdown*
 `CONTRIBUTIONS_MANDATORY`INT(11) DEFAULT NULL,--dropdown TO HB MULTI TABLE*
 `CONTRIBUTIONS_VOLUNTARY` VARCHAR(50) DEFAULT NULL,
`PREMIUM_RATES` VARCHAR(50) DEFAULT NULL,
`ENROLLED_EMPLOYEE_HEADCOUNT`INT (11) DEFAULT NULL,
 `PREMIUM_BEFORE_TAX`DECIMAL(10,2) DEFAULT NULL,
 `POLICY_FEES`DECIMAL(10,2) DEFAULT NULL,
 `TAXES`DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_PREMIUM` DECIMAL(10,2) DEFAULT NULL,
 `TOTAL_ANNUAL_EMPLOYER_CONTRIBUTIONS`DECIMAL(10,2) DEFAULT NULL,
 `COMMENTS` VARCHAR(100) DEFAULT NULL,
 PRIMARY KEY (`id`),
   KEY `HB_POLICY_ID` (`HB_POLICY_ID`),
   KEY `EMPLOYEE_ELIGIBILITY_TYPE` (`EMPLOYEE_ELIGIBILITY_TYPE`),
   KEY `SPECIFIED_EMPLOYEE_TYPE` (`SPECIFIED_EMPLOYEE_TYPE`),
   KEY `STATUTORY_BENEFIT` (`STATUTORY_BENEFIT`),
   KEY `CRITICAL_ILLNESS_SUM_INSURED` (`CRITICAL_ILLNESS_SUM_INSURED`),
    KEY `PLAN_FINANCED_TYPE` (`PLAN_FINANCED_TYPE`),
   KEY `EMPLOYEE_CONTRIBUTIONS_EXISTS` (`EMPLOYEE_CONTRIBUTIONS_EXISTS`),
   KEY `CONTRIBUTIONS_MANDATORY` (`CONTRIBUTIONS_MANDATORY`),
   CONSTRAINT `FK_critical_illness_hb_policy` FOREIGN KEY (`HB_POLICY_ID`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT`FK_critical_illness_employee_eligibility_type` FOREIGN KEY (`EMPLOYEE_ELIGIBILITY_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_critical_illness_specified_employee_type` FOREIGN KEY (`SPECIFIED_EMPLOYEE_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_critical_illness_statutory_benefit` FOREIGN KEY (`STATUTORY_BENEFIT`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_critical_illness_critical_illness_sum_insured` FOREIGN KEY (`CRITICAL_ILLNESS_SUM_INSURED`) REFERENCES `hb_policy` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT`FK_critical_illness_plan_financed_type` FOREIGN KEY (`PLAN_FINANCED_TYPE`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_critical_illness_employee_contributions_exists` FOREIGN KEY (`EMPLOYEE_CONTRIBUTIONS_EXISTS`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT`FK_critical_illness_contributions_mandatory` FOREIGN KEY (`CONTRIBUTIONS_MANDATORY`) REFERENCES `master` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `coverage_critical_illness_attachments` (
   `ID` INT(11) NOT NULL AUTO_INCREMENT,
   `CREATED_DATE` DATETIME DEFAULT NULL,
   `FILE_NAME` VARCHAR(50) DEFAULT NULL,
   `DELETED_STATUS` BOOLEAN DEFAULT NULL,
   `YEAR` VARCHAR(50) DEFAULT NULL,
   `CATEGORY_ID` INT(11) DEFAULT NULL,
   `COVERAGE_CRITICAL_ILLNESS_ID` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `CATEGORY_ID` (`CATEGORY_ID`),
   KEY `COVERAGE_CRITICAL_ILLNESS_ID` (`COVERAGE_CRITICAL_ILLNESS_ID`),
   CONSTRAINT `FK_critical_illness_attachments` FOREIGN KEY (`category_id`) REFERENCES `master` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FK_critical_illness` FOREIGN KEY (`coverage_critical_illness_id`) REFERENCES `coverage_critical_illness` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `coverage_medical` (
`ID` INT(11) NOT NULL AUTO_INCREMENT,
`EMPLOYEE_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown*
`SPECIFIED_EMPLOYEE_TYPE`INT (11) DEFAULT NULL, --dropdown*
`SPECIFIED_EMPLOYEE_TYPE_OTHER`VARCHAR(50) DEFAULT NULL,
`DEPENDENTS_ELIGIBILITY_TYPE`INT (11) DEFAULT NULL, --dropdown*
`DEPENDENTS_ELIGIBILITY_EXISTS`INT (11) DEFAULT NULL, --dropdown*
`DEPENDENTS_ELIGIBILITY_OTHER`INT (11) DEFAULT NULL, --dropdown*
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;