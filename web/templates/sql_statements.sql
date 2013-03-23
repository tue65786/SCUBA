/*
Thread started
INFO: Connecting to SSH server at cis-linux2.temple.edu:22...
C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE/python/site-packages\paramiko\client.py:95: UserWarning: Unknown ssh-rsa host key for cis-linux2.temple.edu: 8c5efc1ff659a68d401b4127dabed836
  (key.get_name(), hostname, hexlify(key.get_fingerprint())))
INFO: Connection opened
WARNING: Unable to determine codepage from shell: 
WARNING: Unable to fetch ProgramFiles value in Windows machine: 
WARNING: Unable to fetch ProgramFiles(x86) value in local Windows machine: 
Traceback (most recent call last):
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_grt.py", line 132, in do_open_administrator
    adminTab = AdministratorTab(server_instance)
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_grt.py", line 68, in __init__
    self.ctrl_be.init()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_control.py", line 406, in init
    self.server_helper = ServerManagementHelper(self.server_profile, self.ssh)
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 1723, in __init__
    self.shell.post_init()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 518, in post_init
    self.fetch_windows_shell_info()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 494, in fetch_windows_shell_info
    self.target_shell_variables[WIN_PROGRAM_DATA_VAR] = self.target_shell_variables[ProgramFilesVar]
KeyError: '%ProgramFiles%'



Thread started
INFO: Connecting to SSH server at cis-linux2.temple.edu:22...
C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE/python/site-packages\paramiko\client.py:95: UserWarning: Unknown ssh-rsa host key for cis-linux2.temple.edu: 8c5efc1ff659a68d401b4127dabed836
  (key.get_name(), hostname, hexlify(key.get_fingerprint())))
INFO: Connection opened
WARNING: Unable to determine codepage from shell: 
WARNING: Unable to fetch ProgramFiles value in Windows machine: 
WARNING: Unable to fetch ProgramFiles(x86) value in local Windows machine: 
Traceback (most recent call last):
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_grt.py", line 132, in do_open_administrator
    adminTab = AdministratorTab(server_instance)
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_grt.py", line 68, in __init__
    self.ctrl_be.init()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_control.py", line 406, in init
    self.server_helper = ServerManagementHelper(self.server_profile, self.ssh)
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 1723, in __init__
    self.shell.post_init()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 518, in post_init
    self.fetch_windows_shell_info()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 494, in fetch_windows_shell_info
    self.target_shell_variables[WIN_PROGRAM_DATA_VAR] = self.target_shell_variables[ProgramFilesVar]
KeyError: '%ProgramFiles%'
MySQL Workbench CE for Windows version 5.2.47  revision 10398
Configuration Directory: C:\Users\Dan Kauffman\AppData\Roaming\MySQL\Workbench
Data Directory: C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE
Cairo Version: 1.8.8
OS: Microsoft Windows 7  Service Pack 1 (build 7601), 64-bit
CPU: 8x Intel(R) Core(TM) i7 CPU       Q 840  @ 1.87GHz, 11.9 GiB RAM
Active video adapter Windows Live Display Driver
Installed video RAM: 0 MB
Current video mode: 1824 x 1014 x 4294967296 colors
Used bit depth: 32
Driver version: 15.5527.0.0
Installed display drivers: NULL
Current user language: English (United States)

Thread started
INFO: Connecting to SSH server at cis-linux2.temple.edu:22...
C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE/python/site-packages\paramiko\client.py:95: UserWarning: Unknown ssh-rsa host key for cis-linux2.temple.edu: 8c5efc1ff659a68d401b4127dabed836
  (key.get_name(), hostname, hexlify(key.get_fingerprint())))
INFO: Connection opened
WARNING: Unable to determine codepage from shell: 
WARNING: Unable to fetch ProgramFiles value in Windows machine: 
WARNING: Unable to fetch ProgramFiles(x86) value in local Windows machine: 
Traceback (most recent call last):
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_grt.py", line 132, in do_open_administrator
    adminTab = AdministratorTab(server_instance)
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_grt.py", line 68, in __init__
    self.ctrl_be.init()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_admin_control.py", line 406, in init
    self.server_helper = ServerManagementHelper(self.server_profile, self.ssh)
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 1723, in __init__
    self.shell.post_init()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 518, in post_init
    self.fetch_windows_shell_info()
  File "C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE\modules\wb_server_management.py", line 494, in fetch_windows_shell_info
    self.target_shell_variables[WIN_PROGRAM_DATA_VAR] = self.target_shell_variables[ProgramFilesVar]
KeyError: '%ProgramFiles%'
MySQL Workbench CE for Windows version 5.2.47  revision 10398
Configuration Directory: C:\Users\Dan Kauffman\AppData\Roaming\MySQL\Workbench
Data Directory: C:\Program Files (x86)\MySQL\MySQL Workbench 5.2 CE
Cairo Version: 1.8.8
OS: Microsoft Windows 7  Service Pack 1 (build 7601), 64-bit
CPU: 8x Intel(R) Core(TM) i7 CPU       Q 840  @ 1.87GHz, 11.9 GiB RAM
Active video adapter Windows Live Display Driver
Installed video RAM: 0 MB
Current video mode: 1824 x 1014 x 4294967296 colors
Used bit depth: 32
Driver version: 15.5527.0.0
Installed display drivers: NULL
Current user language: English (United States)


*/

