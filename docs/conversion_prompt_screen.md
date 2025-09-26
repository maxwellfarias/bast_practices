# 🚀 TEMPLATE DE PROMPT PARA CONVERSÃO REACT → FLUTTER

## 📁 ARQUIVOS DE REFERÊNCIA ANEXADOS
- [ ] **Código React**: `lovable/src/pages/{nome_da_pagina}.tsx` - Componente principal a ser convertido
- [ ] **CSS/Styles**: `lovable/src/index.css` ou arquivo de estilos relevante
- [ ] **Guia de Conversão**: `docs/conversion_prompt_screen.md` - Referência completa
- [ ] **Extensões Flutter**: `lib/ui/core/extensions/build_context_extension.dart` - Extensões de contexto
- [ ] **Tema Flutter**: `lib/ui/core/themes/theme.dart` - Tema já configurado



### 🔹 ETAPA 1: UI SCREEN
**Path**: `/lib/ui/{nome_da_tela}/widget/{nome_da_tela}_screen.dart`


### 2. 🎨 Conversão de Estilos e Layout Responsivo
- [ ] **Tipografia**: Mapear classes CSS para CustomTextTheme
- [ ] **Cores**: Converter variáveis CSS para NewAppColorTheme
- [ ] **Espaçamentos**: Converter padding/margin Tailwind para EdgeInsets
- [ ] **Sombras e Elevação**: Mapear box-shadow para elevation

## 🎨 Mapeamento Detalhado de Estilos

### 📝 Tipografia (React Tailwind → Flutter CustomTextTheme)

| React Tailwind Class | Tamanho | Peso | Flutter Equivalent |
|---------------------|---------|------|-------------------|
| `text-4xl font-bold` | 36px | 700 | `context.customTextTheme.text4XlBold` |
| `text-3xl font-bold` | 30px | 700 | `context.customTextTheme.text3xlBold` |
| `text-2xl font-bold` | 24px | 700 | `context.customTextTheme.text2xlBold` |
| `text-xl font-semibold` | 20px | 600 | `context.customTextTheme.textXlSemibold` |
| `text-xl font-medium` | 20px | 500 | `context.customTextTheme.textXlMedium` |
| `text-lg font-semibold` | 18px | 600 | `context.customTextTheme.textLgSemibold` |
| `text-lg font-medium` | 18px | 500 | `context.customTextTheme.textLgMedium` |
| `text-base font-medium` | 16px | 500 | `context.customTextTheme.textBaseMedium` |
| `text-base` | 16px | 400 | `context.customTextTheme.textBase` |
| `text-sm font-semibold` | 14px | 600 | `context.customTextTheme.textSmSemibold` |
| `text-sm font-medium` | 14px | 500 | `context.customTextTheme.textSmMedium` |
| `text-sm` | 14px | 400 | `context.customTextTheme.textSm` |
| `text-xs font-medium` | 12px | 500 | `context.customTextTheme.textXsMedium` |
| `text-xs` | 12px | 400 | `context.customTextTheme.textXs` |

### 🎨 Cores (React CSS → Flutter NewAppColorTheme)

| React CSS Variable | Descrição | Flutter Equivalent |
|-------------------|-----------|-------------------|
| `--background` | Fundo principal | `context.customColorTheme.background` |
| `--foreground` | Texto principal | `context.customColorTheme.foreground` |
| `--primary` | Cor primária (azul médico) | `context.customColorTheme.primary` |
| `--primary-foreground` | Texto sobre primário | `context.customColorTheme.primaryForeground` |
| `--primary-light` | Primário claro | `context.customColorTheme.primaryLight` |
| `--primary-dark` | Primário escuro | `context.customColorTheme.primaryShade` |
| `--secondary` | Cor secundária | `context.customColorTheme.secondary` |
| `--secondary-foreground` | Texto sobre secundário | `context.customColorTheme.secondaryForeground` |
| `--success` | Verde de sucesso | `context.customColorTheme.success` |
| `--success-foreground` | Texto sobre sucesso | `context.customColorTheme.successForeground` |
| `--warning` | Laranja de aviso | `context.customColorTheme.warning` |
| `--warning-foreground` | Texto sobre aviso | `context.customColorTheme.warningForeground` |
| `--destructive` | Vermelho de erro | `context.customColorTheme.destructive` |
| `--destructive-foreground` | Texto sobre erro | `context.customColorTheme.destructiveForeground` |
| `--card` | Fundo de cards | `context.customColorTheme.card` |
| `--card-foreground` | Texto em cards | `context.customColorTheme.cardForeground` |
| `--muted` | Fundo neutro | `context.customColorTheme.muted` |
| `--muted-foreground` | Texto secundário | `context.customColorTheme.mutedForeground` |
| `--accent` | Cor de destaque | `context.customColorTheme.accent` |
| `--accent-foreground` | Texto sobre destaque | `context.customColorTheme.accentForeground` |
| `--border` | Bordas | `context.customColorTheme.border` |
| `--input` | Fundo de inputs | `context.customColorTheme.input` |
| `--ring` | Foco/seleção | `context.customColorTheme.ring` |

