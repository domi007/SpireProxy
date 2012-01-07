if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
echo "refreshing apt (just in case)..."
apt-get update
echo "installing required stuff etc..."
apt-get install nano build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison
echo "Installing RVM..."
if [ "$(id -u)" == "0" ]; then
   echo "You are running this script as root, proceeding with RVM-root-install-workaround..."
   echo 'export rvm_prefix="$HOME"' > /root/.rvmrc
  echo 'export rvm_path="$HOME/.rvm"' >> /root/.rvmrc
fi
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile
echo "Installing ruby 1.9.2... [this takes bloody ages :p]"
rvm install 1.9.2
rvm use 1.9.2 --default
echo "Installing required gems..."
gem install eventmachine CFPropertyList httparty json uuidtools rubydns
echo "done."