CREATE TABLE `dive_log` (
  `dive_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `dive_date` date NOT NULL,
  `number_dives` int(3) NOT NULL,
  `minutes_per_dive` int(5) NOT NULL,
  `air_type` varchar(45) DEFAULT NULL COMMENT 'Regular, Nitrox, Rebreather',
  `max_depth` int(5) DEFAULT NULL,
  `dive_buddy` int(15) DEFAULT NULL COMMENT 'fK to diver id',
  `notes` varchar(500) DEFAULT NULL,
  `dive_location_id` int(11) NOT NULL,
  `web_user_id` int(11) NOT NULL,
  PRIMARY KEY (`dive_log_id`),
  KEY `fk_dive_log_dive_location` (`dive_location_id`),
  KEY `fk_dive_log_web_user1` (`web_user_id`),
  CONSTRAINT `fk_dive_log_dive_location` FOREIGN KEY (`dive_location_id`) REFERENCES `dive_location` (`dive_location`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dive_log_web_user1` FOREIGN KEY (`web_user_id`) REFERENCES `web_user` (`web_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1$$


----


INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('user@user.com', 'asdf', '1980-01-01', '0.00', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('user2@soemthing.com', 'asdf', '1971-01-01', '0', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('tuser@temple.edu', 'fads', '1990-11-01', '0', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('user1111@user.com', 'asdf', '1980-01-01', '0.00', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('user22222@soemthing.com', 'asdf', '1971-01-01', '0', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('tuser33333@temple.edu', 'fads', '1990-11-01', '0', '2');

INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('user111@user.com', 'asdf', '1980-01-01', '0.00', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('user2222@soemthing.com', 'asdf', '1971-01-01', '0', '2');
INSERT INTO `web_user` (`user_email`, `user_password`, `birthday`, `membership_fee`, `user_role_id`) VALUES ('tuser3333@temple.edu', 'fads', '1990-11-01', '0', '2');

--assoc.js[
SELECT web_user.user_email, user_role.user_role_title, dive_location.location_name,  dive_log.dive_date

FROM web_user,user_role,dive_location,dive_log
WHERE web_user.user_role_id = user_role.user_role_id AND web_user.web_user_id = dive_log.web_user_id
AND dive_location.dive_location = dive_log.dive_location_id


--all fields
SELECT 
loc.location_name,
loc.city,
loc.state,
loc.type,
loc.access_via,
loc.average_depth,
loc.average_visibility,
loc.features,
log.dive_log_id,
log.dive_date,
log.number_dives,
log.minutes_per_dive,
log.air_type,
log.max_depth,
(select wu.user_email from web_user wu where wu.web_user_id = log.dive_buddy) as dive_buddy,
log.notes,
wu.web_user_id,
wu.user_email,
wu.user_password,
wu.birthday,
wu.user_role_id,
ur.user_role_title
FROM dive_location loc, dive_log log, web_user wu,user_role ur
where loc.dive_location = log.dive_location_id  AND
wu.web_user_id = log.web_user_id AND ur.user_role_id = wu.user_role_id
ORDER BY wu.user_email




SELECT wu.user_email,ur.user_role_title,loc.location_name,loc.city,loc.state,log.dive_date,log.number_dives,log.minutes_per_dive,log.air_type,log.max_depth,(SELECT wu.user_email FROM web_user wu WHERE wu.web_user_id = log.dive_buddy) as dive_buddy,log.notes,FROM dive_location loc, dive_log log, web_user wu,user_role ur WHERE loc.dive_location = log.dive_location_id  AND wu.web_user_id = log.web_user_id AND ur.user_role_id = wu.user_role_id ORDER BY log.dive_date,wu.user_email

--oother.jsp  
SELECT`dive_location`.`dive_location`,
`dive_location`.`location_name`,
`dive_location`.`city`,
`dive_location`.`state`,
`dive_location`.`type`,
`dive_location`.`access_via`,
`dive_location`.`average_depth`,
`dive_location`.`average_visibility`,
`dive_location`.`features`
FROM `SP13_2308_tue65786`.`dive_location`;


SELECT
`dive_log`.`dive_log_id`,
`dive_log`.`dive_date`,
`dive_log`.`number_dives`,
`dive_log`.`minutes_per_dive`,
`dive_log`.`air_type`,
`dive_log`.`max_depth`,
`dive_log`.`dive_buddy`,
`dive_log`.`notes`,
`dive_log`.`dive_location_id`,
`dive_log`.`web_user_id`
FROM `SP13_2308_tue65786`.`dive_log`;


`web_user`.`web_user_id`,
`web_user`.`user_email`,
`web_user`.`user_password`,
`web_user`.`birthday`,
`web_user`.`membership_fee`,
`web_user`.`user_role_id`
FROM `web_user`;
