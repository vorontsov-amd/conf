" Общие настройки
set number                " Показывать номера строк
set relativenumber        " Относительные номера строк
set cursorline            " Подсвечивать текущую строку
set showmatch             " Подсвечивать парные скобки
set hlsearch              " Подсвечивать найденное
set incsearch             " Инкрементальный поиск
set autoindent            " Автоматическое выравнивание отступов
set smartindent           " Интеллектуальные отступы
set wrap                  " Включить перенос строк
set linebreak             " Переносить строки по словам
set scrolloff=5           " Оставлять 5 строк при прокрутке

" Табуляция и отступы
set tabstop=4             " Отображение табов как 4 пробела
set shiftwidth=4          " Отступы сдвига на 4 пробела
set expandtab             " Преобразовать Tab в пробелы
set softtabstop=4         " Размер шага при нажатии Tab/Backspace

" Кодировка и формат
set encoding=utf-8        " Установить кодировку UTF-8
set fileformats=unix,dos  " Использовать UNIX и DOS формат строк

" Интерфейс
syntax on                 " Включить подсветку синтаксиса
set background=dark       " Темная тема
colorscheme desert        " Тема (можно заменить на gruvbox, если установлен)

" Плагины (используйте vim-plug)
call plug#begin('~/.vim/plugged')

" Подсветка и поддержка C++
Plug 'sheerun/vim-polyglot'

" Автодополнение
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Файловый менеджер
Plug 'preservim/nerdtree'

" Автодополнение скобок
Plug 'jiangmiao/auto-pairs'

" Подсветка и навигация по коду
Plug 'Yggdroot/indentLine'

" Поддержка Git
Plug 'tpope/vim-fugitive'

" Линтер и форматтер
Plug 'dense-analysis/ale'

" Поиск
Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'

" Автопереход
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Работа с комментариями
Plug 'tpope/vim-commentary'

call plug#end()

" Настройки плагинов
" Coc.nvim (автодополнение)
let g:coc_global_extensions = ['coc-clangd'] " Подключение Clangd для C++

" NERDTree
" Горячая клавиша для открытия/закрытия NERDTree
map <C-n> :NERDTreeToggle<CR> 

" ALE (линтер и исправления)
let g:ale_linters = {
\   'cpp': ['clang', 'gcc', 'clangtidy'],
\}
let g:ale_fixers = {
\   'cpp': ['clang-format'],
\}
let g:ale_cpp_clangformat_executable = 'clang-format'
let g:ale_fix_on_save = 1 " Автоисправление при сохранении

" IndentLine
let g:indentLine_char = '|' " Символ для линий отступа

" Горячие клавиши
" Компиляция и запуск текущего файла
nnoremap <F5> :w<CR>:!g++ % -o %:r && ./%:r<CR>
" Исправление форматирования
nnoremap <F8> :w<CR>:ALEFix<CR>                 

" Настройки для перемещения по списку автодополнения
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" Поиск файлов
nnoremap <C-p> :Files<CR>
" Поиск текста через Ripgrep
nnoremap <C-f> :Rg<CR>            

" Улучшение работы с файлами
set wildmenu              " Удобное автодополнение команд
set wildmode=list:longest " Удобное меню выбора файлов

" Поддержка файлов с расширением .h и .cpp
autocmd BufRead,BufNewFile *.cpp,*.h setlocal filetype=cpp

