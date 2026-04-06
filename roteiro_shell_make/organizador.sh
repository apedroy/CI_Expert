#!/bin/bash

set -euo pipefail

DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "[INFO] Modo DRY-RUN ativado"
fi

# =========================
# Criar diretórios
# =========================
criar_dir() {
    if [[ ! -d "$1" ]]; then
        echo "[INFO] Criando diretório: $1"
        $DRY_RUN || mkdir -p "$1"
    fi
}

# =========================
# Função de mover arquivos
# =========================
mover() {
    origem="$1"
    destino="$2"

    for file in $origem; do
        [[ -e "$file" ]] || continue

        # não mover o próprio script
        [[ "$file" == "organizador.sh" ]] && continue

        nome=$(basename "$file")

        if [[ -e "$destino/$nome" ]]; then
            echo "[SKIP] já existe: $nome"
            continue
        fi

        echo "[MOVE] $nome → $destino/"
        $DRY_RUN || mv -n "$file" "$destino/"
    done
}

# =========================
# Criar pastas
# =========================
criar_dir src
criar_dir tb
criar_dir includes
criar_dir scripts
criar_dir docs

# =========================
# Regras
# =========================
mover "*_tb.v" tb

for file in *.v; do
    [[ "$file" == *_tb.v ]] && continue
    [[ -e "$file" ]] && mover "$file" src
done

mover "*.vh" includes
mover "*.tcl" scripts
mover "*.do" scripts
mover "*.md" docs

echo "[OK] Organização concluída!"
