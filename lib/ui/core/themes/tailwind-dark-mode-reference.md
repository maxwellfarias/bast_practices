# Guia Completo de Conversão de Cores Tailwind CSS: Light Mode → Dark Mode

Este documento serve como referência para conversão de cores do Tailwind CSS entre os modos claro e escuro, seguindo padrões comuns de UI/UX e práticas utilizadas por ferramentas como Google Stitch, Flowbite e outras bibliotecas de componentes.

---

## 📐 Princípio Fundamental

A regra geral de inversão é: **Light (X) → Dark (1000 - X)**

Exemplos:
- `gray-100` → `gray-900`
- `gray-200` → `gray-800`
- `gray-300` → `gray-700`
- `gray-600` → `gray-400`

---

## 🎨 Cores Neutras (Gray/Slate/Zinc/Neutral/Stone)

### Fundos (Backgrounds)

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-white` | `dark:bg-gray-900` | Fundo principal da página |
| `bg-white` | `dark:bg-gray-800` | Cards, modais, containers |
| `bg-gray-50` | `dark:bg-gray-900` | Fundo alternativo/secundário |
| `bg-gray-100` | `dark:bg-gray-800` | Cards, seções destacadas |
| `bg-gray-200` | `dark:bg-gray-700` | Elementos de UI, badges |
| `bg-gray-300` | `dark:bg-gray-600` | Estados desabilitados |
| `bg-gray-400` | `dark:bg-gray-500` | Elementos neutros |
| `bg-gray-500` | `dark:bg-gray-400` | Elementos neutros |
| `bg-gray-600` | `dark:bg-gray-300` | Ícones, elementos secundários |
| `bg-gray-700` | `dark:bg-gray-200` | Textos em fundos claros |
| `bg-gray-800` | `dark:bg-gray-100` | Fundos escuros invertidos |
| `bg-gray-900` | `dark:bg-gray-50` | Fundos muito escuros invertidos |

### Textos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `text-black` | `dark:text-white` | Texto de máximo contraste |
| `text-gray-900` | `dark:text-white` | Títulos principais (h1, h2) |
| `text-gray-800` | `dark:text-gray-100` | Títulos secundários (h3, h4) |
| `text-gray-700` | `dark:text-gray-200` | Texto de corpo principal |
| `text-gray-600` | `dark:text-gray-300` | Texto secundário |
| `text-gray-500` | `dark:text-gray-400` | Texto de apoio, labels |
| `text-gray-400` | `dark:text-gray-500` | Placeholders, texto desabilitado |
| `text-gray-300` | `dark:text-gray-600` | Texto muito sutil |
| `text-white` | `dark:text-gray-900` | Texto em fundos escuros |

### Bordas

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `border-gray-100` | `dark:border-gray-800` | Bordas muito sutis |
| `border-gray-200` | `dark:border-gray-700` | Bordas de cards, containers |
| `border-gray-300` | `dark:border-gray-600` | Bordas de inputs, selects |
| `border-gray-400` | `dark:border-gray-500` | Bordas médias |
| `border-gray-500` | `dark:border-gray-400` | Bordas destacadas |
| `border-gray-600` | `dark:border-gray-300` | Bordas fortes |
| `border-gray-700` | `dark:border-gray-200` | Bordas muito fortes |

### Divisores (Dividers)

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `divide-gray-100` | `dark:divide-gray-800` | Divisores sutis |
| `divide-gray-200` | `dark:divide-gray-700` | Divisores padrão |
| `divide-gray-300` | `dark:divide-gray-600` | Divisores destacados |

### Rings (Focus/Outline)

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `ring-gray-200` | `dark:ring-gray-700` | Ring sutil |
| `ring-gray-300` | `dark:ring-gray-600` | Ring padrão |
| `ring-gray-400` | `dark:ring-gray-500` | Ring médio |
| `ring-gray-900/5` | `dark:ring-gray-100/5` | Sombra sutil (shadow-like) |
| `ring-gray-900/10` | `dark:ring-gray-100/10` | Sombra média |

### Sombras com Cores

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `shadow-gray-100` | `dark:shadow-gray-900` | Sombra clara |
| `shadow-gray-200` | `dark:shadow-gray-800` | Sombra padrão |
| `shadow-gray-500/20` | `dark:shadow-black/30` | Sombra com opacidade |

---

## 🔵 Cores Primárias (Blue)

### Fundos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-blue-50` | `dark:bg-blue-950` | Fundo sutil azul |
| `bg-blue-100` | `dark:bg-blue-900` | Badges, alertas info |
| `bg-blue-200` | `dark:bg-blue-800` | Elementos destacados |
| `bg-blue-500` | `dark:bg-blue-500` | Botões primários (mantém) |
| `bg-blue-600` | `dark:bg-blue-500` | Botões primários hover |
| `bg-blue-700` | `dark:bg-blue-400` | Estados ativos |

