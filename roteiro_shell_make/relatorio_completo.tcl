################################################################################
# LEITURA ÚNICA DO ARQUIVO NETLIST
################################################################################

# Abrir arquivo de saída para salvar o relatório
if {[catch {open "relatorio_final.txt" w} output_file]} {
    puts "Erro ao abrir arquivo de saída: $output_file"
    return
}

# Abrir e ler o netlist.v uma única vez
if {[catch {open "netlist.v" r} f]} {
    puts $output_file "Erro ao abrir o arquivo: $f"
    close $output_file
    return
}

set conteudo [read $f]
close $f

set linhas [split $conteudo "\n"]

################################################################################
# TAREFA 1: CONTAGEM DE CÉLULAS
################################################################################

set count_and2 0
set count_xor2 0
set count_ff 0

foreach linha $linhas {
    # Procura por AND2
    if {[regexp {\yAND2\y} $linha]} {
        incr count_and2
    }
    # Procura por XOR2
    if {[regexp {\yXOR2\y} $linha]} {
        incr count_xor2
    }
    # Procura por flipflop_D
    if {[regexp {\yflipflop_D\y} $linha]} {
        incr count_ff
    }
}

# Calcular o total
set total [expr {$count_and2 + $count_xor2 + $count_ff}]

# Gerar o relatório formatado
puts $output_file "--- RELATÓRIO DE CÉLULAS ---"
puts $output_file "AND2: $count_and2 instâncias"
puts $output_file "XOR2: $count_xor2 instâncias"
puts $output_file "flipflop_D: $count_ff instâncias"
puts $output_file "TOTAL: $total instâncias"
puts $output_file ""

################################################################################
# TAREFA 2: HIERARQUIA DO DESIGN
################################################################################

# Estruturas para análise de hierarquia
set modulo_atual ""
set modulos {}
array set hierarquia {}
array set tem_primitiva {}

# Identificar módulos
foreach linha $linhas {
    if {[regexp {^module\s+(\w+)} $linha -> nome]} {
        set modulo_atual $nome
        lappend modulos $nome
        set hierarquia($nome) {}
        set tem_primitiva($nome) 0
    }
}

# Identificar instâncias
set modulo_atual ""

foreach linha $linhas {

    # detectar início de módulo
    if {[regexp {^module\s+(\w+)} $linha -> nome]} {
        set modulo_atual $nome
        continue
    }

    # detectar fim de módulo
    if {[regexp {^endmodule} $linha]} {
        set modulo_atual ""
        continue
    }

    # detectar instâncias
    if {$modulo_atual ne ""} {

        if {[regexp {^\s*(\w+)\s+\w+\s*\(} $linha -> tipo]} {

            # se for submódulo
            if {[lsearch $modulos $tipo] != -1} {
                lappend hierarquia($modulo_atual) $tipo
            } else {
                # é célula primitiva
                set tem_primitiva($modulo_atual) 1
            }
        }
    }
}

# Imprimir relatório
puts $output_file "=== HIERARQUIA DO DESIGN ===\n"

foreach mod [lsort $modulos] {

    puts $output_file $mod

    set subs $hierarquia($mod)

    # Caso 1: não tem nada
    if {[llength $subs] == 0 && !$tem_primitiva($mod)} {
        puts $output_file "  └── (módulo primitivo - sem submódulos)"
    } else {

        # Se tiver submódulos → agrupar
        if {[llength $subs] > 0} {

            array set contagem {}

            foreach sub $subs {
                if {![info exists contagem($sub)]} {
                    set contagem($sub) 0
                }
                incr contagem($sub)
            }

            foreach sub [array names contagem] {
                puts $output_file "  └── $sub ($contagem($sub) instâncias)"
            }
        }

        # Se tiver primitivas
        if {$tem_primitiva($mod)} {

            # Se não tem submódulos
            if {[llength $subs] == 0} {
                puts $output_file "  └── (apenas células primitivas)"
            } else {
                puts $output_file "  └── (células primitivas)"
            }
        }
    }

    puts $output_file ""
}

################################################################################
# TAREFA 3: ANÁLISE DE FANOUT
################################################################################

# Dicionário de fanout
array set fanout {}

# Percorrer linhas
foreach linha $linhas {

    # Capturar conteúdo dentro dos parênteses
    if {[regexp {\((.*)\)} $linha -> dentro]} {

        # Separar os pares .pin(net)
        set sinais [split $dentro ","]

        # Extrair o nome da net de cada .pin(net)
        set nets {}
        foreach s $sinais {
            # Remove espaços extras
            set s [string trim $s]
            # Extrai o nome da net: .pin(net) -> net
            if {[regexp {\.\w+\(([^)]+)\)} $s -> net_name]} {
                lappend nets $net_name
            }
        }

        # Considera que o último elemento da lista é a saída,
        # os anteriores são entradas (entradas para fanout)
        if {[llength $nets] >= 1} {
            # Entradas: todos exceto o último
            set entradas [lrange $nets 0 end-1]
            foreach net $entradas {
                if {![info exists fanout($net)]} {
                    set fanout($net) 0
                }
                incr fanout($net)
            }

            # Saída: garante que exista no dicionário (para listar fanout zero)
            set saida [lindex $nets end]
            if {![info exists fanout($saida)]} {
                set fanout($saida) 0
            }
        }
    }
}

# Converter para lista ordenável
set lista {}
foreach net [array names fanout] {
    lappend lista [list $fanout($net) $net]
}

# Ordenar por fanout (decrescente)
set lista_ordenada [lsort -integer -decreasing -index 0 $lista]

# Top 10
puts $output_file "=== TOP 10 NETS POR FANOUT ==="
set i 0
foreach item $lista_ordenada {
    if {$i >= 10} break
    set valor [lindex $item 0]
    set nome [lindex $item 1]
    puts $output_file "$nome: fanout = $valor"
    incr i
}
puts $output_file ""

# Nets com fanout zero (possíveis erros)
puts $output_file "=== NETS COM FANOUT ZERO (POSSÍVEIS ERROS) ==="
foreach net [array names fanout] {
    if {$fanout($net) == 0} {
        puts $output_file $net
    }
}

# Fechar arquivo de saída
close $output_file
puts "Relatório salvo em: relatorio_final.txt"
