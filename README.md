# waifu2x-better-path
Improves nihui/waifu2x-ncnn-vulkan cmd arguments to be more convenient on windows.

## Installation
Download and extract the latest release of [waifu2x ncnn vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan/releases) into your desired directory. 

Once in your desired directory, you will need to PATH the folder that contains waifu2x-ncnn-vulkan.exe. 

To learn how to PATH a directory, follow the instructions [on this page](https://helpdeskgeek.com/windows-10/add-windows-path-environment-variable/).

In short, you will want the "Path" variable to contain the directory of [waifu2x ncnn vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan/releases) extracted on your system.

You should not alter the filenames contained inside that folder as "waifu2x-ncnn-vulkan.exe" is an expected value. 

Once you have configured your path, download and save the following file as [waifu.bat](https://raw.githubusercontent.com/seth-rah/waifu2x-better-path/master/waifu.bat). Store the "waifu.bat" file in the same directory as "waifu2x-ncnn-vulkan.exe"

Lastly, right click the `waifu.bat` file and select properties. At the bottom of the window, if there is a checkbox to unblock the file, select it and click OK to ensure that the file has execution rights.

## How to use

Once everything in the installation is taken care of, you can easily access waifu2x from CMD or Powershell using the `waifu` command. (please note that using git bash will require you to type `waifu.bat` to access the script)

### What QOL changes are included in this script?

1. The `waifu` command is aware of the current directory, or the full directory path provided.
2. `waifu` can be called with or without a filename before script execution. 
   * `waifu filename` or `waifu drive:\filepath\filename` is supported. cmd and powershell also support click dragging a file into their window to populate the full file path. short path only supported if CMD / Powershell are open in that files directory.
   * `waifu` without any arguments is supported and will request a filename afterwards
3. Automatically assumes the file name provided ends in png or jpg. If both or neither exist, script will request you to provide the file extension.
   * If the file extension is provided with or without a fullstop, the script will handle it appropriately and add it if it was missing.
   * If the filename exists but the extension was provided incorrectly, it will ask you to provide the extension again.
4. Providing any secondary arguments after the filename on script launch will give you the ability to freely select the arguments you wish to use. to enable free arguments, use the command as follows `waifu filename anythingGoesHere`.
5. You only need to provide an input filename, the output will store in the same directory as the input file, with a `-waifu` suffixed to the filename. 
   * If the filename already exists, the script will ask if you wish to overwrite the file that's already there, or to cancel the operation.
   * A future version might request you which filename you'd prefer instead of overwriting, or suffix a value to not conflict with the existing file.

In short, you just need to `shift - rightclick` on an empty space in a folder containing the file you wish to rescale, select `Open PowerShell window here`. Type `waifu filename` and you're set. If you don't know the filename, `click drag` the image into the `PowerShell` window instead of typing the filename, or with CMD if that's your cup of tea.
