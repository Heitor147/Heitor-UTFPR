#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Quick Start / Test Script
Para testar rápido o exporter com uma categoria pequena
"""

from wiktionary_exporter import WiktionaryExporter, logger


def test_small():
    """Testa com categoria pequena (rápido, ~1 minuto)"""
    print("🧪 TEST 1: Pequena exportação (teste rápido)")
    print("-" * 60)
    
    exporter = WiktionaryExporter()
    exporter.export(
        category='English nouns starting with A',
        section='Definition',
        max_depth=1,
        max_pages=50,  # Limitado para teste
        exclude_keywords=['obsolete']
    )


def test_medium():
    """Testa com categoria médio (~5 minutos)"""
    print("\n🧪 TEST 2: Exportação média (alguns minutos)")
    print("-" * 60)
    
    exporter = WiktionaryExporter()
    exporter.export(
        category='English animals',
        section='Definition',
        max_depth=2,
        max_pages=500,
        include_keywords=['animal', 'creature']
    )


def test_filters():
    """Testa sistema de filtros"""
    print("\n🧪 TEST 3: Testando filtros")
    print("-" * 60)
    
    exporter = WiktionaryExporter()
    exporter.export(
        category='English nouns',
        section='Definition',
        max_depth=1,
        max_pages=100,
        include_keywords=['fruit', 'vegetable', 'plant'],  # Inclui
        exclude_keywords=['obsolete', 'rare']                # Exclui
    )


def test_section():
    """Testa extração de seções diferentes"""
    print("\n🧪 TEST 4: Testando seções")
    print("-" * 60)
    
    exporter = WiktionaryExporter()
    
    # Teste 1: Definition
    print("\n  • Extraindo seção 'Definition'...")
    exporter.export(
        category='English nouns starting with B',
        section='Definition',
        max_depth=1,
        max_pages=20
    )
    
    # Teste 2: Etymology
    print("\n  • Extraindo seção 'Etymology'...")
    exporter.export(
        category='English nouns starting with C',
        section='Etymology',
        max_depth=1,
        max_pages=20
    )


def test_resume():
    """Testa capacidade de resumir exportação"""
    print("\n🧪 TEST 5: Testando checkpoint/resume")
    print("-" * 60)
    
    exporter = WiktionaryExporter()
    
    print("  1/3 - Primeira exportação (30 páginas)...")
    exporter.export(
        category='English words',
        section='Definition',
        max_depth=1,
        max_pages=30
    )
    
    print("\n  2/3 - Segunda exportação (30+30=60 total, mas pula os 30 anteriores)...")
    exporter.export(
        category='English words',
        section='Definition',
        max_depth=1,
        max_pages=60
    )
    
    print("\n  ✅ Verificar se adicionou apenas +30 (não reexportou as primeiras 30)")


def performance_test():
    """Testa performance requisite 500K+ páginas (demo)"""
    print("\n🧪 PERFORMANCE TEST: Exportação grande (demo)")
    print("-" * 60)
    
    exporter = WiktionaryExporter()
    
    import time
    start = time.time()
    
    exporter.export(
        category='English lemmas',
        section='Definition',
        max_depth=4,
        max_pages=10000,  # 10K para teste
        exclude_keywords=['obsolete']
    )
    
    elapsed = time.time() - start
    print(f"\n⏱️  Tempo total: {elapsed:.1f} segundos")
    print(f"📊 Taxa: ~{10000/(elapsed/60):.0f} páginas/minuto")
    print(f"📈 Estima para 1M páginas: ~{(1000000/(10000/(elapsed/60)))/60:.1f} horas")


def interactive_menu():
    """Menu interativo para escolher teste"""
    print("\n")
    print("=" * 60)
    print("WIKTIONARY EXPORTER - QUICK START TESTS")
    print("=" * 60)
    print("""
1. Teste pequeno (50 páginas, ~1 min)
2. Teste médio (500 páginas, ~5 min)
3. Teste filtros (100 páginas com filtros)
4. Teste seções (Definition + Etymology)
5. Teste resume/checkpoint (simula interrupção)
6. Teste performance (10K páginas)
7. Tudo (todos os testes)
    """)
    
    choice = input("Escolha [1-7]: ").strip()
    
    if choice == '1':
        test_small()
    elif choice == '2':
        test_medium()
    elif choice == '3':
        test_filters()
    elif choice == '4':
        test_section()
    elif choice == '5':
        test_resume()
    elif choice == '6':
        performance_test()
    elif choice == '7':
        test_small()
        test_medium()
        test_filters()
        test_section()
        test_resume()
        performance_test()
    else:
        print("❌ Opção inválida!")


if __name__ == '__main__':
    try:
        interactive_menu()
        print("\n✅ Testes concluídos!")
    except KeyboardInterrupt:
        print("\n\n⚠️  Testes cancelados")
    except Exception as e:
        logger.exception("Erro durante testes")
        raise
