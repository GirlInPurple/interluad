import os, typing, sys
RED = '\u001b[31m'
GREEN = '\u001b[32m'
BOLD = '\033[1m'
RESET = "\u001b[0m"

def clear() -> None:
    """Clear the console on most OSes.
    """
    if sys.platform=='win32':
        os.system('cls')
    if sys.platform=='darwin':
        os.system('clear')

def localFiles() -> str:
    """Returns the local directory in a usable format.

    Returns:
        str: The directory this file is located
    """
    return os.path.dirname(os.path.realpath(__file__))

def listFiles(fileType: str, dir: str = "") -> list:
    """Lists all the files or folders in a specified directory.

    Args:
        fileType (str): either "folder" or "file".
        dir (str, optional): The directory to search. Defaults to whatever `localFiles()` outputs.

    Returns:
        list: A list containing all the file/folders in a specified directory
    """
    if dir == "":
        dir = localFiles()
    output = []
    
    for name in os.listdir(dir):
        if os.path.isdir(os.path.join(dir, name)) and fileType == "folder":
            output.append(name)
        elif os.path.isfile(os.path.join(dir, name)) and fileType == "file":
            output.append(name)
    return output

def charAfterString(string: str, target: str, distance: int, retMode: bool = False) -> typing.Union[str, list]:
    """Returns the character after the specified string inside the input string.

    Args:
        string (str): The input string
        target (str): The target, must be inside the string at some point
        distance (int): How many characters away from the target string the return string should be. Can't be negative
        retMode (bool): returns the string after the operation

    Returns:
        str: The character after the specified string inside the input string.
        list: If `retMode` is True, returns the string back as well.
    """
    if retMode != True: return string.split(target)[distance]
    return string.split(target)[distance], string.split(target)

def checkFiles(dir: str = "") -> None:
    """The main function, checks all the `.lua` files in the local dirs. An alternative dir can be specified.

    Args:
        dir (str, optional): An alternate directory to act on. Defaults to whatever `localFiles()` outputs.
    """
    # Setup
    if dir == "": dir = localFiles()
    folders = listFiles(fileType="folder")
    
    # Loop
    for iterFolder in folders:
        filesInFolder = listFiles(fileType="file", dir=f"{localFiles()}\\{iterFolder}")
        
        if iterFolder != ".git": 
        
            for iterFile in filesInFolder:
                
                readFile = f"{localFiles()}\\{iterFolder}\\{iterFile}"
                with open(readFile, 'r') as f:
                    cont = f.read()
                    print(f"{GREEN}Contents of {iterFile}:{RESET}\n\n{cont}\n")
                    
                    if len(cont) >= 800:
                        print(f"{RED}{iterFile} is over the 800 character limit! it is at {len(cont)}. Please refactor!{RESET}\n\n")
                    else:
                        print(f"{GREEN}{iterFile} is under the 800 character limit. it is at {len(cont)}. You can commit.{RESET}\n\n")
                    
                    """
                    portsString = cont
                    clearPorts = False
                    while clearPorts == False:
                        portsString = charAfterString(string=portsString, target="port[", distance=0, retMode=True)
                        print(portsString[0], portsString[1])
                        if portsString[0] == portsString[1]:
                            clearPorts = True
                    """
    
if __name__ == "__main__":
    clear()
    checkFiles() # add "dir=[add path here]" to specify another path