CREATE TABLE PRODUCT 
( 
	PRODUCT_CODE	VARCHAR(16) 	PRIMARY KEY, 
	BRAND 			VARCHAR(20)		NOT NULL, 
	WARRANTY 		CHAR(2), 
	PRICE		 	NUMBER(6,2)	NOT NULL,  
    QTY             NUMBER(20) NOT NULL, 
    DISCOUNT        NUMBER(2), 
	CONSTRAINT WARRANTY_CHECK	CHECK(WARRANTY IN ('IT', 'EU')), 
	CONSTRAINT PRICE_VAL 		CHECK(PRICE>0), 
	CONSTRAINT BRAND_VAL 		CHECK(REGEXP_LIKE(BRAND, (*@ '[A-Za-zÃ€-Ã¿'' ]+\$' @*)  )),    
	CONSTRAINT PRODUCT_CODE_VAL 		CHECK(REGEXP_LIKE(PRODUCT_CODE,  (*@ '[A-Za-z0-9 ]+\$' @*) ))     
);


CREATE TABLE ACCOUNT 
(EMAIL VARCHAR(32) 	PRIMARY KEY, 
PASSWORD   VARCHAR(20) 	NOT NULL,  
ACCOUNT_ID CHAR(6)    UNIQUE, 
CONSTRAINT EMAIL_VALID    CHECK(REGEXP_LIKE(EMAIL,  '[A-Za-z0-9._\%+-] 
+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}')), 
CONSTRAINT PASS_VALID       	CHECK(LENGTH(PASSWORD)>=5) 
);


CREATE TABLE CREDIT_CARD 
( 
	CARD_NUM		CHAR(16) 		PRIMARY KEY, 
	SAFETY_CODE 	VARCHAR(4)		NOT NULL, 
	EXPIRING_DATE 	DATE		  	NOT NULL,  
	EMAIL 			VARCHAR(32)		NOT NULL, 
    ACCOUNT_HOLDER CHAR(32) NOT NULL, 
	CONSTRAINT CARD_NUM_VALID			CHECK(REGEXP_LIKE(CARD_NUM, '^[0-9]+$')), 
	CONSTRAINT SAFETY_CODE_VALID 		CHECK(REGEXP_LIKE(SAFETY_CODE, '^[0-9]{3,4}')),  
	CONSTRAINT FK1 FOREIGN KEY (EMAIL) 	REFERENCES ACCOUNT(EMAIL) ON DELETE CASCADE  
);



CREATE TABLE RECIPIENT 
( 
	RECIPIENT_ID 		CHAR(6) 			PRIMARY KEY,  
	EMAIL 				VARCHAR(32)			NOT NULL,  
	NAME				VARCHAR(20)			NOT NULL, 
	SURNAME				VARCHAR(20) 		NOT NULL, 
	TELEPHONE_NUM		VARCHAR(10), 
	ADDRESS 			VARCHAR(40)			NOT NULL, 
	ZIP_CODE 			CHAR(5)				NOT NULL, 
	CITY				VARCHAR(30),  
	CONSTRAINT FK1_RECIPIENT 	FOREIGN KEY (EMAIL) 	REFERENCES ACCOUNT(EMAIL) 	
ON DELETE CASCADE, 
	CONSTRAINT TEL_VALID 		CHECK(LENGTH(TELEPHONE_NUM)>=8), 
	CONSTRAINT NAME_VAL 		CHECK(REGEXP_LIKE(BRAND, (*@ '[A-Za-zÃ€-Ã¿'' ]+\$' @*)  )),    
	CONSTRAINT SURNAME_VAL 		CHECK(REGEXP_LIKE(PRODUCT_CODE,  (*@ '[A-Za-z0-9 ]+\$' @*) )),
	CONSTRAINT CITY_VAL 		CHECK(REGEXP_LIKE(PRODUCT_CODE,  (*@ '[A-Za-z0-9 ]+\$' @*) )),
);

CREATE TABLE DISHWASHER 
( 
 EAN         	VARCHAR2(13) PRIMARY KEY, 
PRODUCT_CODE	VARCHAR2(16), 
ENERGY_CLASS     	VARCHAR2(4) 	 NOT NULL, 
MEASURES         	VARCHAR2(15) 	NOT NULL, 
NUM_OF_PROGRAMS NUMBER(2,0) 	NOT NULL, 
DISPLAY          	VARCHAR2(3)  	NOT NULL, 
NUM_OF_TEMPERATURES  NUMBER(2,0) 	NOT NULL, 
COLOUR CHAR(15), 
 CONSTRAINT FK1_DISHWASHER   	FOREIGN KEY (PRODUCT_CODE) REFERENCES 
PRODUCT(PRODUCT_CODE) ON DELETE CASCADE, 
 CONSTRAINT ENERGY2_VAL           	CHECK(ENERGY_CLASS IN
 ('A+++','A++','A+','A','B','C','D','E','F','G')), 
 CONSTRAINT MEASURES2_VAL         	CHECK(REGEXP_LIKE
(MEASURES,' ^[0-9]{2,3}|X[0-9]{3}|X[0-9]{3}')), 
 CONSTRAINT PROGRAMS_VAL          	CHECK(REGEXP_LIKE
(NUM_OF_PROGRAMS, '[0-9]+$')), 
 CONSTRAINT DISPLAY_VAL           	CHECK(LOWER(DISPLAY) IN ('yes','no')), 
 CONSTRAINT TEMPERATURES_VAL 	 	CHECK(REGEXP_LIKE
(NUM_OF_TEMPERATURES, '[0-9]+$')) 
);


CREATE TABLE FREEZER 
( 
	EAN 			VARCHAR2(13) PRIMARY KEY, 
	PRODUCT_CODE	VARCHAR2(16), 
	ENERGY_CLASS 	VARCHAR2(4)     NOT NULL,  
	MEASURES 		VARCHAR2(15) 	NOT NULL, 
	TYPE			VARCHAR2(10)	NOT NULL, 
	NUM_OF_DRAWERS 	NUMERIC(2,0)		NOT NULL, 
	CAPACITY 		VARCHAR2(5)		NOT NULL, 
	COLOUR CHAR(15), 
 
	CONSTRAINT FK1_FREEZER 		FOREIGN KEY (PRODUCT_CODE) REFERENCES 
PRODUCT(PRODUCT_CODE) ON DELETE CASCADE, 
	CONSTRAINT ENERGY3_VAL		CHECK(ENERGY_CLASS IN 
('A+++','A++','A+','A','B','C','D','E','F','G')), 
	CONSTRAINT MEASURES3_VAL		
CHECK(REGEXP_LIKE(MEASURES,' ^[0-9]{2,3}|X[0-9]{2,3}|X[0-9]{2,3}')), 
	CONSTRAINT TYPE2_VAL			
CHECK(LOWER(TYPE) IN ('upright','chest')), 
	CONSTRAINT DRAWERS_VAL 		
CHECK(REGEXP_LIKE(NUM_OF_DRAWERS, '[0-9]+$')), 
	CONSTRAINT CAPACITY2_VAL		
CHECK(REGEXP_LIKE(CAPACITY,'^[0-9]{3}+L')) 
);

CREATE TABLE FRIDGE 
( 
	EAN 			VARCHAR2(13) PRIMARY KEY, 
	PRODUCT_CODE	VARCHAR2(16), 
	ENERGY_CLASS 	VARCHAR2(4)     NOT NULL,  
	MEASURES 		VARCHAR2(15) 	NOT NULL, 
	FREEZER			VARCHAR2(3)		NOT NULL, 
	NO_FROST		VARCHAR2(3)		NOT NULL, 
	CAPACITY 		VARCHAR2(5)		NOT NULL, 
	WATER_DISPENSER VARCHAR2(3)		NOT NULL, 
	COLOUR CHAR(15), 
	 
	CONSTRAINT FK1_FRIDGE 		FOREIGN KEY (PRODUCT_CODE)
 REFERENCES PRODUCT(PRODUCT_CODE) ON DELETE CASCADE, 
	CONSTRAINT ENERGY_VAL		CHECK(ENERGY_CLASS IN 
('A+++','A++','A+','A','B','C','D','E','F','G')), 
	CONSTRAINT MEASURES_VAL		
CHECK(REGEXP_LIKE(MEASURES,' ^[0-9]{2,3}|X[0-9]{3}|X[0-9]{3}')),  
	CONSTRAINT FREEZER_VAL		CHECK(LOWER(FREEZER) IN ('yes','no')), 
	CONSTRAINT NO_FROST_VAL		CHECK(LOWER(NO_FROST) IN ('yes','no')), 
	CONSTRAINT CAPACITY_VAL		
CHECK(REGEXP_LIKE(CAPACITY,'^ [0-9]{3,3}+L')), 
	CONSTRAINT WATER_VAL		
CHECK(LOWER(WATER_DISPENSER) IN ('yes','no')) 
);

CREATE TABLE HOB 
( 
	EAN 			VARCHAR(13) PRIMARY KEY, 
	PRODUCT_CODE	VARCHAR(16), 
     BURNERS_NUM 	VARCHAR(1)     NOT NULL,  
	MEASURES 		VARCHAR(15) 	NOT NULL, 
	TYPE			VARCHAR(10)	NOT NULL, 
	COVER			VARCHAR(3)		NOT NULL, 
	COLOUR CHAR(15), 
 
	CONSTRAINT FK1_HOB 			FOREIGN KEY (PRODUCT_CODE)
 REFERENCES PRODUCT(PRODUCT_CODE) ON DELETE CASCADE, 
	CONSTRAINT BURNERS2_VAL		CHECK(BURNERS_NUM IN 
('1','2','3','4','5','6')), 
	CONSTRAINT MEASURES5_VAL		
CHECK(REGEXP_LIKE(MEASURES,'^[0-9]{2,3}|X[0-9]{3}')),  
	CONSTRAINT TYPE4_VAL			CHECK(LOWER(TYPE) IN 
('gas','electric','induction')), 
	CONSTRAINT COVER_VAL		CHECK(LOWER(COVER) IN ('yes','no')) 
);

CREATE TABLE OVEN 
( 
 	EAN         	VARCHAR(13) PRIMARY KEY, 
 	PRODUCT_CODE	VARCHAR(16), 
 	MEASURES    	VARCHAR(15) 	NOT NULL, 
 	NUM_OF_PROGRAMS NUMBER(2,0) 	NOT NULL, 
 	TIMER  	      	VARCHAR(3)  	NOT NULL, 
 	TYPE        	VARCHAR(10)      	NOT NULL, 
 	FAN              	VARCHAR(3)  	NOT NULL, 
	COLOUR CHAR(15), 
 	CONSTRAINT FK1_OVEN    	FOREIGN KEY (PRODUCT_CODE) REFERENCES
 PRODUCT(PRODUCT_CODE) ON DELETE CASCADE, 
 	CONSTRAINT MEASURES4_VAL    	
CHECK(REGEXP_LIKE(MEASURES,' ^[0-9]{2,3}|X[0-9]{3}|X[0-9]{3}')), 
 	CONSTRAINT PROGRAMS4_VAL    	CHECK(REGEXP_LIKE(NUM_OF_PROGRAMS, '[0-9]+$')), 
 	CONSTRAINT TIMER4_VAL  	CHECK(LOWER(TIMER) IN ('yes','no')), 
 	CONSTRAINT TYPE3_VAL        	CHECK(LOWER(TYPE) IN ('electric','gas')), 
 	CONSTRAINT FAN_VAL          	CHECK(LOWER(FAN) IN ('yes','no')) 
);

CREATE TABLE STOVE 
( 
 	EAN         	VARCHAR(13) PRIMARY KEY, 
 	PRODUCT_CODE	VARCHAR(16), 
 	BURNERS_NUM 	VARCHAR(1) 	NOT NULL, 
 	MEASURES    	VARCHAR(15) 	NOT NULL, 
 	TYPE        	VARCHAR(10) 	NOT NULL, 
 	OVEN        	VARCHAR(3)  	NOT NULL, 
	COLOUR CHAR(15), 
 	CONSTRAINT FK1_STOVE   	FOREIGN KEY (PRODUCT_CODE) REFERENCES 
PRODUCT(PRODUCT_CODE) ON DELETE CASCADE, 
 	CONSTRAINT BURNERS_VAL      	CHECK(BURNERS_NUM IN ('1','2','3','4','5','6')), 
 	CONSTRAINT TYPE_VAL    	 	CHECK(LOWER(TYPE) IN ('gas','electric')), 
 	CONSTRAINT OVEN_VAL         	CHECK(LOWER(OVEN) IN ('yes','no')) 
);



CREATE TABLE ORDERS
(
    ORDER_ID    NUMBER(6)       PRIMARY KEY,
    EMAIL       VARCHAR2(32),
    ORDER_DATE  TIMESTAMP            NOT NULL,
    CONSTRAINT FK_EMAIL FOREIGN KEY (EMAIL) REFERENCES ACCOUNT(EMAIL) 
ON DELETE CASCADE
);

CREATE TABLE SOLD_ITEMS
(
    ORDER_ID        NUMBER(6),
    PROD_CODE    VARCHAR2(16),
    QUANTITY        NUMBER(20)      NOT NULL,
    CONSTRAINT FK_ORDER_ID          FOREIGN KEY (ORDER_ID) REFERENCES 
ORDERS(ORDER_ID) ON DELETE CASCADE,
    CONSTRAINT FK_PROD_CODE      FOREIGN KEY (PROD_CODE) REFERENCES
 PRODUCT(PRODUCT_CODE),
    CHECK(QUANTITY < 100),
    CONSTRAINT PK_SOLD              PRIMARY KEY     (ORDER_ID, PROD_CODE)
);
