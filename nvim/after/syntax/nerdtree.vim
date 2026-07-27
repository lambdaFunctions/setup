" Conceal the full path on the NERDTree root/header line, leaving only the
" last folder name visible. conceallevel/concealcursor are already set by
" the plugin itself (syntax/nerdtree.vim), so no extra options are needed.
" The header normally starts with '/' (full path); if it's wider than the
" NERDTree window, the plugin left-truncates it itself and prefixes '<'
" instead (see path.vim's str() truncateTo logic) — match both forms.
syntax match NERDTreeRootFolderConceal '^[/<].*/\ze[^/]\+/$' conceal
