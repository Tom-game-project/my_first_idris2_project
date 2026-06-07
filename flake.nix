{
  description = "Idris 2 development environment";

  inputs = {
    # 常に最新のIdris 2とLSPを取得するため、unstableを使用します
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # お使いのアーキテクチャに合わせて変更してください（大抵は x86_64-linux）
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          # Idris 2コンパイラ本体
          pkgs.idris2
          
          # Idris 2 Language Server
          pkgs.idris2Packages.idris2Lsp
          
          # 実行・コンパイル用のバックエンド
          pkgs.chez
          
          # REPL (idris2) でのカーソル移動や履歴機能を有向にするためのツール
          pkgs.rlwrap
        ];

        shellHook = ''
          echo "Idris 2 Environment Loaded!"
          echo "Compiler: $(idris2 --version)"
          idris2-lsp --version
        '';
      };
    };
}
