# 大阪公立大学合氣道部 — 規約

最新の規約は [こちら](https://github.com/omu-aikido/rules/releases/latest/download/omu-aikido_rule.pdf) からダウンロードできます。
また、[omu-aikido.github.io/rules](https://omu-aikido.github.io/rules/) でも閲覧可能です。

A) GitHub のウェブ UI で直接編集（簡単）

1. リポジトリページに行き、[rules.typ](https://github.com/omu-aikido/rules/blob/main/rules.typ) を開く。
2. 鉛筆アイコン（Edit this file）を押して編集。
3. 変更後にページ下の「Commit changes」を押す。

B) ローカルで編集して git を使う（推奨）

1. リポジトリをクローン: `git clone <リポジトリURL>`
2. ブランチ作成: `git checkout -b edit-rule`
3. 編集: `rules.typ` を修正 → `git add rules.typ` → `git commit -m "規約更新: ○○を修正"`
4. プッシュ: `git push origin edit-rule` → GitHub で PR を作成・レビュー → `main` にマージ

最終的に `main` ブランチに変更が入ると、自動的にワークフローが走って Release に反映されます。

## ローカルで PDF を生成する方法

- Typst がインストール済みの場合:
  - `typst compile rules.typ "大阪公立大学合氣道部 規約.pdf"`

- Nix を使う場合（ワークフローと同等の環境で確認したいとき）:
  - `nix develop --command typst compile rules.typ "大阪公立大学合氣道部 規約.pdf"`