### Textos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `text-blue-500` | `dark:text-blue-400` | Links padrão |
| `text-blue-600` | `dark:text-blue-400` | Links, texto de destaque |
| `text-blue-700` | `dark:text-blue-300` | Links hover |
| `text-blue-800` | `dark:text-blue-200` | Texto azul forte |
| `text-blue-900` | `dark:text-blue-100` | Texto azul muito forte |

### Bordas

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `border-blue-200` | `dark:border-blue-800` | Borda sutil azul |
| `border-blue-300` | `dark:border-blue-700` | Borda de inputs focus |
| `border-blue-500` | `dark:border-blue-400` | Borda destacada |

### Rings (Focus)

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `ring-blue-500` | `dark:ring-blue-400` | Focus ring primário |
| `focus:ring-blue-500` | `dark:focus:ring-blue-400` | Estado de foco |

---

## 🟢 Cores de Sucesso (Green)

### Fundos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-green-50` | `dark:bg-green-950` | Fundo de alerta sucesso |
| `bg-green-100` | `dark:bg-green-900` | Badge de sucesso |
| `bg-green-200` | `dark:bg-green-800` | Destaque positivo |
| `bg-green-500` | `dark:bg-green-500` | Botão de sucesso (mantém) |
| `bg-green-600` | `dark:bg-green-500` | Botão sucesso hover |

### Textos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `text-green-500` | `dark:text-green-400` | Texto de sucesso |
| `text-green-600` | `dark:text-green-400` | Mensagens positivas |
| `text-green-700` | `dark:text-green-300` | Texto verde forte |
| `text-green-800` | `dark:text-green-200` | Labels de sucesso |

### Bordas

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `border-green-200` | `dark:border-green-800` | Borda sutil verde |
| `border-green-300` | `dark:border-green-700` | Borda de sucesso |
| `border-green-500` | `dark:border-green-400` | Borda destacada |

---

## 🔴 Cores de Erro/Perigo (Red)

### Fundos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-red-50` | `dark:bg-red-950` | Fundo de alerta erro |
| `bg-red-100` | `dark:bg-red-900` | Badge de erro |
| `bg-red-200` | `dark:bg-red-800` | Destaque negativo |
| `bg-red-500` | `dark:bg-red-500` | Botão de perigo (mantém) |
| `bg-red-600` | `dark:bg-red-500` | Botão perigo hover |

### Textos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `text-red-500` | `dark:text-red-400` | Texto de erro |
| `text-red-600` | `dark:text-red-400` | Mensagens de erro |
| `text-red-700` | `dark:text-red-300` | Texto vermelho forte |
| `text-red-800` | `dark:text-red-200` | Labels de erro |

### Bordas

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `border-red-200` | `dark:border-red-800` | Borda sutil vermelha |
| `border-red-300` | `dark:border-red-700` | Borda de erro |
| `border-red-500` | `dark:border-red-400` | Borda de erro destacada |

---

## 🟡 Cores de Aviso (Yellow/Amber)

### Fundos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-yellow-50` | `dark:bg-yellow-950` | Fundo de alerta warning |
| `bg-yellow-100` | `dark:bg-yellow-900` | Badge de aviso |
| `bg-yellow-200` | `dark:bg-yellow-800` | Destaque de atenção |
| `bg-amber-50` | `dark:bg-amber-950` | Fundo amber sutil |
| `bg-amber-100` | `dark:bg-amber-900` | Badge amber |

