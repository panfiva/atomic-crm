-- Requires 2 sales people added via Users menu in the application web UI

INSERT INTO "public"."materials" ("id", "name", "active") VALUES
	(2, 'Copper', true),
	(3, 'Lead', true),
	(4, 'HONEY', true),
	(5, 'STAINLESS STEEL', true),
	(1, 'Aluminum', true);


INSERT INTO "public"."commodities" ("id", "material_id", "name", "active") VALUES
	(2, 2, 'BERRY', true),
	(3, 2, 'HONEY', true),
	(1, 2, 'BARLEY', true),
	(4, 2, 'OCEAN', true),
	(5, 2, 'TALK', true),
	(6, 1, 'TENSE', true),
	(7, 1, 'UBC', true),
	(8, 1, 'PAINTED SIDING', true),
	(9, 1, '6061 EXTRUSION', true),
	(10, 1, '6063 EXTRUSION', true),
	(11, 1, '6061 SPC', true),
	(12, 2, 'TALK FE', true),
	(13, 1, '356 AUTO WHEELS CLEAN', true),
	(14, 1, '356 AUTO WHEELS FE', true),
	(15, 1, 'OLD SHEET 2%', true),
	(16, 1, 'ALUMINUM RADIATORS CLEAN', true),
	(17, 1, 'LITHO', true),
	(18, 5, 'SS 304', true),
	(19, 5, 'SS 316', true),
	(20, 1, 'MLC', true),
	(21, 1, 'HG TURNINGS', true),
	(22, 1, 'MIXED TURNINGS', true),
	(23, 1, 'MIXED TURNINGS PUCKED', true),
	(24, 1, 'HG TURNINGS PUCKED', true);


