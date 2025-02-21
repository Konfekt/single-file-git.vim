Git was not designed for single-file projects, or managing multiple text files independently within a directory.
However, this Vim plug-in works around it by adding command `:G1` that uses a unique repository for each file.

- Initialize a file's repository with `G1 init`
- Remove a repo with `G1 deinit`, which does not delete the file itself
- Use `G1 <git-command>` for operations like status, commit, ...

# Sample Usage

Open a file `foo.txt` in vim.
Use its `init` subcommand to create a bare repository for the target file :

```
  G1 init
```

You should see git output indicating successful repo creation.
Perform this step only once, at the outset.

The repository is named using the prefix `.g1_` followed by the filename;
for instance, `.g1_foo.txt` for **foo.txt**.

To execute git commands for a specific file, use the script with the filename as the first argument, followed by standard git commands and options:

```sh
  G1 status
  G1 commit -m "added new blah"
  G1 diff
  G1 log
```

Since each bare repository is unique to its file, you can create multiple repositories in the same directory.
Always use the file name as the first argument to specify the repository for git commands.
Ensure you use this script within the directory containing both the file and its repository.

To remove a repository (which does *not* remove the tracked file):

```
 G1 deinit
```

# Aliases

Optionally define some [aliases](https://github.com/Konfekt/vim-alias) in, say, `~/.vim/after/git1.vim`

```vim
  if exists(':G1') == 2 && exists(':Alias') == 2
    Alias g1l G1\ log
    Alias g1s G1\ status
    Alias g1a G1\ add\ --update
    Alias g1c G1\ commit
    Alias g1i G1\ init
    Alias g1d G1\ deinit
  endif
endif
```

Then open a file `foo.txt` in vim.
On the command-line (after hitting `:`),

1. type `g1i` to init version control for the current file, and
1. type 

    - `g1s` to see its current status,
    - `g1a` to stage all its changes,
    - `g1c` to commit them and
    - `g1l` to view its log.

# Credits

This repo builds on [single-file-git](https://github.com/Konfekt/single-file-git) which forked [David J. Iannucci's single-file-git](https://github.com/kotodharma/single-file-git) to whom all credit shall be due and all license restrictions be duly respected.
