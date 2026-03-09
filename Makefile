SEPIA = \033[38;5;180m
BLACK = \033[0;30m
WHITE = \033[1;37m
GRAY = \033[0;37m
RESET = \033[0m
BOLD = \033[1m



all:
	mkdir -p /home/lmokhtar/data/mariadb
	mkdir -p /home/lmokhtar/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up --build -d


logs:
	docker logs nginx
	docker logs mariadb
	docker logs wordpress

clean:
	docker stop nginx ; \
	docker stop mariadb ; \
	docker stop wordpress ; \
	docker network rm inception ; \
	pwd

fclean: clean
	@sudo rm -rf /home/lmokhtar/data/mariadb/*
	@sudo rm -rf /home/lmokhtar/data/wordpress/*
	@docker system prune -af

push:
	@echo "$(SEPIA)$(BOLD)Uploading data to Bunker...$(RESET)"
	@git add .
	@echo -n "$(WHITE)Enter transmission message: $(RESET)"
	@read commit_message; \
	git commit -m "$$commit_message"; \
	git push; \
	echo "$(SEPIA)Data successfully transmitted: '$$commit_message'$(RESET)"

re: fclean all 


.PHONY: all clean fclean re push
