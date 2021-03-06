---
layout: post
title: "Como migrar para um VPS"
date: 2014-03-04 16:01
comments: true
categories: vps
image: /assets/article_images/2014-03-04-como-migrar-para-um-vps/vps.jpg
---

# Configurando um VPS

Este é o primeiro tutorial de uma série VPS que vou fazer.

Iremos básico aprender:

* O que é, e para que serve um VPS

* Como adquirir um VPS

* Configuração basica de segurança

* Instalação de um Web server para servir páginas estáticas


### O que é, e para que serve um VPS
[VPS](http://pt.wikipedia.org/wiki/Virtual_Private_Network) = Virtual Private Network, nada mais é que uma maquina virtual com [um Endereço de IP](http://pt.wikipedia.org/wiki/Endere%C3%A7o_IP), fixo.

A vantagem em relação a Hospedagem compartilhada é você poder instalar softwares, linguagens e framework de sua preferência, pois você tem acesso total.

A desvantagem é que você é responsável pela manutenção e segurança de seu servidor.

Você pode tambem hospedar sua aplicação em um [PaaS](http://en.wikipedia.org/wiki/Platform_as_a_service), como Heroku, Appfrog, etc. mas isto é assunto para outro post. :D


### Como adquirir um servidor
Você pode optar por várias configurações de maquina, vamos focar em realmente Lowend :D

Existem várias empresas que oferecem VPS ou [Cloud Computing](http://pt.wikipedia.org/wiki/Computa%C3%A7%C3%A3o_em_nuvem), vamos nos ater a VPS pois não pensaremos em escalabilidade neste momento, então vamos para as opções mais baratas :P

Vou citar as que eu pessoalmente utilizo, isso não que dizer que são boas ou ruins mas atendem as minhas necessidades "preço".

* [Digital Ocean](https://www.digitalocean.com)
 Ótimo serviço e preço, melhor custo benefício  inicia com US$ 5 de crédito, ótimos tutoriais, se esquecer de pagar a mensalidade o serviço não é cortado você fica com o saldo negativo e no proximo aporte eles debitam os minutos que você ficou devendo, a tarifação é por minuto do servidor operando, se excluir o servidor seus creditos ficam lá, sedo assim você pode levantar mais de uma máquina ao mesmo tempo com um só credito de US$ 5.

* [Hostinger](http://www.hostinger.com.br/hospedagem-vps)
Vantagem de pagar com boleto ou débito, para os que não tem cartão de credito internacional.
A bilhetagem é mensal.
O sistema de geranciamento é Cpanel
R$ 19,00 inicial  com 1 giga de Ram

* [CloudatCost](http://cloudatcost.com/)
É a mais simples e mais barata das listadas aqui, inicia com US$ 1, mensal ou taxa única de US$ 35.
Tem menos recursos, tenho um ligado a uns 2 meses e me parace uma boa opção.

Nota. Não precisei de suporte na Digital Ocean nem da CloudatCost ainda, então não posso avaliar o serviço do suporte, em relação a Hostinger precisei uma vez de suporte e demorou pacas para responderem o ticket.


### Configuração de segurança basica
Vamos tomar como base uma imagem de Ubuntu 14-04 porém irá servir para Debian 7 também

Depois de compra o serviço (No caso da Digital Ocean ativar um droplet) você receberá um email com o IP e uma senha de acesso root

Assumo que você está em um Linux ou Mac, se não, está na hora de instalar um linux e começar a aprender pode ser até em um [Virtualbox](https://www.virtualbox.org/).

Nos exemplos a seguir seuip deve ser substituido pelo ip recebido do provedor

Vamos abrir o terminal e começar pingando o servidor

```
$ ping seuip # numero do seu ip
```
Se conseguiu pigar beleza, se não veja se o servidor está ativo no painel de controle do provedor

Vamos conectar via ssh

```
$ ssh root@seuip   # digite a senha recebida no seu email
```
Vamos alterar a senha do root

```
~# passwd  # digite a nova senha (use senha forte) e confirme
```

Vamos criar um outro usuário

```
~# adduser deploy # colocar uma senha forte e confirmar
```


Vamos alterar o editor de texto padrão para vim (não gosto do nano)

```
~# export VISUAL=vi
```

Vamos incluir o novo usuario na lista de sudoers

```
~# adduser deploy sudo
```

Encerraremos a sessão para acessarmos com o usuário deploy
```
~# exit
```
Se não tem um ssh-key vamos gerar um agora

```
~# ssh-keygen -t rsa -b 4096  #digite enter duas vezes, não queremos usar passphrase
```

Vamos enviar a senha para o VPS

```
$ ssh-copy-id deploy@seuip   # Irá pedir para confirmar seu fingerprint digite "yes" e logo depois a senha escolhida para o usário deploy
```

Beleza agora vamos conectar com o usario deploy

```
$ ssh deploy@seuip
```

Podemos bloquear o acesso ssh root então

```
$ sudo vi /etc/ssh/sshd_config

PermitRootLogin yes  # na linha 28 mude de yes para no
```

Reinicie o serviço

```
$ sudo /etc/init.d/ssh restart
```

Este é o basico do basico. em um post futuro nos aprofundaremos em segurança ;D

### Instalando um web server

De cara o web server mais popular e usado é o Apache de uma olhada no [Market Share](http://w3techs.com/technologies/overview/web_server/all), porém vamos instalar o Nginx pois ele irá servir de base para os proximos posts e particularmente acho a melhor opção.


A versão estável está em 1.6 e a do repositório Ubuntu é 1.4 então vamos adcionar o repositório dotdeb

```
$ sudo echo "deb http://packages.dotdeb.org squeeze all\ndeb-src http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list
$ wget http://www.dotdeb.org/dotdeb.gpg
$ sudo apt-key add dotdeb.gpg
$ sudo apt-get update
$ sudo apt-get install nginx
```
Para testar se o servidor está em pé

```
$ curl -I localhost
```
Ou abra o browser e digite o seu ip :)

### Conclusão

Colocamos um servidor VPS com Nginx e acesso SSH, no próximo post veremos com configurar virtualhost para hospedarmos varios sites no mesmo server.