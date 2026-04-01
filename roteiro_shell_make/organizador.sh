#!/bin/bash

# verificar se pastas já existem, se não existem criar

if [ ! -d "src" ]; then
    echo "A pasta "src" não existe. Criando agora..."
    mkdir -p "src"
else
    echo "A pasta já existe."
fi 

for file in *.v; do
    if [ -f "$file" ]; then

        if [ -f "src/$file" ]; then
            NOME_BASE="${file%.*}"
            EXT="v"
    
            NOVO_NOME="${NOME_BASE}2.${EXT}"
    
            echo "Aviso: $file já existe em scr. Renomeado para $NOVO_NOME"
            mv "$file" "src/$NOVO_NOME"

        else
            mv "$file" "src/"
            echo "$file movido para scr"
        fi
    fi
done
