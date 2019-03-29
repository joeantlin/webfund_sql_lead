-- 1. What query would you run to get the total revenue for March of 2012?

SELECT SUM(amount) AS total_revenue, charged_datetime AS month_of_march
FROM billing
WHERE charged_datetime >= '2012/03/01' AND charged_datetime < '2012/04/01';

-- 2. What query would you run to get total revenue collected from the client with an id of 2?

SELECT SUM(billing.amount) AS total_revenue, clients.client_id
FROM billing
JOIN clients
ON clients.client_id = billing.client_id
WHERE billing.client_id = 2;

-- 3. What query would you run to get all the sites that client=10 owns?

SELECT sites.domain_name, clients.client_id
FROM sites
JOIN clients
ON clients.client_id = sites.client_id
WHERE clients.client_id = 10;

-- 4. What query would you run to get total # of sites created per month per year for the client with an id of 1? What about for client=20?

-- 5. What query would you run to get the total # of leads generated for each of the sites between January 1, 2011 to February 15, 2011?

SELECT COUNT(leads.leads_id) AS total_leads , sites.domain_name
FROM leads
JOIN sites
ON sites.site_id = leads.site_id
WHERE leads.registered_datetime >= '2011/01/01' 
AND leads.registered_datetime <= '2011/02/15' 
GROUP BY sites.domain_name;

-- 6. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients between January 1, 2011 to December 31, 2011?

SELECT CONCAT(clients.first_name, ' ',clients.last_name) AS client_name, COUNT(leads.leads_id) AS leads
FROM leads
JOIN sites
ON sites.site_id = leads.site_id
JOIN clients
ON clients.client_id = sites.client_id
WHERE leads.registered_datetime >= '2011/01/01' 
AND leads.registered_datetime <= '2011/12/31'
GROUP BY clients.client_id;

-- 7. What query would you run to get a list of client names and the total # of leads we've generated for each client each month between months 1 - 6 of Year 2011?

SELECT CONCAT(clients.first_name, ' ',clients.last_name) AS client_name, COUNT(leads.leads_id), MONTH(leads.registered_datetime) AS month
FROM leads
JOIN sites
ON sites.site_id = leads.site_id
JOIN clients
ON clients.client_id = sites.client_id
GROUP BY MONTH(leads.registered_datetime)
ORDER BY month;

-- 8. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients' sites between January 1, 2011 to December 31, 2011? Order this query by client id.  Come up with a second query that shows all the clients, the site name(s), and the total number of leads generated from each site for all time.

SELECT CONCAT(clients.first_name, ' ',clients.last_name) AS client_name, COUNT(leads.leads_id), sites.domain_name
FROM leads
JOIN sites
ON sites.site_id = leads.site_id
JOIN clients
ON clients.client_id = sites.client_id
WHERE leads.registered_datetime >= '2011/01/01' 
AND leads.registered_datetime <= '2011/12/31'
GROUP BY sites.domain_name
ORDER BY clients.client_id;

-- 9. Write a single query that retrieves total revenue collected from each client for each month of the year. Order it by client id.

SELECT clients.client_id, CONCAT(clients.first_name, ' ',clients.last_name) AS client_name, SUM(billing.amount) AS total_revenue, MONTH(billing.charged_datetime) AS month
FROM billing
JOIN clients 
ON clients.client_id = billing.client_id
GROUP BY billing.amount;

-- 10. Write a single query that retrieves all the sites that each client owns. Group the results so that each row shows a new client. It will become clearer when you add a new field called 'sites' that has all the sites that the client owns. (HINT: use GROUP_CONCAT)

SELECT clients.client_id, CONCAT(clients.first_name, ' ',clients.last_name) AS client_name, GROUP_CONCAT(" ",sites.domain_name)
FROM sites
JOIN clients
ON clients.client_id = sites.client_id
GROUP BY client_name;




