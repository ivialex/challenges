#!/bin/sh

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1

CMD="$1"
PREFIX="$HOME/local/bin"

install () {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Attempting to install minikube and assorted tools to $PREFIX"

        if ! command kubectl >/dev/null 2>&1; then
            version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
            echo "Installing kubectl version $version"
            curl -LO "https://storage.googleapis.com/kubernetes-release/release/$version/bin/linux/amd64/kubectl"
            chmod +x kubectl
            mv kubectl "$PREFIX"
        else
            echo "kubetcl is already installed"
        fi

        if ! command minikube >/dev/null 2>&1; then
            curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
            chmod +x minikube
            mv minikube "$PREFIX"
        else
            echo "minikube is already installed"
        fi
    elif [[ "$OSTYPE" == "msys"* ]]; then
        echo "Attempting to install minikube and assorted tools to Windows Operating System"

        if ! command kubectl >/dev/null 2>&1; then
            echo "choco install kubernetes-cli"
        else
            echo "kubetcl is already installed"
        fi

        if ! command minikube >/dev/null 2>&1; then
           choco install minikube
        else
            echo "minikube is already installed"
        fi
    else
        echo "Operating System unknow"
    fi
	
}

remove () {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Removing minikube and assorted tools from $PREFIX"

        rm -f "$PREFIX/kubectl"
        rm -f "$PREFIX/minikube"
    elif [[ "$OSTYPE" == "msys"* ]]; then
        echo "Removing minikube and assorted tools from Windows Operating System"

        echo "choco uninstall kubernetes-cli"
        choco uninstall minikube
    else
        echo "Operating System unknow"
    fi
}

start () {
    echo "Starting minukube..."
    minikube start
}

stop () {
    echo "Stopping minukube..."
    minikube stop
}

pause () {
    echo "Pausing minukube..."
    minikube pause
}

status () {
    echo "Minukube Status..."
    minikube status
}

addons () {
    echo "Minukube Addons enable ingress..."
    minikube addons enable ingress
}

service () {
    echo "Exposing service simpleapp-python-service..."
    minikube service simpleapp-python-service --url -n prova
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! grep -E 'vmx|svm' /proc/cpuinfo > /dev/null; then
        echo "CPU does not support virtualization"
        exit 1
    fi
fi

case $CMD in
	install)
		install
		;;
	start)
		start
		;;
    stop)
		stop
		;;
    pause)
		pause
		;;
    status)
		status
		;;
    addons)
		addons
		;;
    service)
		service
		;;
    remove)
		remove
		;;
	*)
		echo "install_minikube.sh [install|start|stop|pause|status|addons|service|remove] <install_prefix>"
		;;
esac
