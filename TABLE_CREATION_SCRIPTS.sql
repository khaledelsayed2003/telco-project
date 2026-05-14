BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE monthly_stats CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE customers CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE tariffs CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE tariffs (
   tariff_id    NUMBER(10,0)       NOT NULL,
   name         VARCHAR2(100 CHAR)  NOT NULL,
   monthly_fee  NUMBER(10,2)        NOT NULL,
   data_limit   NUMBER(12,2)        NOT NULL,
   minute_limit NUMBER(10,0)        NOT NULL,
   sms_limit    NUMBER(10,0)        NOT NULL,
   CONSTRAINT pk_tariffs PRIMARY KEY (tariff_id),
   CONSTRAINT uk_tariffs_name UNIQUE (name),
   CONSTRAINT ck_tariffs_fee CHECK (monthly_fee >= 0),
   CONSTRAINT ck_tariffs_data CHECK (data_limit >= 0),
   CONSTRAINT ck_tariffs_minutes CHECK (minute_limit >= 0),
   CONSTRAINT ck_tariffs_sms CHECK (sms_limit >= 0)
);

COMMENT ON TABLE tariffs IS 'Available telecom tariff/package definitions.';
COMMENT ON COLUMN tariffs.data_limit IS 'Monthly data limit in MB.';

CREATE TABLE customers (
   customer_id NUMBER(10,0)       NOT NULL,
   name        VARCHAR2(100 CHAR)  NOT NULL,
   city        VARCHAR2(100 CHAR)  NOT NULL,
   signup_date DATE                NOT NULL,
   tariff_id   NUMBER(10,0)       NOT NULL,
   CONSTRAINT pk_customers PRIMARY KEY (customer_id),
   CONSTRAINT fk_customers_tariff
      FOREIGN KEY (tariff_id) REFERENCES tariffs (tariff_id)
);

COMMENT ON TABLE customers IS 'Customer master data imported from CUSTOMERS.csv.';
COMMENT ON COLUMN customers.signup_date IS 'Original CSV date parsed with DD/MM/YYYY format.';

CREATE INDEX idx_customers_tariff ON customers (tariff_id);
CREATE INDEX idx_customers_signup ON customers (signup_date);
CREATE INDEX idx_customers_city ON customers (city);

CREATE TABLE monthly_stats (
   id             NUMBER(10,0)      NOT NULL,
   customer_id    NUMBER(10,0)      NOT NULL,
   data_usage     NUMBER(12,2)      NOT NULL,
   minute_usage   NUMBER(10,0)      NOT NULL,
   sms_usage      NUMBER(10,0)      NOT NULL,
   payment_status VARCHAR2(20 CHAR) NOT NULL,
   CONSTRAINT pk_monthly_stats PRIMARY KEY (id),
   CONSTRAINT uk_monthly_stats_customer UNIQUE (customer_id),
   CONSTRAINT fk_monthly_stats_customer
      FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
   CONSTRAINT ck_monthly_stats_data CHECK (data_usage >= 0),
   CONSTRAINT ck_monthly_stats_minutes CHECK (minute_usage >= 0),
   CONSTRAINT ck_monthly_stats_sms CHECK (sms_usage >= 0),
   CONSTRAINT ck_monthly_stats_pay_status
      CHECK (payment_status IN ('PAID', 'LATE', 'UNPAID'))
);

COMMENT ON TABLE monthly_stats IS 'Current-month usage and payment status rows. Some customers are intentionally missing.';
COMMENT ON COLUMN monthly_stats.data_usage IS 'Current-month data usage in MB.';

CREATE INDEX idx_monthly_status ON monthly_stats (payment_status);
CREATE INDEX idx_monthly_usage ON monthly_stats (data_usage, minute_usage, sms_usage);
