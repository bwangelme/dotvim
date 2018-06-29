set tabstop=4 shiftwidth=4 expandtab ai

" python code format
" format all file
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
" format select block
autocmd FileType python vnoremap <leader>y :!yapf<Cr>
