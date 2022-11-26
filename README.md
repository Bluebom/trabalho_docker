# Trabalho docker Professo Jadilson Sistemas Operacionais

## A partir da imagem jadilsonpaiva/provaso1, crie um script automatizado que realize os seguintes requisitos que estão abaixo:

- Levantar um container a partir desta imagem, de modo a fazer funcionar o servidor WEB já existente.

- Deve ser criado um arquivo index.html customizado com os nomes dos integrantes do grupo e este arquivo deve estar armazenado no host.

- O arquivo padrão da página deste servidor deve ser substituído pelo arquivo customizado anteriormente.

- Este arquivo customizado também deve fazer parte dos dados do container, uma vez que será necessário criar uma nova imagem atualizada a partir deste container e consequentemente, esta nova imagem já deve possuir este arquivo customizado.

- Por fim, para demonstrar que todo o processo foi realizado de maneira correta, exclua o container, imagem e arquivo customizado existente no host, e crie um novo container a partir da nova imagem gerada anteriormente para que seja provado que o novo servidor WEB já possui a página padrão modificada.

## Funcionamento do script

![Demonstrando o projeto][gif]

[gif]: demonstra.gif?image=1000

## Tratamento de erros do script

- Colocando um valor nao inteiro na quantidade de participantes 

![Demonstrando os erros][err1]

[err1]: erro1.png?image=250

- Colocando uma quantidade de participantes maior que 5

![Demonstrando os erros][err2]

[err2]: erro2.png?image=250
