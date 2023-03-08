#!/bin/bash

echo "Criando usuários do sistema...."

for USER in $(grep -E 'guest' lista_objetos.txt); do
    useradd $USER -c "Usuário convidado" -s /bin/bash -m -p $(openssl passwd -crypt Senha123)
    passwd $USER -e
done

echo "Criando diretórios..."

for DIR in $(grep -E '/' lista_objetos.txt); do
    mkdir $DIR
done

echo "Criando grupos de usuários..."

for GRP in $(grep -E 'GRP' lista_objetos.txt); do
    groupadd $GRP
done

echo "Criando usuários..."

for USER in $(grep -E 'ADM_' lista_objetos.txt | sed 's/ADM_\(.*\)/\1/'); do
    useradd $USER -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
done
for USER in $(grep -E 'VEN_' lista_objetos.txt | sed 's/VEN_\(.*\)/\1/'); do
    useradd $USER -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
done
for USER in $(grep -E 'SEC_' lista_objetos.txt | sed 's/SEC_\(.*\)/\1/'); do
    useradd $USER -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
done


echo "Especificando permissões dos diretórios...."

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo "Fim....."
