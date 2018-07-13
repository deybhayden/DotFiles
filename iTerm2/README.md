# iTerm2 and Tmux

## tmux-256 color terminfo

My tmux `$TERM` is exported as `tmux-256`, and has true color and italics support, but it is not installed in systems by default. To install it, run the below command:

```shell
$> cd ~/Repos/DotFiles
$> tic -x iTerm2/tmux-256.terminfo
```
