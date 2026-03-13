set nobackup
set noswapfile
set noundofile
set viminfo=
set autoread
highlight SpecialSpaces ctermbg=7
match SpecialSpaces /\s\+$\|\t\|\%u3000/
hi NonText ctermfg=7
hi SpecialKey ctermfg=7
syntax enable
