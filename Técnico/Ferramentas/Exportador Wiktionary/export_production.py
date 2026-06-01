#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Wiktionary Production Script - Large Scale Export
Script de produção para exportar centenas de milhares ou milhões de páginas

Use este script para exportações massivas em background
"""

import sys
from wiktionary_exporter import WiktionaryExporter, logger


def export_large_scale_batch():
    """
    Script de produção para exportar múltiplas categorias
    Ideal para rodar com: nohup python export_production.py > export.log 2>&1 &
    """
    
    logger.info("="*80)
    logger.info("INICIO - EXPORTAÇÃO MASSIVA DE PRODUÇÃO")
    logger.info("="*80)
    
    exporter = WiktionaryExporter()
    
    # ========================================================================
    # CONFIGURAÇÃO DE CATEGORIAS PARA EXPORTAR
    # ========================================================================
    # Cada item é uma exportação independente com seu próprio arquivo
    
    export_jobs = [
        # JOB 1: Todos os nouns em inglês
        {
            'name': 'English Nouns Complete',
            'config': {
                'category': 'English nouns',
                'section': 'Definition',
                'max_depth': 4,
                'max_pages': None,  # Sem limite - vai exportar TUDO
                'exclude_keywords': ['obsolete', 'archaic', 'rare', 'obsolete', 'dialectal']
            }
        },
        
        # JOB 2: Todos os verbs em inglês
        {
            'name': 'English Verbs Complete',
            'config': {
                'category': 'English verbs',
                'section': 'Definition',
                'max_depth': 4,
                'max_pages': None,
                'exclude_keywords': ['obsolete', 'archaic', 'rare']
            }
        },
        
        # JOB 3: Todos os adjectives
        {
            'name': 'English Adjectives Complete',
            'config': {
                'category': 'English adjectives',
                'section': 'Definition',
                'max_depth': 4,
                'max_pages': None,
                'exclude_keywords': ['obsolete', 'archaic', 'rare']
            }
        },
        
        # JOB 4: Etimologias (muitas páginas!)
        {
            'name': 'Etymology Complete',
            'config': {
                'category': 'English lemmas',
                'section': 'Etymology',
                'max_depth': 5,
                'max_pages': None,
                'exclude_keywords': ['obsolete', 'archaic']
            }
        },
        
        # JOB 5: Pronunciations
        {
            'name': 'English Pronunciation Complete',
            'config': {
                'category': 'English lemmas',
                'section': 'Pronunciation',
                'max_depth': 5,
                'max_pages': None
            }
        },
    ]
    
    # ========================================================================
    # EXECUTE EXPORTS
    # ========================================================================
    
    total_jobs = len(export_jobs)
    failed_jobs = []
    successful_jobs = []
    
    for job_index, job in enumerate(export_jobs, 1):
        job_name = job['name']
        job_config = job['config']
        
        print(f"\n\n")
        print("█" * 80)
        print(f"JOB {job_index}/{total_jobs}: {job_name}")
        print("█" * 80)
        print(f"Categoria: {job_config['category']}")
        print(f"Seção: {job_config['section']}")
        print(f"Profundidade: {job_config['max_depth']}")
        print(f"Máximo de páginas: {job_config.get('max_pages', 'Sem limite')}")
        print("█" * 80)
        
        try:
            exporter.export(**job_config)
            successful_jobs.append(job_name)
            logger.info(f"✅ JOB SUCESSO: {job_name}")
            
        except KeyboardInterrupt:
            logger.warning(f"⚠️  JOB CANCELADO: {job_name}")
            print(f"\n⚠️  Job {job_name} cancelado. Parando exportação.")
            break
            
        except Exception as e:
            logger.error(f"❌ JOB FALHOU: {job_name} - {e}")
            failed_jobs.append({
                'name': job_name,
                'error': str(e)
            })
            # Continua com próximo job ao invés de parar tudo
            print(f"\n❌ Job {job_name} falhou, continuando com próximo...")
            continue
    
    # ========================================================================
    # RESUMO FINAL
    # ========================================================================
    
    print("\n\n")
    print("="*80)
    print("RESUMO DA EXPORTAÇÃO MASSIVA")
    print("="*80)
    print(f"Total de jobs: {total_jobs}")
    print(f"Jobs bem-sucedidos: {len(successful_jobs)}")
    print(f"Jobs falhados: {len(failed_jobs)}")
    print("")
    
    if successful_jobs:
        print("✅ SUCESSO:")
        for job_name in successful_jobs:
            print(f"   • {job_name}")
    
    if failed_jobs:
        print("\n❌ FALHAS:")
        for failed in failed_jobs:
            print(f"   • {failed['name']}: {failed['error']}")
    
    print("="*80)
    logger.info("FIM - EXPORTAÇÃO MASSIVA DE PRODUÇÃO")


# ============================================================================
# VERSÃO CUSTOMIZÁVEL
# ============================================================================

def export_custom():
    """
    Versão simples para você customizar os jobs
    Edite a seção abaixo com suas categorias desejadas
    """
    
    exporter = WiktionaryExporter()
    
    # CUSTOMIZE ISTO:
    category = 'English nouns'  # Mude aqui
    section = 'Definition'       # Mude aqui
    max_depth = 4
    max_pages = None
    
    exporter.export(
        category=category,
        section=section,
        max_depth=max_depth,
        max_pages=max_pages,
        exclude_keywords=['obsolete', 'archaic', 'rare']
    )


# ============================================================================
# VERSÃO PARALELA (experimental)
# ============================================================================

def export_parallel():
    """
    NOTA: Para paralelização real, rode múltiplas instâncias deste script
    em diferentes terminais/cron jobs, cada uma com seus próprios jobs.
    
    Exemplo (rodando 3 instâncias em paralelo):
        Terminal 1: python export_production.py > export_job1.log 2>&1 &
        Terminal 2: python export_production_nouns.py > export_job2.log 2>&1 &
        Terminal 3: python export_production_verbs.py > export_job3.log 2>&1 &
    
    Assim cada máquina/processo processa uma categoria, escalando bem!
    """
    print("""
    Para paralelizar, crie múltiplos scripts com jobs diferentes:
    
    export_production_nouns.py:
        - English nouns (Definition)
        - English nouns (Etymology)
    
    export_production_verbs.py:
        - English verbs (Definition)
        - English verbs (Etymology)
    
    export_production_adj.py:
        - English adjectives (Definition)
        - English adjectives (Etymology)
    
    Depois rode em paralelo:
        nohup python export_production_nouns.py > nouns.log 2>&1 &
        nohup python export_production_verbs.py > verbs.log 2>&1 &
        nohup python export_production_adj.py > adj.log 2>&1 &
    
    Monitore com:
        tail -F nouns.log
        tail -F verbs.log
        tail -F adj.log
    """)


# ============================================================================
# MAIN
# ============================================================================

if __name__ == '__main__':
    
    if len(sys.argv) > 1:
        cmd = sys.argv[1].lower()
        
        if cmd == 'batch':
            export_large_scale_batch()
        elif cmd == 'custom':
            export_custom()
        elif cmd == 'parallel':
            export_parallel()
        else:
            print(f"Comando desconhecido: {cmd}")
            print("\nUso: python export_production.py [batch|custom|parallel]")
            print("  batch   - Exporta múltiplos jobs em sequência (PADRÃO)")
            print("  custom  - Exporta uma categoria customizada")
            print("  parallel - Mostra instruções para paralelização")
    else:
        # PADRÃO: rodar batch
        export_large_scale_batch()
    
    print("\n✅ Programa finalizado!")
