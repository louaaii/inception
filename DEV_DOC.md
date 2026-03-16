1. Setup
    Install:
        Docker
        GNU make
    Required files:
        Composer file: .yml
        Make targets
        MariaDB script
        Wordpress script
        NGINX config
        .env

2. Build
    Build and run all services:
    make
    This runs docker compose up --build -d using    docker-compose.yml:1.

    Stop services and remove network:
        make clean
    Full reset:
        make fclean
    Rebuild from scratch:
        make re
    
3. Useful 
    docker ps
    docker compose -f docker-compose.yml ps
    docker compose -f docker-compose.yml logs -f
    docker volume ls
    docker network ls
    Service-level logs from Makefile:
    make logs
    Cleanup commands
    make clean
    make fclean

4. Persisted data
    /home/lmokhtar/data
    Containers are ephemeral, data is host mounted and persists through container rebuilds and is only deleted when manually removed