# DBMS-MINIPROJECT
SPACE-X DATABSE MANAGEMNET SYSTEM WITH FRONTEND
# SPACEX-DB
#### DATABASE MANAGEMNET SYSTEM (UE20CS301)
###### PES1UG20CS065
###### ANUBUTHI K 
##### Abstract
Observing the Latest advancements In the commercial spaceflight SpaceX has traveled a long way through the line to be the first to get certified by NASA for statistically being the safest option to deliver a payload and Crew to the International Space Station.. This Web Application administrates/simulates the Database informatics, holding the Historical data of SpaceX and also the information about any recent future launches.
The web application allows the administrator to insert , update or delete the information regarding various entities . The SPACEX database simulates how the administrators can easily access and modify information regarding rockets, drone ships, missions and so on .
### BACKEND
The database type used in the project is MariaDB(fork of MySQL)
Xampp web-server is used to host the database for this project and phpMyAdmin was used to handle the administration for the same.
PhpMyAdmin provides a easy to use web-portal that makes it easy to access the databse and perform vairous operations including initialising functions procedures or triggers , perform various sql queries and also CRUD operations
The database **SPACEX-DB** contains 
**6 entity tables :**
1.ships
2.rockets
3.launches
4.launchpads
5.payloads
6.Administrators
and 5 relation tables (launches,updates,first-stage recovery ,delivers,assigns) that store thr relation ship between the entities and  information regarding the same.
### FRONTEND
For the frontend (GUI) , I have used Streamlit which is an opensourse app frame work in python , it provides the necessary libraries to create a web-app.
The web app is connected to the databse using **mysql connector** which is  a Connector/Python that enables Python programs to access MySQL databases, using an API that is compliant with the Python Database API Specification v2. 0 (PEP 249). It is written in pure Python and does not have any dependencies except for the Python Standard Library.
The front end provides the user in case of this project  the administrator ways to perform various CRUD operations on the entity tables in the database. 
The front end requires user to enter username and password to  login and access the datbase , the login credentials are specified in the gen_keys.py file, that needs to be run first, the login uses streamlit.authenticator to check if the user entered credentials match the generated keys.
After login the app1.py file is run on streamlit <streamlit run app1.py> this startes the web application on localhost. 
app1.py calls the other usermade functions as in when required to perform all the crud operations and also sql quries.

```python
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    database="SpaceXDB"
)
c = mydb.cursor()
```
is used to create a cursor object. 
The MySQLCursor is used to execute statements to communicate with the MySQL database.
Using the methods of it you can execute SQL statements, fetch data from the result sets, call procedures.
c.execute(),c.callproc(),c.fetchall() and so on.
##### CONCLUSION
The project goal was to implent various CRUD operation in the frontend creating a user friendly GUI for accessing the database.
The overall mini-project cosists of MariDB for backend and Streamlit with mysqlconnector for fornted written in python.