### Textos

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `text-yellow-600` | `dark:text-yellow-400` | Texto de aviso |
| `text-yellow-700` | `dark:text-yellow-300` | Texto amarelo forte |
| `text-yellow-800` | `dark:text-yellow-200` | Labels de aviso |
| `text-amber-600` | `dark:text-amber-400` | Texto amber |
| `text-amber-700` | `dark:text-amber-300` | Texto amber forte |

### Bordas

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `border-yellow-200` | `dark:border-yellow-800` | Borda sutil amarela |
| `border-yellow-300` | `dark:border-yellow-700` | Borda de aviso |
| `border-amber-300` | `dark:border-amber-700` | Borda amber |

---

## 🟣 Cores Secundárias (Purple/Violet/Indigo)

### Purple

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-purple-50` | `dark:bg-purple-950` | Fundo sutil roxo |
| `bg-purple-100` | `dark:bg-purple-900` | Badge roxo |
| `bg-purple-500` | `dark:bg-purple-500` | Botão roxo (mantém) |
| `bg-purple-600` | `dark:bg-purple-500` | Botão roxo hover |
| `text-purple-600` | `dark:text-purple-400` | Texto roxo |
| `text-purple-700` | `dark:text-purple-300` | Texto roxo forte |
| `border-purple-200` | `dark:border-purple-800` | Borda sutil roxa |
| `border-purple-300` | `dark:border-purple-700` | Borda roxa |

### Indigo

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-indigo-50` | `dark:bg-indigo-950` | Fundo sutil indigo |
| `bg-indigo-100` | `dark:bg-indigo-900` | Badge indigo |
| `bg-indigo-500` | `dark:bg-indigo-500` | Botão indigo (mantém) |
| `bg-indigo-600` | `dark:bg-indigo-500` | Botão indigo hover |
| `text-indigo-600` | `dark:text-indigo-400` | Texto indigo |
| `text-indigo-700` | `dark:text-indigo-300` | Texto indigo forte |

### Violet

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-violet-50` | `dark:bg-violet-950` | Fundo sutil violeta |
| `bg-violet-100` | `dark:bg-violet-900` | Badge violeta |
| `bg-violet-500` | `dark:bg-violet-500` | Botão violeta (mantém) |
| `text-violet-600` | `dark:text-violet-400` | Texto violeta |

---

## 🩵 Cores Terciárias (Cyan/Teal/Sky)

### Cyan

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-cyan-50` | `dark:bg-cyan-950` | Fundo sutil ciano |
| `bg-cyan-100` | `dark:bg-cyan-900` | Badge ciano |
| `bg-cyan-500` | `dark:bg-cyan-500` | Botão ciano (mantém) |
| `text-cyan-600` | `dark:text-cyan-400` | Texto ciano |
| `text-cyan-700` | `dark:text-cyan-300` | Texto ciano forte |

### Teal

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-teal-50` | `dark:bg-teal-950` | Fundo sutil teal |
| `bg-teal-100` | `dark:bg-teal-900` | Badge teal |
| `bg-teal-500` | `dark:bg-teal-500` | Botão teal (mantém) |
| `text-teal-600` | `dark:text-teal-400` | Texto teal |

### Sky

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-sky-50` | `dark:bg-sky-950` | Fundo sutil sky |
| `bg-sky-100` | `dark:bg-sky-900` | Badge sky |
| `bg-sky-500` | `dark:bg-sky-500` | Botão sky (mantém) |
| `text-sky-600` | `dark:text-sky-400` | Texto sky |

---

## 🟠 Cores Quentes (Orange/Rose/Pink)

### Orange

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-orange-50` | `dark:bg-orange-950` | Fundo sutil laranja |
| `bg-orange-100` | `dark:bg-orange-900` | Badge laranja |
| `bg-orange-500` | `dark:bg-orange-500` | Botão laranja (mantém) |
| `text-orange-600` | `dark:text-orange-400` | Texto laranja |
| `text-orange-700` | `dark:text-orange-300` | Texto laranja forte |

### Rose

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-rose-50` | `dark:bg-rose-950` | Fundo sutil rose |
| `bg-rose-100` | `dark:bg-rose-900` | Badge rose |
| `bg-rose-500` | `dark:bg-rose-500` | Botão rose (mantém) |
| `text-rose-600` | `dark:text-rose-400` | Texto rose |

