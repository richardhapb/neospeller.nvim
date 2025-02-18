# Neospeller.nvim

## About the project

Neospeller is a Neovim plugin that provides spell checking functionality using an external spell checker tool called [neospeller](https://github.com/richardhapb/neospeller). It allows users to check the spelling of the text in the current buffer or a selected range within the buffer.

## Getting Started

These instructions will help you set up and use Neospeller in your Neovim environment.

### Prerequisites

- Neovim 0.5.0 or later
- [neospeller](https://github.com/richardhapb/neospeller) installed on your system

### Installation

1. Install the `neospeller` executable. You can download the latest release from the [neospeller GitHub repository](https://github.com/richardhapb/neospeller)

2. Install the Neospeller plugin using your preferred plugin manager:

    Lazyvim:


    ```lua
    {
      "richardhapb/neospeller.nvim",
      opts = {}
    }
    ```

   Packer:

    ```lua
    use {
      "richardhapb/neospeller.nvim",
      opt = true
    }
    ```

   Plugged:

    ```vim
    Plug 'richardhapb/neospeller.nvim'
    ```

### Usage

1. Load the Neospeller plugin in your Neovim configuration if you haven't already done so. For example:

    ```lua
    require('neospeller').setup()
    ```

2. Use the `:CheckSpell` command to check the spelling of the text in the current buffer or a selected range. For example:

    - To check the entire buffer:

        ```vim
        :CheckSpell
        ```

    - To check a specific range, visually select the text and then run:

        ```vim
        :'<,'>CheckSpell
        ```

Neospeller will rewrite the buffer with the corrected text in the comments.

Availables languages:
- Rust
- Python
- Javascript
- CSS

