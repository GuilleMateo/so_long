# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mguille <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/13 21:19:28 by mguille           #+#    #+#              #
#    Updated: 2023/01/20 23:01:39 by mguille          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BLANC 		= \033[0;39m
JAUNE 		= \033[0;33m
VERT 		= \033[0;92m
ROUGE 		= \033[0;31m
BLEU 		= \033[0;94m
BLEUC		= \033
MAGENTA 	= \033[7;35m
RESET		= \033[0m

NAME		=	so_long
CC			=	cc
FLAG		=	-Wall -Wextra -Werror
LIBFT_PATH	=	libft/
LIBFT_LIB	=	libft/libftprintf.a

## MLX
MLX_FLAG	=	-lX11 -lXext
MLX_PATH	=	minilibx-linux/
MLX_LIB		=	minilibx-linux/libmlx.a
MLX_EX		=	$(MLX_LIB) $(MLX_FLAG)
## MLX

SRCS_FILES		=	map				\
					map_checker		\
					render			\
					render_mouv		\
					set				\
					texture			\
					utils

SRC_DIR		=	source/
INC_DIR		=	includes/
SRC			=	$(addprefix $(SRC_DIR),$(addsuffix .c, $(SRCS_FILES)))
OBJ			=	$(SRC:.c=.o)

.c.o:
	$(CC) $(FLAG) -c $< -o $@

all: $(NAME)

lib:
	@echo "$(JAUNE)\nCompilation $(LIBFT_PATH)$(RESET)"
	@make -C $(LIBFT_PATH)
	@echo "$(VERT)LIBFT_lib created$(RESET)"

mlx:
	@echo "$(JAUNE)\nCompilation $(MLX_PATH)..."
	@make -sC $(MLX_PATH)
	@echo "$(VERT)MLX_lib created$(RESET)"

$(NAME): lib mlx $(OBJ) norm
	@echo "$(JAUNE)\nCompilation SO_LONG..."
	$(CC) $(OBJ) $(LIBFT_LIB) $(MLX_EX) -o $(NAME)
	@echo "$(VERT)./so_long created$(RESET)"

clean:
	@echo "$(ROUGE)Suppression dossier Obj $(MLX_PATH)..."
	@make clean -sC $(MLX_PATH)
	@echo "$(ROUGE)Suppression dossier Obj $(LIBFT_PATH)..."
	@make clean -sC $(LIBFT_PATH)
	@echo "$(VERT)Fait$(RESET)"
	@echo "$(ROUGE)Suppression obj So_long..."
	@rm -f $(OBJ)
	@echo "$(VERT)Fait$(RESET)"

fclean: clean
	@echo "$(ROUGE)Suppression so_long..."
	@rm -f $(NAME)
	@make fclean -C $(LIBFT_PATH)
	@echo "$(VERT)Fait$(RESET)"

re: fclean all

norm:
	@norminette -v
	@echo "$(MAGENTA)" # Définit le magenta
	@norminette $(SRC) $(INCLUDE) $(SRC_DIR) $(INC_DIR) $(LIBFT_PATH)



.PHONY: all clean fclean re

