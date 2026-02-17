# VSCode

<img src="images/VSCode.jpeg" alt="VSCode" width="50%"/>

All that is required for coding is a text editor and some form of a compiler/kernel to run the code. Back in the day, most folks used VIM/EMACS (VIM being superior) to edit their code and compiled/ran that code in terminal. This creates a lot of moving parts, and why most people use Integrated Development Environments (IDEs). VSCode is one of the most up to date IDEs available on Biowulf, and includes a great amount of optionality including:

- Library of extensions for visualization, compiling, interactivity, etc.
- Create and open a vast number of file types, with on-the-fly syntax linting
- Folder navigator, terminal, GitHub tracking built in
- Access to a HPC resources (on Biowulf)

## Navigating VSCode

When you load VSCode, either from Biowulf or on your device, you are welcomed by:

![VSCode_intro](images/VSCode_intro.png)

Go through the list of getting started actions, in part to familiarize yourself with VSCode. I usually use the dark theme reducing eye strain. 

![VSCode layout](images/VSCode_layout.png)

I recommend exploring VSCode by hovering over the many icons and reading the documentation on the [VSCode website](https://code.visualstudio.com/docs). But for now the main icons to use are:

1. Folders
2. Source (version) control
3. Extensions
4. Terminal

Click on the Folders icon to open a folder you have access to. From there you can create new folders by using `ctrl-option-cmd-n`/`ctrl-alt-windows-n`, where a dropdown menu will give options for the new file. You can also open the terminal and use bash to `mkdir -p new_file`.

## VSCode extensions 

With VSCode you can add extensions that increase the usability and functionality than that of a normal IDE. By clicking on the group of 4 squares on the left hand side of the IDE pulls up possible extensions to install.

![VSCode extensions](images/VSCode_extensions.png)

By typing into the search bar on top you can find different packages to install. The extensions needed for this workshop include:

- Python
- Python Debugger
- R (optional)
- Jupyter
- Github actions
- Snakemake language
- Apptainer/Singularity

This will let you use [Python](python_intro.md), [Anaconda](anaconda.md), Jupyter, [Github](github.md), [Snakemake], and [Singularity](singularity_page.md) for the rest of this class.
