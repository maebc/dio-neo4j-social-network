# dio-neo4j-social-network
Análise de conexões de redes sociais utilizando Neo4j, Cypher e boas práticas de integridade de dados (Desafio DIO).
# Análise de Redes Sociais com Neo4j 🌐

Este repositório contém o desafio prático de modelagem de dados em grafos, desenvolvido para o módulo de banco de dados NoSQL da **DIO (Digital Innovation One)**. O projeto foca em como o Neo4j otimiza a análise de conexões complexas e a integridade de dados em redes sociais.

## 📊 Visualização do Grafo
![Resultado do Script de Carga](image_01095a.jpg)

## 🚀 Sobre o Projeto

Como profissional focada em **Automação e IA**, utilizei este desafio para explorar como bancos de dados orientados a grafos superam os modelos relacionais tradicionais (SQL) em cenários de alta conectividade, como sugestões de amizade e análise de influência.

### Diferenciais Implementados:
- **Constraints de Unicidade:** Garantia de que IDs de `Usuario`, `Post` e `Topico` sejam únicos, evitando redundância na ingestão de dados.
- **Consultas Cypher de Valor:** Implementação de lógica para encontrar "Amigos de Amigos" e recomendações de conteúdo baseado em tópicos.
- **Modelagem de Relacionamentos:** Estrutura clara usando os verbos `SEGUE`, `POSTOU` e `PERTENCE_A`.

## 🛠️ Tecnologias Utilizadas
- **Neo4j AuraDB** (Cloud Database)
- **Cypher Query Language** (Linguagem de consulta)
- **Arrows.app** (Modelagem visual)

## 🔍 Consultas de Destaque

### Sugestão de Amizade (Network Expansion)
Esta query identifica usuários que seus amigos seguem, mas você ainda não, ranqueando-os por amigos em comum:
```cypher
MATCH (u:Usuario {nome: "Eliana"})-[:SEGUE]->(amigo)-[:SEGUE]->(sugestao)
WHERE NOT (u)-[:SEGUE]->(sugestao) AND sugestao <> u
RETURN sugestao.nome AS Recomendacao, count(*) AS AmigosEmComum
ORDER BY AmigosEmComum DESC;

---
**Desenvolvido por Mayra Carvalho** *Gestora de Automação e IA | Estudante de Cibersegurança*
