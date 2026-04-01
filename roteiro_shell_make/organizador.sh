#!/bin/bash

# verificar se pastas src já existem, se não existem criar
if [ ! -d "src" ]; then
    echo "A pasta "src" não existe. Criando agora..."
    mkdir -p "src"
else
    echo "A pasta src já existe."
fi 
# Mover arquivos .v para pasta src, se já existir um arquivo com o mesmo nome, renomear o novo arquivo para nome2.v
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
            echo "$file movido para src"
        fi
    fi
done

# verificar se pastas tb já existem, se não existem criar
if [ ! -d "tb" ]; then
    echo "A pasta "tb" não existe. Criando agora..."
    mkdir -p "tb"
else
    echo "A pasta tb já existe."
fi 
# Mover arquivos *_tb.v para pasta tb, se já existir um arquivo com o mesmo nome, renomear o novo arquivo para nome2_tb.v
for file in *_tb.v; do
    if [ -f "$file" ]; then

        if [ -f "tb/$file" ]; then
            NOME_BASE="${file%_tb.v}"
            EXT="v"
    
            NOVO_NOME="${NOME_BASE}2_tb.${EXT}"
    
            echo "Aviso: $file já existe em tb. Renomeado para $NOVO_NOME"
            mv "$file" "tb/$NOVO_NOME"

        else
            mv "$file" "tb/"
            echo "$file movido para tb"
        fi
    fi
done

# verificar se pastas includes já existem, se não existem criar
if [ ! -d "includes" ]; then
    echo "A pasta "includes" não existe. Criando agora..."
    mkdir -p "includes"
else
    echo "A pasta já existe."
fi 

for file in *.vh; do
    if [ -f "$file" ]; then

        if [ -f "includes/$file" ]; then
            NOME_BASE="${file%.*}"
            EXT="vh"
    
            NOVO_NOME="${NOME_BASE}2.${EXT}"
    
            echo "Aviso: $file já existe em includes. Renomeado para $NOVO_NOME"
            mv "$file" "includes/$NOVO_NOME"

        else
            mv "$file" "includes/"
            echo "$file movido para includes"
        fi
    fi
done

# verificar se pastas scripts já existem, se não existem criar
if [ ! -d "scripts" ]; then
    echo "A pasta "scripts" não existe. Criando agora..."
    mkdir -p "scripts"
else
    echo "A pasta scripts já existe."
fi 
# Mover arquivos .tcl para pasta scripts, se já existir um arquivo com o mesmo nome, renomear o novo arquivo para nome2.tcl
for file in *.tcl; do
    if [ -f "$file" ]; then

        if [ -f "scripts/$file" ]; then
            NOME_BASE="${file%.*}"
            EXT="tcl"
    
            NOVO_NOME="${NOME_BASE}2.${EXT}"
    
            echo "Aviso: $file já existe em scripts. Renomeado para $NOVO_NOME"
            mv "$file" "scripts/$NOVO_NOME"

        else
            mv "$file" "scripts/"
            echo "$file movido para scripts"
        fi
    fi
done
# Mover arquivos .do para pasta scripts, se já existir um arquivo com o mesmo nome, renomear o novo arquivo para nome2.do
for file in *.do; do
    if [ -f "$file" ]; then

        if [ -f "scripts/$file" ]; then
            NOME_BASE="${file%.*}"
            EXT="do"
    
            NOVO_NOME="${NOME_BASE}2.${EXT}"
    
            echo "Aviso: $file já existe em scripts. Renomeado para $NOVO_NOME"
            mv "$file" "scripts/$NOVO_NOME"

        else
            mv "$file" "scripts/"
            echo "$file movido para scripts"
        fi
    fi
done

# verificar se pastas docs já existem, se não existem criar
if [ ! -d "docs" ]; then
    echo "A pasta "docs" não existe. Criando agora..."
    mkdir -p "docs"
else
    echo "A pasta já existe."
fi 

for file in *.md; do
    if [ -f "$file" ]; then

        if [ -f "docs/$file" ]; then
            NOME_BASE="${file%.*}"
            EXT="md"
    
            NOVO_NOME="${NOME_BASE}2.${EXT}"
    
            echo "Aviso: $file já existe em docs. Renomeado para $NOVO_NOME"
            mv "$file" "docs/$NOVO_NOME"

        else
            mv "$file" "docs/"
            echo "$file movido para docs"
        fi
    fi
done