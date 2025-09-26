################### INSTALAR WSL #############################

seguir tutorial: https://www.youtube.com/watch?v=0k7cwmx2W2g&t=309s

################### INSTALAR GIT #############################

No WSL, correr:
  sudo apt update
  sudo apt install git -y

Para ter a certeza que correu tudo bem fazer:
  git --version
se mostrar a versão, ótimo, correu bem

Configuras o git localmente, corre:
  git config --global user.name "Username do Github"
  git config --global user.email "Email do Github"


################### PRIMEIRA VEZ #############################

Precisas de criar uma SSH key, é basicamente uma chave digital para provar que és tu sem precisares de meter passes sempre que fazes alguma coisa
Depois de criar, tens apenas uma, sempre que um site pedir dás a SSH key pública

Para criar corre:
  ssh-keygen -t ed25519 -C "teu@email.com"
depois disto dás sempre enter para aceitar tudo, não precisas de fazer mais nada, apenas enter até voltares ao inicio
Depois:
  eval "$(ssh-agent -s)" 
  ssh-add ~/.ssh/id_ed25519
  cat ~/.ssh/id_ed25519.pub
Isto vai basicamente criar um agente para guardares as tuas keys, o segundo comando guarda as keys no agente criado e o terceiro mostra a key criada no terminal

Quando tiveres isto feito:
  Github -> Settings -> SSH and GPG keys -> New SSH key

Das chaves tá tudo tratado, agora falta dares clone ao projeto, faz:
  git clone git@github.com:GoncaloSilva-99/Projeto_pap.git
  cd Projeto_pap
  bundle install
  rails db:create
  rails db:migrate

Ótimo, tens aí o projeto base
(eu sei que parece confuso, mas é só uma vez que fazes)

################### ENVIAR ALTERAÇÕES PARA O GIT #############################

Tas a trabalhar no projeto, quando acabares o que fizeste corre:
  git add -A
  git commit -m "Descrição das alterações"
  git push

Ótimo, atualizaste tudo o que fizeste 

################### PUXAR ALTERAÇÕES PARA O GIT #############################

Já se for eu a trabalhar no projeto, para tu atualizares o teu projeto com as minhas alterações corre:
  git pull

Simples, tá feito


################### IMPORTANTE #############################

Sempre antes de começares a trabalhar no projeto, faz git pull, posso ter mexido em alguma coisa sem te avisar e assim escusas de tar a mexer num projeto antigo (sem as alterações)