### 📐 Espaçamentos (Tailwind → Flutter EdgeInsets)

| Tailwind Class | Valor | Flutter Equivalent |
|---------------|-------|-------------------|
| `p-1` | 4px | `EdgeInsets.all(4)` |
| `p-2` | 8px | `EdgeInsets.all(8)` |
| `p-3` | 12px | `EdgeInsets.all(12)` |
| `p-4` | 16px | `EdgeInsets.all(16)` |
| `p-6` | 24px | `EdgeInsets.all(24)` |
| `p-8` | 32px | `EdgeInsets.all(32)` |
| `px-4` | 16px horizontal | `EdgeInsets.symmetric(horizontal: 16)` |
| `py-2` | 8px vertical | `EdgeInsets.symmetric(vertical: 8)` |
| `pt-4` | 16px top | `EdgeInsets.only(top: 16)` |
| `pb-2` | 8px bottom | `EdgeInsets.only(bottom: 8)` |
| `pl-3` | 12px left | `EdgeInsets.only(left: 12)` |
| `pr-6` | 24px right | `EdgeInsets.only(right: 24)` |

### 🌟 Componentes React → Flutter

| React Component | Propriedades | Flutter Equivalent |
|----------------|-------------|-------------------|
| `<Button>` | primary, secondary, outline | `ElevatedButton`, `OutlinedButton`, `TextButton` |
| `<Input>` | type, placeholder, value | `TextFormField` com `InputDecoration` |
| `<Badge>` | variant, color | `Chip` ou `Container` customizado |
| `<Card>` | className, children | `Card` com `CardContent` |
| `<Dialog>` | open, onOpenChange | `showDialog()` com `AlertDialog` |
| `<Form>` | onSubmit, validation | `Form` com `GlobalKey<FormState>` |
| `<Select>` | value, onValueChange | `DropdownButtonFormField` |

### ⚠️ IMPORTANTE: Componentes Importados
**Observação**: As páginas em `/lovable/src/pages/` importam componentes de outros lugares:

```tsx
// Exemplo de imports comuns:
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
```

**🔍 Sempre considere TODOS os componentes utilizados na conversão, não apenas o arquivo principal!**
### 3. 🧩 Componentes e Funcionalidades
- [ ] **Modais React → Flutter**: Converter para `showDialog()` com `Dialog` ou `AlertDialog`
- [ ] **Formulários**: Implementar com `Form` + `TextFormField` + validação usando padrão Command
- [ ] **Estados de Loading**: CupertinoActivityIndicator quando Command.running == true
- [ ] **Estados de Erro**: Feedback visual quando Command.error == true
- [ ] **Navegação**: Implementar com `Navigator` e transições suaves
- [ ] **CRUD Operations**: Create, Update, Delete usando Commands da ViewModel
```


## ✅ CRITÉRIOS DE VALIDAÇÃO

### 🎨 Fidelidade Visual
- [ ] Layout idêntico ao React em todos os breakpoints
- [ ] Tipografia consistente com CustomTextTheme
- [ ] Espaçamentos e proporções mantidos
- [ ] Estados visuais (loading, error, empty, success) implementados