### Pink

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-pink-50` | `dark:bg-pink-950` | Fundo sutil pink |
| `bg-pink-100` | `dark:bg-pink-900` | Badge pink |
| `bg-pink-500` | `dark:bg-pink-500` | Botão pink (mantém) |
| `text-pink-600` | `dark:text-pink-400` | Texto pink |

---

## 🌿 Cores Naturais (Lime/Emerald)

### Lime

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-lime-50` | `dark:bg-lime-950` | Fundo sutil lime |
| `bg-lime-100` | `dark:bg-lime-900` | Badge lime |
| `bg-lime-500` | `dark:bg-lime-500` | Botão lime (mantém) |
| `text-lime-600` | `dark:text-lime-400` | Texto lime |

### Emerald

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `bg-emerald-50` | `dark:bg-emerald-950` | Fundo sutil emerald |
| `bg-emerald-100` | `dark:bg-emerald-900` | Badge emerald |
| `bg-emerald-500` | `dark:bg-emerald-500` | Botão emerald (mantém) |
| `text-emerald-600` | `dark:text-emerald-400` | Texto emerald |

---

## 🖱️ Estados Interativos

### Hover

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `hover:bg-gray-50` | `dark:hover:bg-gray-800` | Hover sutil |
| `hover:bg-gray-100` | `dark:hover:bg-gray-700` | Hover padrão |
| `hover:bg-gray-200` | `dark:hover:bg-gray-600` | Hover destacado |
| `hover:text-gray-900` | `dark:hover:text-white` | Hover texto |
| `hover:text-gray-700` | `dark:hover:text-gray-200` | Hover texto secundário |
| `hover:border-gray-300` | `dark:hover:border-gray-600` | Hover borda |
| `hover:border-gray-400` | `dark:hover:border-gray-500` | Hover borda forte |

### Focus

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `focus:ring-gray-200` | `dark:focus:ring-gray-700` | Focus ring sutil |
| `focus:ring-blue-500` | `dark:focus:ring-blue-400` | Focus ring primário |
| `focus:border-gray-400` | `dark:focus:border-gray-500` | Focus borda |
| `focus:border-blue-500` | `dark:focus:border-blue-400` | Focus borda primária |
| `focus:bg-gray-100` | `dark:focus:bg-gray-700` | Focus background |

### Active

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `active:bg-gray-200` | `dark:active:bg-gray-600` | Active background |
| `active:bg-blue-700` | `dark:active:bg-blue-600` | Active primário |

### Disabled

| Light Mode | Dark Mode | Uso |
|------------|-----------|-----|
| `disabled:bg-gray-100` | `dark:disabled:bg-gray-800` | Disabled background |
| `disabled:text-gray-400` | `dark:disabled:text-gray-500` | Disabled texto |
| `disabled:border-gray-200` | `dark:disabled:border-gray-700` | Disabled borda |

---

## 📦 Componentes Comuns

### Cards

```html
<!-- Light: fundo branco, borda cinza clara -->
<!-- Dark: fundo escuro, borda escura -->
<div class="bg-white dark:bg-gray-800 
            border border-gray-200 dark:border-gray-700 
            rounded-lg shadow-sm dark:shadow-gray-900/20">
  <h3 class="text-gray-900 dark:text-white">Título</h3>
  <p class="text-gray-600 dark:text-gray-300">Descrição</p>
</div>
```

### Inputs

```html
<input class="bg-white dark:bg-gray-700 
              border border-gray-300 dark:border-gray-600
              text-gray-900 dark:text-white
              placeholder-gray-400 dark:placeholder-gray-500
              focus:ring-blue-500 dark:focus:ring-blue-400
              focus:border-blue-500 dark:focus:border-blue-400" />
```

### Botões Primários

```html
<button class="bg-blue-600 dark:bg-blue-500 
               hover:bg-blue-700 dark:hover:bg-blue-600
               text-white
               focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-800">
  Botão Primário
</button>
```

### Botões Secundários

```html
<button class="bg-white dark:bg-gray-800 
               border border-gray-300 dark:border-gray-600
               text-gray-700 dark:text-gray-300
               hover:bg-gray-50 dark:hover:bg-gray-700
               focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700">
  Botão Secundário
</button>
```

