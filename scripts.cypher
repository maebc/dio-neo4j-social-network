// -------------------------------------------------------------------------
// PROJETO: Análise de Redes Sociais com Neo4j
// DESCRIÇÃO: Script de criação de schema, carga de dados e consultas de teste
// AUTORA: [Seu Nome] - Gid'On Tech
// -------------------------------------------------------------------------

// 1. LIMPEZA DO BANCO (Opcional - Use com cautela)
// MATCH (n) DETACH DELETE n;

// 2. CONFIGURAÇÃO DE INTEGRIDADE (CONSTRAINTS)
// Garante que não existam IDs duplicados para as entidades principais
CREATE CONSTRAINT IF NOT EXISTS FOR (u:Usuario) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (p:Post) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Topico) REQUIRE t.id IS UNIQUE;

// 3. CARGA DE DADOS (NODES)
// Criando os usuários da rede
MERGE (u1:Usuario {id: 1, nome: "Eliana", cidade: "Juiz de Fora", cargo: "Gestora de IA"})
MERGE (u2:Usuario {id: 2, nome: "Bruno", cidade: "Belo Horizonte", cargo: "Engenheiro de Dados"})
MERGE (u3:Usuario {id: 3, nome: "Carla", cidade: "São Paulo", cargo: "Dev Backend"})
MERGE (u4:Usuario {id: 4, nome: "Daniel", cidade: "Curitiba", cargo: "Analista de Segurança"})
MERGE (u5:Usuario {id: 5, nome: "Fernanda", cidade: "Rio de Janeiro", cargo: "Cientista de Dados"});

// Criando os tópicos de interesse
MERGE (t1:Topico {id: 101, nome: "Inteligência Artificial"})
MERGE (t2:Topico {id: 102, nome: "Automação"})
MERGE (t3:Topico {id: 103, nome: "Grafos"});

// 4. CRIAÇÃO DE RELACIONAMENTOS (EDGES)
// Estabelecendo conexões de "Seguir"
MATCH (a:Usuario {nome: "Eliana"}), (b:Usuario {nome: "Bruno"}) MERGE (a)-[:SEGUE]->(b);
MATCH (a:Usuario {nome: "Eliana"}), (c:Usuario {nome: "Carla"}) MERGE (a)-[:SEGUE]->(c);
MATCH (b:Usuario {nome: "Bruno"}), (f:Usuario {nome: "Fernanda"}) MERGE (b)-[:SEGUE]->(f);
MATCH (c:Usuario {nome: "Carla"}), (d:Usuario {nome: "Daniel"}) MERGE (c)-[:SEGUE]->(d);

// Criando um post e conectando ao autor e ao tópico
CREATE (p1:Post {id: 501, conteudo: "Explorando grafos para automação legal!", data: "2026-03-24"})
WITH p1
MATCH (u:Usuario {nome: "Eliana"}), (t:Topico {nome: "Automação"})
MERGE (u)-[:POSTOU]->(p1)
MERGE (p1)-[:PERTENCE_A]->(t);

// 5. CONSULTAS DE EXEMPLO (BUSINESS INSIGHTS)

// Sugestão de Amizade (Amigos de Amigos que eu não sigo)
MATCH (u:Usuario {nome: "Eliana"})-[:SEGUE]->(amigo)-[:SEGUE]->(sugestao)
WHERE NOT (u)-[:SEGUE]->(sugestao) AND sugestao <> u
RETURN sugestao.nome AS Recomendacao, count(*) AS AmigosEmComum;

// Visualizar todo o grafo gerado
MATCH (n) RETURN n;