INSERT INTO "public"."companies" ("id", "created_at", "name", "sector", "size", "linkedin_url", "website", "phone_number", "address", "zipcode", "city", "stateAbbr", "sales_id", "context_links", "country", "description", "revenue", "tax_identifier", "logo", "agent_fee") VALUES
	(1, '2025-02-04 19:51:12.485+00', 'China Agent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 10.00),
	(2, '2025-02-10 19:39:09.245+00', 'INDIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, '2025-02-10 19:43:47.578+00', 'SIGMA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, '2025-02-10 19:48:27.428+00', 'STAINLESS STEEL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, '2025-02-10 19:59:28.886+00', 'KOREA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, '2025-02-10 20:27:30.848+00', 'ECOVERY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'LOXLEY', 'AL', 2, NULL, 'UNITED STATES', NULL, NULL, NULL, NULL, NULL);


INSERT INTO "public"."company_commodity_fees" ("id", "company_id", "commodity_id", "fee") VALUES
	(1, 1, 2, 20.00);

INSERT INTO "public"."company_material_fees" ("id", "company_id", "material_id", "fee") VALUES
	(1, 1, 3, 15.00),
	(2, 1, 2, 12.00);

INSERT INTO "public"."locations" ("id", "company_id", "sales_id", "name", "shipping_address", "notes", "active", "port_fee") VALUES
	(3, 1, NULL, 'Port Sanshui', NULL, NULL, true, NULL),
	(2, 1, NULL, 'Port Yokohama', NULL, NULL, true, NULL),
	(1, 1, NULL, 'Port Ningbo', NULL, NULL, true, NULL),
	(4, 1, NULL, 'Port Chabang', NULL, NULL, true, NULL),
	(5, 2, NULL, 'MUNDRA ICD AHMEDABAD', NULL, NULL, true, NULL),
	(6, 2, NULL, 'CHENNAI', NULL, NULL, true, NULL),
	(7, 2, NULL, 'MUNDRA ICD JAIPUR', NULL, NULL, true, NULL),
	(8, 2, NULL, 'MUNDRA ICD PIYALA/PALWAL/SANAND', NULL, NULL, true, NULL),
	(9, 2, NULL, 'MUNDRA ICD DADRI', NULL, NULL, true, NULL),
	(10, 3, NULL, 'KAOHSIUNG (Taiwan)', NULL, NULL, true, NULL),
	(11, 4, NULL, 'ROTTERDAM', NULL, NULL, true, NULL),
	(12, 4, NULL, 'LAEM CHABANG (Thailand)', NULL, NULL, true, NULL),
	(13, 4, NULL, 'NHAVA SHEVA ICD TARAPUR', NULL, 'IN 20'' CONTAINER', true, NULL),
	(14, 4, NULL, 'MUNDRA', NULL, 'PCIS $50 PER CONTAINER', true, NULL),
	(15, 5, NULL, 'BUSAN', NULL, NULL, true, NULL),
	(16, 5, NULL, 'KWANGYANG', NULL, NULL, true, NULL),
	(17, 6, NULL, 'LOXLEY AL', NULL, NULL, true, NULL);

INSERT INTO "public"."location_prices" ("id", "location_id", "commodity_id", "commodity_grade", "price_type", "price_value", "market_type", "market_price_fix", "validation_date", "sales_id", "active") VALUES
	(1, 1, 1, 'Canada', 'DISCOUNT', -25.000, 'CMX', NULL, '2025-02-13 03:11:25.109', 2, true),
	(2, 1, 2, 'Canada', 'DISCOUNT', -35.500, 'CMX', NULL, '2025-02-13 03:11:25.109', 2, true),
	(3, 1, 1, 'Canada', 'PERCENT', 98.600, 'LME', NULL, '2025-02-13 03:11:25.109', 2, true),
	(4, 1, 2, 'Canada', 'PERCENT', 97.500, 'LME', NULL, '2025-02-13 03:11:25.109', 2, true),
	(9, 4, 4, 'USA', 'FIXED', 6130.000, 'NONE', NULL, '2025-02-13 03:11:25.109', 2, true),
	(10, 4, 5, 'USA', 'PERCENT', 51.000, 'LLME', NULL, '2025-02-13 03:11:25.109', 2, true),
	(29, 17, 5, '', 'FIXED', 2.300, 'NONE', NULL, '2025-02-13 03:11:34.501', 2, true),
	(30, 17, 15, '', 'FIXED', 0.920, 'NONE', NULL, '2025-02-13 03:11:34.501', 2, true),
	(31, 17, 20, '', 'FIXED', 1.080, 'NONE', NULL, '2025-02-13 03:11:34.501', 2, true),
	(11, 7, 6, '', 'FIXED', 1875.000, 'NONE', NULL, '2025-02-13 03:11:42.231', 2, true),
	(12, 6, 15, '', 'PERCENT', 80.000, 'LLME', NULL, '2025-02-13 03:11:42.231', 2, true),
	(13, 10, 17, '', 'FIXED', 0.930, 'NONE', NULL, '2025-02-13 03:12:05.13', 2, true),
	(14, 10, 15, '', 'FIXED', 0.800, 'NONE', NULL, '2025-02-13 03:12:05.13', 2, true),
	(15, 10, 6, '', 'FIXED', 0.840, 'NONE', NULL, '2025-02-13 03:12:05.13', 2, true),
	(16, 10, 16, '', 'FIXED', 0.740, 'NONE', NULL, '2025-02-13 03:12:05.13', 2, true),
	(17, 11, 18, '', 'FIXED', 1170.000, 'NONE', NULL, '2025-02-13 03:12:12.901', 2, true),
	(18, 11, 19, '', 'FIXED', 2240.000, 'NONE', NULL, '2025-02-13 03:12:12.901', 2, true),
	(20, 12, 19, '', 'FIXED', 1200.000, 'NONE', NULL, '2025-02-13 03:12:12.901', 2, true),
	(21, 13, 18, '', 'FIXED', 1270.000, 'NONE', NULL, '2025-02-13 03:12:12.901', 2, true),
	(22, 13, 19, '', 'FIXED', 2425.000, 'NONE', NULL, '2025-02-13 03:12:12.901', 2, true),
	(23, 15, 15, '', 'FIXED', 1940.000, 'NONE', NULL, '2025-03-07 19:54:44.678', 2, true),
	(24, 15, 20, '', 'FIXED', 2250.000, 'NONE', NULL, '2025-03-07 19:54:44.678', 2, true),
	(25, 15, 21, '', 'FIXED', 1770.000, 'NONE', NULL, '2025-03-07 19:54:44.678', 2, true),
	(26, 15, 24, '', 'FIXED', 1970.000, 'NONE', NULL, '2025-03-07 19:54:44.678', 2, true),
	(27, 15, 22, '', 'FIXED', 1500.000, 'NONE', NULL, '2025-03-07 19:54:44.678', 2, true),
	(28, 16, 23, '', 'FIXED', 1850.000, 'NONE', NULL, '2025-03-07 19:54:44.678', 2, true);