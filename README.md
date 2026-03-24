# dio-neo4j-social-network
Análise de conexões de redes sociais utilizando Neo4j, Cypher e boas práticas de integridade de dados (Desafio DIO).
# Análise de Redes Sociais com Neo4j 🌐

Este projeto foi desenvolvido como parte do desafio prático da **DIO (Digital Innovation One)**. O objetivo é demonstrar a aplicação de bancos de dados baseados em grafos para modelar e analisar conexões complexas em uma rede social focada em tecnologia.

## 🚀 Sobre o Projeto

Como Gestora de Automação e IA, busquei aplicar os conceitos de **Neo4j** para resolver problemas de escalabilidade e performance em consultas de relacionamentos (como "Amigos de Amigos"), que seriam custosas em bancos de dados relacionais tradicionais.

### Diferenciais Técnicos Aplicados:
* **Integridade de Dados:** Uso de `Constraints` de unicidade para garantir que IDs de usuários e posts não se dupliquem.
* **Otimização:** Implementação de índices para buscas rápidas por propriedades específicas.
* **Modelagem Eficiente:** Estrutura de grafos permitindo saltos (*hops*) rápidos entre Usuários, Posts e Tópicos de interesse.

## 📊 Modelo do Grafo

O modelo consiste em:
- **Labels:** `Usuario`, `Post`, `Topico`.
- **Relacionamentos:** - `(:Usuario)-[:SEGUE]->(:Usuario)`
  - `(:Usuario)-[:POSTOU]->(:Post)`
  - `(:Post)-[:PERTENCE_A]->(:Topico)`

## 🔍 Exemplos de Consultas (Cypher)

### 1. Recomendação de Amizade (Network Growth)
Busca por amigos de amigos que o usuário ainda não segue:
```cypher
MATCH (u:Usuario {nome: "Eliana"})-[:SEGUE]->(amigo)-[:SEGUE]->(sugestao)
WHERE NOT (u)-[:SEGUE]->(sugestao) AND sugestao <> u
RETURN sugestao.nome, count(*) AS conexoes_em_comum;
