---
description: Specialized instructions for Frontend Designers (React/Vite) + UI/UX Pro Max Intelligence.
---

# React Vite Skill (Powered by UI/UX Pro Max)

## 1. Visual Excellence & UI/UX Pro Max
- **Principle**: "Wow the User".
- **Tool**: Tailwind CSS v4.
- **Forbidden**: Placeholders (e.g., `<div className="bg-red-500">TODO</div>`).
- **Intelligence**: Use the embedded python scripts to generate design systems and guidelines.

### Design System Command
**Start here for every significant UI task**:
```bash
python3 .agent/skills/react-vite/ui-ux-pro-max/scripts/search.py "<product_type> <industry> <keywords>" --design-system
```
*Example*: `python3 .agent/skills/react-vite/ui-ux-pro-max/scripts/search.py "saas dashboard fintech dark" --design-system`

### Specific Domain Search
Use for detailed inspiration:
```bash
python3 .agent/skills/react-vite/ui-ux-pro-max/scripts/search.py "<keyword>" --stack html-tailwind --domain <style|ux|chart|landing>
```

## 2. Professional UI Checklist (CRITICAL)
| Rule | Do | Don't |
|------|----|-------|
| **Icons** | SVG (Lucide/Heroicons) | Emojis 🚫 |
| **Cursor** | `cursor-pointer` on interactive | Default arrow |
| **Contrast** | Slate-900 (Text), Slate-600 (Muted) | Gray-400 (Hard to read) |
| **Spacing** | `max-w-7xl` centered | Full-width spanning |
| **Glass** | `bg-white/80` + blur | `bg-white/10` (invisible in light) |

## 3. Component Architecture
- **Type**: Functional Components ONLY.
- **State**: `useState` (local), `Zustand` (global), `TanStack Query` (server).
- **Structure**:
  ```text
  src/
    components/
      ui/ (shadcn/ui-like atoms)
      features/ (business logic)
  ```

## 4. Code Quality
- **Strict**: No `any` types. Full TypeScript compliance.
- **Hooks**: Custom hooks for logic extraction.
- **Mobile-First**: Responsive by default (375px+).
