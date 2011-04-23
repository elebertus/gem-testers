CREATE TABLE `rubygems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_rubygems_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `test_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `result` tinyint(1) NOT NULL,
  `test_output` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `version_id` int(11) NOT NULL,
  `rubygem_id` int(11) NOT NULL,
  `operating_system` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `architecture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `machine_architecture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vendor` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ruby_version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `platform` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rubygems_test_version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rubygem_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `prerelease` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_versions_on_rubygem_id_and_number` (`rubygem_id`,`number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20101111043525');

INSERT INTO schema_migrations (version) VALUES ('20101112011142');

INSERT INTO schema_migrations (version) VALUES ('20101112011230');

INSERT INTO schema_migrations (version) VALUES ('20101112011750');

INSERT INTO schema_migrations (version) VALUES ('20101112012038');

INSERT INTO schema_migrations (version) VALUES ('20101112022856');

INSERT INTO schema_migrations (version) VALUES ('20101112024413');

INSERT INTO schema_migrations (version) VALUES ('20101112044711');

INSERT INTO schema_migrations (version) VALUES ('20101114031341');

INSERT INTO schema_migrations (version) VALUES ('20101217081912');

INSERT INTO schema_migrations (version) VALUES ('20110103015306');

INSERT INTO schema_migrations (version) VALUES ('20110103015542');

INSERT INTO schema_migrations (version) VALUES ('20110108030608');

INSERT INTO schema_migrations (version) VALUES ('20110313153714');