### Botões Ghost

```html
<button class="text-gray-700 dark:text-gray-300
               hover:bg-gray-100 dark:hover:bg-gray-700
               focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700">
  Botão Ghost
</button>
```

### Alerts/Notifications

```html
<!-- Info -->
<div class="bg-blue-50 dark:bg-blue-950 
            border border-blue-200 dark:border-blue-800
            text-blue-800 dark:text-blue-200">
  Mensagem informativa
</div>

<!-- Success -->
<div class="bg-green-50 dark:bg-green-950 
            border border-green-200 dark:border-green-800
            text-green-800 dark:text-green-200">
  Mensagem de sucesso
</div>

<!-- Warning -->
<div class="bg-yellow-50 dark:bg-yellow-950 
            border border-yellow-200 dark:border-yellow-800
            text-yellow-800 dark:text-yellow-200">
  Mensagem de aviso
</div>

<!-- Error -->
<div class="bg-red-50 dark:bg-red-950 
            border border-red-200 dark:border-red-800
            text-red-800 dark:text-red-200">
  Mensagem de erro
</div>
```

### Badges/Tags

```html
<!-- Default -->
<span class="bg-gray-100 dark:bg-gray-700 
             text-gray-800 dark:text-gray-200">
  Badge
</span>

<!-- Primary -->
<span class="bg-blue-100 dark:bg-blue-900 
             text-blue-800 dark:text-blue-200">
  Primary
</span>

<!-- Success -->
<span class="bg-green-100 dark:bg-green-900 
             text-green-800 dark:text-green-200">
  Success
</span>
```

### Tables

```html
<table class="w-full">
  <thead class="bg-gray-50 dark:bg-gray-700">
    <tr>
      <th class="text-gray-700 dark:text-gray-200">Header</th>
    </tr>
  </thead>
  <tbody class="bg-white dark:bg-gray-800 
                divide-y divide-gray-200 dark:divide-gray-700">
    <tr class="hover:bg-gray-50 dark:hover:bg-gray-700">
      <td class="text-gray-900 dark:text-white">Célula</td>
    </tr>
  </tbody>
</table>
```

### Navigation

```html
<nav class="bg-white dark:bg-gray-900 
            border-b border-gray-200 dark:border-gray-700">
  <a href="#" class="text-gray-700 dark:text-gray-200 
                     hover:text-gray-900 dark:hover:text-white
                     hover:bg-gray-100 dark:hover:bg-gray-800">
    Link
  </a>
</nav>
```

### Sidebar

```html
<aside class="bg-gray-50 dark:bg-gray-800 
              border-r border-gray-200 dark:border-gray-700">
  <a href="#" class="text-gray-600 dark:text-gray-300
                     hover:text-gray-900 dark:hover:text-white
                     hover:bg-gray-100 dark:hover:bg-gray-700">
    Item do menu
  </a>
</aside>
```

### Modals/Dialogs

```html
<!-- Overlay -->
<div class="bg-gray-900/50 dark:bg-gray-900/80"></div>

<!-- Modal -->
<div class="bg-white dark:bg-gray-800 
            rounded-lg shadow-xl dark:shadow-gray-900/50">
  <div class="border-b border-gray-200 dark:border-gray-700">
    <h3 class="text-gray-900 dark:text-white">Título</h3>
  </div>
  <div class="text-gray-600 dark:text-gray-300">
    Conteúdo
  </div>
</div>
```

### Dropdowns

```html
<div class="bg-white dark:bg-gray-700 
            border border-gray-200 dark:border-gray-600
            rounded-lg shadow-lg dark:shadow-gray-900/50">
  <a href="#" class="text-gray-700 dark:text-gray-200
                     hover:bg-gray-100 dark:hover:bg-gray-600">
    Item do dropdown
  </a>
</div>
```

### Tooltips

```html
<div class="bg-gray-900 dark:bg-gray-700 
            text-white dark:text-gray-100
            rounded shadow-lg">
  Tooltip text
</div>
```

---

## 🔄 Regras de Conversão Rápida

### Escala de Cinza (Gray Scale)

