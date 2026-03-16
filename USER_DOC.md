1. Services provided by the stack
    NGINX: HTTPS reverse proxy, public entrypoint on port 443.
    WordPress: PHP-FPM application server.
    MariaDB: database server used by WordPress.

2. Start and stop the project
    Start (build + run):
        make
    Show logs:
        make logs
    Stop containers and remove network:
        make clean
    Full cleanup (also deletes persisted data and prunes Docker objects):
        make fclean
    Full rebuild:
        make re

3. Website
    https://lmokhtar.42.fr
    wp admin : https://lmokhtar.42.fr/wp-admin

4. Credentials
    Stored in .env
    Can edit them in srcs/.env
    Make again for them to have effect
    (Never publish them publicly)

5. Checks
    Container status: docker ps
    Project logs: make logs

Expected that the containers are up in docker ps and WP login is reachable.


