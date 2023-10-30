#!/bin/bash

display() {
    echo -e "\033c"
    echo "
    ==========================================================================
    
$(tput setaf 6) ███╗░░░███╗░█████╗░██╗░░██╗███████╗░██████╗░██╗░░██╗  ███████╗░██████╗░░██████╗░
$(tput setaf 6) ████╗░████║██╔══██╗╚██╗██╔╝██╔════╝██╔═══██╗╚██╗██╔╝  ██╔════╝██╔════╝░██╔════╝░
$(tput setaf 6) ██╔████╔██║███████║░╚███╔╝░█████╗░░██║██╗██║░╚███╔╝░  █████╗░░██║░░██╗░██║░░██╗░
$(tput setaf 6) ██║╚██╔╝██║██╔══██║░██╔██╗░██╔══╝░░╚██████╔╝░██╔██╗░  ██╔══╝░░██║░░╚██╗██║░░╚██╗
$(tput setaf 6) ██║░╚═╝░██║██║░░██║██╔╝╚██╗███████╗░╚═██╔═╝░██╔╝╚██╗  ███████╗╚██████╔╝╚██████╔╝
$(tput setaf 6) ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝  ╚══════╝░╚═════╝░░╚═════╝░
 

    ==========================================================================
    "  
}

launchNodeServer() {
    if [ ! "$(command -v node)" ]; then
      echo "Node.js is missing! Please ensure the 'NodeJS' Docker image is selected in the startup options and then restart the server."
      sleep 5
      exit
    fi
    if [ -n "$NODE_DEFAULT_ACTION" ]; then
      action="$NODE_DEFAULT_ACTION"
    else
      echo "
      $(tput setaf 3)What to run?
      1) Run main file      2) Install packages from package.json
        "
      read -r action
    fi
    case $action in
      1)
        if [[ "${NODE_MAIN_FILE}" == "*.js" ]]; then
        node "${NODE_MAIN_FILE}"
        else
        if [ ! "$(command -v ts-node)" ]; then
          echo "ts-nods is missing! Your selected nodejs version doesn't support ts-node."
          sleep 5
          exit
        fi
        ts-node "${NODE_MAIN_FILE}"
        fi
      ;;
      2)
        npm install
      ;;
      *) 
        echo "Error 404"
        exit
      ;;
    esac
}

launchPythonServer() {
    if [ ! "$(command -v python3)" ]; then
      echo "Python is missing! Please ensure the 'Python' Docker image is selected in the startup options and then restart the server."
      sleep 5
      exit
    fi
    if [ -n "$PYTHON_DEFAULT_ACTION" ]; then
      action="$PYTHON_DEFAULT_ACTION"
    else
      if [[ "${PYTHON_MAIN_FILE}" == "*.py" ]]; then
        python3 "${PYTHON_MAIN_FILE}"
      else
        echo "Error 404"
        exit
    fi
}

if [ ! -e "python" ] && [ ! -e "nodejs" ]; then
    display
sleep 5
echo "
  $(tput setaf 3)Which platform are you gonna use?
  1) Python             2) NodeJS
  "
read -r n

case $n in
  1)
  echo "$(tput setaf 3)Starting Download please wait"
  touch python3
  
  display
  
  sleep 10

  echo -e ""
  
  launchPythonServer
  ;;
  2)
  echo "$(tput setaf 3)Starting Download please wait"
  touch nodejs
  
  display
  
  sleep 10

  echo -e ""
  
  launchNodeServer
  ;;
  *) 
    echo "Error 404"
    exit
  ;;
esac  
else
if [ -e "python" ]; then
    display
    launchPythonServer
elif [ -e "nodejs" ]; then
    display
    launchNodeServer
fi
fi