| Light | Dark |
|-------|------|
| 50 | 950 |
| 100 | 900 |
| 200 | 800 |
| 300 | 700 |
| 400 | 600 |
| 500 | 500 |
| 600 | 400 |
| 700 | 300 |
| 800 | 200 |
| 900 | 100 |
| 950 | 50 |

### Cores Vibrantes (Blue, Green, Red, etc.)

Para cores vibrantes, a conversão é similar, mas com algumas exceções:

| Light | Dark | Nota |
|-------|------|------|
| 50 | 950 | Fundos sutis |
| 100 | 900 | Badges, alerts |
| 200 | 800 | Bordas sutis |
| 300 | 700 | Bordas |
| 400 | 500 | Elementos médios |
| 500 | 500 | Botões (mantém) |
| 600 | 400 | Textos, ícones |
| 700 | 300 | Textos fortes |
| 800 | 200 | Labels |
| 900 | 100 | Texto em fundos claros |

---

## ⚠️ Exceções e Notas Importantes

### 1. Botões Primários
Geralmente **mantêm** a mesma cor base (ex: `bg-blue-600`) e apenas ajustam o hover e focus.

### 2. Cores Saturadas
Cores muito saturadas (500-600) frequentemente se mantêm iguais ou mudam apenas 1-2 níveis.

### 3. Brancos e Pretos Puros
- `white` → `gray-900` ou `gray-800` (nunca `black` puro para melhor legibilidade)
- `black` → `white` ou `gray-50`

### 4. Opacidades
Em dark mode, opacidades geralmente precisam ser aumentadas ligeiramente para manter a mesma aparência visual.

| Light | Dark |
|-------|------|
| `/5` | `/10` |
| `/10` | `/20` |
| `/20` | `/30` |

### 5. Sombras
Em dark mode, sombras são menos visíveis e podem precisar de ajustes:
- Use cores mais escuras (ex: `shadow-gray-900` → `shadow-black`)
- Aumente a opacidade
- Ou use rings sutis como alternativa

---

## 📝 Template CSS Personalizado

Se preferir usar variáveis CSS para troca automática:

```css
@layer base {
  :root {
    /* Backgrounds */
    --color-bg-primary: theme('colors.white');
    --color-bg-secondary: theme('colors.gray.50');
    --color-bg-tertiary: theme('colors.gray.100');
    
    /* Text */
    --color-text-primary: theme('colors.gray.900');
    --color-text-secondary: theme('colors.gray.600');
    --color-text-tertiary: theme('colors.gray.500');
    
    /* Borders */
    --color-border-primary: theme('colors.gray.200');
    --color-border-secondary: theme('colors.gray.300');
  }
  
  .dark {
    /* Backgrounds */
    --color-bg-primary: theme('colors.gray.900');
    --color-bg-secondary: theme('colors.gray.800');
    --color-bg-tertiary: theme('colors.gray.700');
    
    /* Text */
    --color-text-primary: theme('colors.white');
    --color-text-secondary: theme('colors.gray.300');
    --color-text-tertiary: theme('colors.gray.400');
    
    /* Borders */
    --color-border-primary: theme('colors.gray.700');
    --color-border-secondary: theme('colors.gray.600');
  }
}
```

---

## 🛠️ Tailwind Config com Plugin Nightwind

Para conversão automática, considere usar o plugin [Nightwind](https://github.com/jjranalli/nightwind):

```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  plugins: [require('nightwind')],
  theme: {
    nightwind: {
      // Personalizações opcionais
      colors: {
        white: 'gray.900',
        black: 'gray.50',
      },
    },
  },
}
```

---

## 📚 Referências

- [Tailwind CSS Dark Mode](https://tailwindcss.com/docs/dark-mode)
- [Tailwind CSS Colors](https://tailwindcss.com/docs/colors)
- [Flowbite Dark Mode](https://flowbite.com/docs/customize/dark-mode/)
- [Nightwind Plugin](https://github.com/jjranalli/nightwind)

---

*Este documento foi criado como referência para desenvolvimento de interfaces com suporte a dark mode usando Tailwind CSS. Os mapeamentos são baseados em práticas comuns da indústria e podem ser ajustados conforme necessidades específicas do projeto.*
