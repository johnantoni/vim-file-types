if exists("g:file_types")
  finish
endif

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |   exe "normal g`\"" | endif

  " Format xml files
  autocmd FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

  " Autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript set ai sw=2 sts=2 et
  autocmd FileType sass,cucumber,haml,coffee,slim,markdown set ai sw=2 sts=2 et
  autocmd FileType python set sw=2 sts=2 et

  " Dont remember file position for git commits
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

  " Add filetypes
  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd! BufRead,BufNewFile *.lock setfiletype ruby
  autocmd! BufRead,BufNewFile *.pill setfiletype ruby
  autocmd! BufRead,BufNewFile *.slim setfiletype slim
  
  " Handle markdown
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Add nginx filetype for config files
  autocmd! BufRead,BufNewFile *.conf setfiletype nginx

  " Remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  " Spell check when writing commit logs
  autocmd filetype svn,*commit* setlocal spell

  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC

  " Watch for file changes
  autocmd FileChangedShell * echo "File changed :e to reload"
augroup END
