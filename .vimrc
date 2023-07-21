set nobackup
set noswapfile
set noundofile
set viminfo=
set autoread
highlight SpecialSpaces ctermbg=gray
match SpecialSpaces /\s\+$\|\t\|\%u3000/
hi NonText ctermfg=DarkGray
hi SpecialKey ctermfg=DarkGray
syntax enable
