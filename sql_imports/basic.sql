USE helpdesk_development;

SET FOREIGN_KEY_CHECKS = 1;

/*Roles */

LOAD DATA LOCAL INFILE 'c:/FTP/helpdesk_development/roles.csv' 
INTO TABLE roles
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'

(@vid, @vname, @vcreated_at, @vupdated_at)


SET
id= nullif(@vid,''),
name= lower(replace(nullif(@vname,''),' ','')),
created_at =  nullif(@vcreated_at, ''),
updated_at =  nullif(@vupdated_at, '');


/* Location */
/* THE QUERY WHICH GENERATES THIS SETS PERSON_ID = 0 FOR STORES */

LOAD DATA LOCAL INFILE 'c:/FTP/helpdesk_development/locations.csv' 
INTO TABLE locations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'


(@vid, @vparent_id, @vcategory, @vcategory_id, @vlocationcode, @vname, @vperson_id)

SET
id= nullif(@vid,''),
parent_id= nullif(@vparent_id,''),
category= nullif(@vcategory,''),
category_id= nullif(@vcategory_id,''),
name= nullif(@vname,''),
manager_id= nullif(@vperson_id,'');

UPDATE locations SET category = 'globalregion' where category='global region';
UPDATE locations SET category = 'site' where category='location';
UPDATE locations SET category = 'storelocation' where category='store';




/* Stores */

LOAD DATA LOCAL INFILE 'c:/FTP/helpdesk_development/stores.csv' 
INTO TABLE store_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'


(@vstoreid, @vlocation_id, @vaccount, @vcng_cne, @vstorename, @vname_short, @vstatus, @vopeningday, @vaddress1, @vaddress2, @vaddress3, @vtown, @vcounty, @vpostcode,  @vphone, @vuk_country,  @vcreated_at, @vupdated_at, @vlat, @vlng)

SET
id= nullif(@vstoreid,''),
account= nullif(@vaccount,''),
name= nullif(@vstorename,''),
status= nullif(@vstatus,''),
openingday= nullif(@vopeningday,''),
address1= nullif(@vaddress1,''),
address2= nullif(@vaddress2,''),
address3= nullif(@vaddress3,''),
town= nullif(@vtown,''),
county= nullif(@vcounty,''),
postcode= nullif(@vpostcode,''),
uk_country= nullif(@vuk_country,''),
latitude= nullif(@vlat,''),
longitude= nullif(@vlng,''),
phone= nullif(@vphone,''),
created_at =  nullif(@vcreated_at, ''),
updated_at =  nullif(@vupdated_at, ''),
location_id = nullif(@vlocation_id,'');



LOAD DATA LOCAL INFILE 'c:/FTP/helpdesk_development/people.csv' IGNORE
INTO TABLE people
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'

(@vperson_id, @vempref, @vstartdate, @vleavedate, @vcontractedhours, @vholidayentitlement, @vtitle, @vfirstname, @vlastname, @vbirthdate, @vgender, @vnino, @vnationality_id, @vnationality, @vprefferedname, @vmaritalstatus, @vethnicorigin, @vlanguage, @vethnicorigin_id, @vmaritalstatus_id, @vlanguage_id, @vtitle_id, @vjobtitle, @vjobtitle_id, @vopslevel2, @vopslevel, @veffectivedate_job,  @vstore_id, @vstorename, @varea_id, @vregion_id, @veffectivedate_location, @vaddress1, @vaddress2, @vcity, @vcounty, @vcountry, @vpostcode, @vpersonal_email, @vpersonal_phone, @vnextofkintype, @vnok_firstname, @vnok_lastname, @vnok_language, @vnok_language_id, @vnok_address1, @vnok_address2, @vnok_city, @vnok_county, @vnok_country, @vnok_postcode, @vnok_email, @vnok_phone, @vcreated_at, @vupdated_at, @vbanksortcode, @vbankaccount, @vbankaccountname, @vmaestro, @vredtshirt, @vnotesreasonid, @vsign_off_date, @vwage, @veffectivedate_wage, @vpaytype, @vmaestroed_by, @vmaestroed_at, @vholidayused )
SET 
id= nullif(@vperson_id, ''),
store_detail_id = nullif(@vstore_id, ''),
startdate = str_to_date(nullif(@vstartdate, ''), '%d-%m-%Y'),
leavedate = str_to_date(nullif(@vleavedate, ''), '%d-%m-%Y'),
title = nullif(@vtitle, ''),
firstname = nullif(@vfirstname, ''),
lastname = nullif(@vlastname, ''),
preferredname = nullif(@vpreferredname, ''),
jobtitle = nullif(@vjobtitle, ''),
phone = nullif(@vpersonal_phone,''),
email = nullif(@vpersonal_email,''),
created_at =  nullif(@vcreated_at, ''),
updated_at =  nullif(@vupdated_at, '');




/* Users */
LOAD DATA LOCAL INFILE 'c:/FTP/helpdesk_development/users.csv'  
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'

(@vid, @vemail, @vperson_id, @vstartdate)


SET
id= nullif(@vid,''),
email= nullif(@vemail,''),
person_id= nullif(@vperson_id,''),
created_at =  nullif(@vstartdate, '');


/* Insert assignments into temporary table */


LOAD DATA LOCAL INFILE 'c:/FTP/helpdesk_development/assignments.csv'  
INTO TABLE assignments
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'

(@vid,   @vuser_id, @vrole_id,  @vcreated_at, @vupdated_at)


SET

user_id= nullif(@vuser_id,''),
role_id= IFNULL(nullif(@vrole_id,''),0),
created_at =  nullif(@vcreated_at, ''),
updated_at =  nullif(@vupdated_at, '');








SET FOREIGN_KEY_CHECKS = 1;


	

