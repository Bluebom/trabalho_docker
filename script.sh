#!/bin/bash

display_bars(){
	i=0
	bars="==="
	while true; do
		if [[ "$i" -gt $1+2 ]]; then
			break;
		fi
		bars+="="
		((i++))
	done
	echo $bars
}


message(){
	length=${#1}
	display_bars $length
	echo "   $1"
	display_bars $length

}

structure_html(){
	i=0
	while true; do
		if [[ "$i" -eq $1 ]]; then
			break;
		fi
		read -p "Participante $(($i+1)): " p
		html+="<h1>$p</h1>"
		((i++))
	done
}

insert_into_dockfile(){
	if [ -f "Dockerfile" ]; then
		echo $1 >> Dockerfile 
	fi
}

read -p "Quantidade de participantes do grupo (maximo de 5): " qtd_p # quantidade de participantes

if ! [[ "$qtd_p" =~ ^[0-9]+$ ]]; then
	message "Erro! Voce digitou um valor invalido!"
    	exit 1
fi

if [ $qtd_p -gt 5 ]; then
	message "Erro! Quantidade maxima do grupo e 5"
	exit 1
fi

html=""
structure_html $qtd_p

if [ -d "public" ]; then
	rm -rf "public"
fi

mkdir public && touch public/index.html

echo "$html" > public/index.html

{
	docker rm -f $(docker container ls -aq)
} || {}

{
	docker run -d --name jadilson -p 80:300 --mount type=bind,source="$(pwd)"/public,target=/temp/xyzk jadilsonpaiva/provaso1
} || {
	message "Erro! Ocorreu um problema ao subir o container"
	exit 1
}

if [ -f "Dockerfile" ]; then
	rm -rf "Dockerfile"
fi

touch Dockerfile
insert_into_dockfile "from jadilsonpaiva/provaso1" 
insert_into_dockfile "workdir /temp/xyzk"
insert_into_dockfile "add ./public/index.html ."
insert_into_dockfile "expose 300"

{
	docker rmi -f bluebom/trabalho_jadilson:1.0
	docker rm -f trabalho_jadilson
} || {}

{
	docker build -t bluebom/trabalho_jadilson:1.0 .
	docker run -d --name trabalho_jadilson -p 8080:300 bluebom/trabalho_jadilson:1.0

	message "Sucesso! acesse sua pagina em http://localhost:8080"
	exit 1
} || {
	message "Erro! Ocorreu um problema no build da imagem"
	exit 1
}
