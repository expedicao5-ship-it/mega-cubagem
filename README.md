# Mega Cubagem 2.0

Sistema de planejamento de carregamento com React + Vite + Three.js + Supabase.

## 1. Rodar no GitHub Codespaces

```bash
npm install
npm run dev -- --host 0.0.0.0
```

## 2. Banco de dados

No Supabase, abra SQL Editor e execute `supabase/schema.sql`.

Depois copie `.env.example` para `.env` e informe:
- VITE_SUPABASE_URL
- VITE_SUPABASE_ANON_KEY

Se as variáveis não forem configuradas, o sistema funciona em modo local para demonstração.

## 3. Autenticação

O login usa Supabase Auth por e-mail e senha quando o Supabase estiver configurado.

## Módulos
- Login
- Dashboard
- Produtos
- Veículos
- Carregamentos
- Visualização 3D
- Relatórios
- Banco de dados por usuário

## Próxima evolução
O banco já possui estrutura para carregar itens e posições. O próximo motor poderá implementar 3D Bin Packing, orientação, empilhamento, distribuição de peso e otimização.