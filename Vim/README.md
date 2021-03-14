# Vim Configuration

## Plugins

### Guide Key

[`liuchengxu/vim-which-key`][l/vim-which-key] is Vim8 and NeoVIM compatible, and is perfect if you don't want to see it most of the time and only have it pop up after you stop typing for too long (as though you are thinking). Because it is apparently [not possible][l/vim-which-key/I175] to make the guide window pop up immediately with `notimeout` set, if you want it to instantly show up when you hit the leader key you must set `timeout` and `timeoutlen=0` or some other small number of milliseconds, but this prevents you from using any other key combination as they will also time out instantly. Solutions to make this compatible with [`easymotion`][e/vim-easymotion] can be found in [Issue `#10`][l/vim-which-key/I10].

I believe [`spinks/vim-leader-guide`][s/vim-leader-guide] solves this but as of writing is only compatible with NeoVIM and not Vim8. [`dpretet/vim-leader-mapper`][d/vim-leader-mapper] is another light solution for NeoVIM.

Viewing non-leader (i.e. global) mappings might be possible with spinks' solution but I have not looked into it as I use Vim8.


  [d/vim-leader-mapper]:    https://github.com/dpretet/vim-leader-mapper
  [e/vim-easymotion]:       https://github.com/easymotion/vim-easymotion
  [l/vim-which-key]:        https://github.com/liuchengxu/vim-which-key
  [l/vim-which-key/I10]:    https://github.com/liuchengxu/vim-which-key
  [s/vim-leader-guide]:     https://github.com/spinks/vim-leader-guide
