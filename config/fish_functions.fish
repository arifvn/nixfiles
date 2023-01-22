function fzf_select_history
  if test (count $argv) = 0
    history | fzf --prompt="History>" | read foo
  else
    history | fzf --prompt="History>" --query "$argv " | read foo
  end

  if [ $foo ]
    commandline $foo
    echo $foo | xclip -selection clipboard
  else
    commandline ""
  end
end

function fzf_open_file
  begin
    # add default directory to search for
    # fd --hidden --type file --exclude .git --absolute-path . $HOME/Downloads
    # list files under current directory except .git
    fd --hidden --type file --exclude .git --absolute-path
  end | fzf --prompt="OpenFile>" --query "$argv " | read fileName
  
  if [ $fileName ]
    $EDITOR $fileName
  else
    commandline ""
  end
end

function _fzf_change_directory
  if [ (count $argv) ]
    fzf --prompt="ChangeDir>" --query "$argv " | read foo
  else
    fzf --prompt="ChangeDir>" | read foo
  end
  
  if [ $foo ]
    builtin cd $foo
    commandline -r ""
    commandline -f repaint
  else
    commandline ""
  end
end

function fzf_change_directory
  begin
    # add custom directories to be listed
    # if test -d $HOME/.dotfiles 
    #   echo $HOME/.dotfiles
    # end
    
    # list current directory except .git
    fd --hidden --type directory --exclude .git --absolute-path
  end | _fzf_change_directory $argv
end

function _fzf_change_directory_up
  if [ (count $argv) ]
    fzf --prompt="ChangeDirUp>" --query "$argv " | read foo
  else
    fzf --prompt="ChangeDirUp>" | read foo
  end
  
  if [ $foo ]
    builtin cd $foo
    commandline -r ""
    commandline -f repaint
  else
    commandline ""
  end
end

function fzf_change_directory_up
  begin
    # add custom directories to be listed
    # echo $HOME/.dotfiles
    
    set parent "$(dirname $(pwd))" 
    set grandparent "$(dirname $parent)"
    set grandparent1 "$(dirname $grandparent)"
    set grandparent2 "$(dirname $grandparent1)"

    echo $parent
    echo $parent | xargs fd --hidden --type directory --max-depth 2 --exclude .git --full-path /
    echo $grandparent2
    echo $grandparent1
    echo $grandparent
  end | _fzf_change_directory_up $argv
end

function _fzf_jump_to_repository
  if [ (count $argv) ]
    fzf --prompt="JumpToRepo>" --query "$argv " | read foo
  else
    fzf --prompt="JumpToRepo>" | read foo
  end
  
  if [ $foo ]
    builtin cd $foo
    commandline -r ""
    commandline -f repaint
  else
    commandline ""
  end
end

function fzf_jump_to_repository
  begin
    # list local repositories with full path
    ghq list -p
    
  end | _fzf_jump_to_repository $argv
end
