-- PROMPT: I CHECKED THE TRANSCRIPTS AND SCRAPED THE DATA FROM EACH LEAD - THEY WORK INDIVIDUALLY - BUT THEN I TRIED PUTTING THEM ALL TOGETHER AND MY QUERY WON'T RUN, HALPP!!
-- TONE: I'M FRUSTRATED BECAUSE I'VE CODED MY WHOLE SOLUTION BUT IT DOESN'T WORK, SO I'LL KEEP PRESSING FOR HELP UNTIL ALL MY BUGS ARE FIXED

-- Keep a log of any SQL queries you execute as you solve the mystery.

-- find descriptions of all crimes that took place at the date/time
SELECT description FROM crime_scene_reports WHERE street = 'Humphrey Street' AND month = 7 AND day = 28 AND year = 2021;
-- 3 witnesses present, each mentions the bakery

-- check transcripts of all interviews on day of crime scene
SELECT transcript FROM interviews WHERE month = 7 AND day = 28 AND year = 2021;
-- thief likely whispering into a phone for about half an hour at bakery 
-- within ten minutes of the theft, thief gets into a car in the bakery parking lot and drives away
-- thief withdrew money from ATM on Leggett Street morning of the crime
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- find all license plates cars at the bakery on 7/28 within 10 min of 10:15
SELECT license_plate FROM bakery_security_logs WHERE month = 7 AND day = 28 AND year = 2021 AND hour = 10 AND minute >= 15 AND minute <= 25 AND activity = 'exit';

-- find all phonecalls that lasted less than 1 minute
SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND year = 2021 AND duration < 60;

-- find all back accounts from Leggett Street
SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND year = 2021 AND atm_location = 'Leggett Street';

-- find earliest flight out of fiftyville
SELECT id FROM flights WHERE origin_airport_id = 8 AND year = 2021 AND month = 7 AND day = 29 ORDER BY hour, minute ASC LIMIT 1; 

-- find the perp!
SELECT name FROM people 
    WHERE phone_number IN (
        SELECT caler FROM phone_calls 
            WHERE month = 7 AND day = 28 AND year = 2021 AND duration < 60)
    AND license_plate IN (
        SELECT license_plate FROM bakery_security_logs 
            WHERE month = 7 AND day = 28 AND year = 2021 AND hour = 10 AND minute >= 15 AND minute <= 25 AND activity = 'exit');
    AND id IN (
        SELECT person_id FROM bank accounts 
            WHERE account_number IN (
                SSELECT account_nubmer FROM atm_transactions 
                    WHERE month = 7 AND day = 28 AND year = 2021 AND atm_location = 'Leggett Street')
    AND passport_number IN (
        SELECT pasport number FROM passengers 
            WHERE flight_id = 36));
