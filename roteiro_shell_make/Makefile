# ============================================================================
# Makefile para Automação de Relatório e Organização de Arquivos
# ============================================================================

# VARIÁVEIS
RELATORIO_FINAL := relatorio_final.txt
SCRIPT_TCL := relatorio_completo.tcl
SCRIPT_SHELL := organizador.sh
TCL_INTERPRETER := tclsh

# ============================================================================
# TARGETS
# ============================================================================

# Target padrão
.PHONY: all
all: organize report

# ============================================================================
# Target: report
# Gera o relatório final executando o script TCL
# Pré-requisito: arquivo de script TCL deve existir
# ============================================================================
.PHONY: report
report: $(RELATORIO_FINAL)

$(RELATORIO_FINAL): $(SCRIPT_TCL)
	@echo "Gerando relatório com $(SCRIPT_TCL)..."
	$(TCL_INTERPRETER) $(SCRIPT_TCL) > $(RELATORIO_FINAL)
	@echo "Relatório gerado: $(RELATORIO_FINAL)"

# ============================================================================
# Target: organize
# Executa o script shell para criar pastas e organizar arquivos
# Pré-requisito: arquivo de script shell deve existir
# ============================================================================
.PHONY: organize
organize: $(SCRIPT_SHELL)
	@echo "Organizando arquivos com $(SCRIPT_SHELL)..."
	@bash $(SCRIPT_SHELL)
	@echo "Arquivos organizados com sucesso"

# ============================================================================
# Target: clean
# Remove o arquivo de relatório final
# ============================================================================
.PHONY: clean
clean:
	@echo "Removendo $(RELATORIO_FINAL)..."
	@rm -f $(RELATORIO_FINAL)
	@echo "Limpeza concluída"
	
# ============================================================================
# Target: help
# Exibe informações sobre os targets disponíveis
# ============================================================================
.PHONY: help
help:
	@echo "Targets disponíveis:"
	@echo "  make all       - Executa organize e report (padrão)"
	@echo "  make organize  - Cria pastas tb e src, organiza arquivos"
	@echo "  make report    - Gera relatório final (se não existir)"
	@echo "  make clean     - Remove o arquivo de relatório"
	@echo "  make help      - Exibe esta mensagem"
