# TAKEN FROM NAT TUCK'S SCRATCH REPO
export MIX_ENV=prod
export PORT=4900


SECRET=$(readlink -f ~/.config/events-app-spa)

if [ ! -e "$SECRET/pass" ]; then
	echo "File does not exist"
	exit 1

fi

SECRET_KEY_BASE=$(cat "$SECRET/pass")
export SECRET_KEY_BASE

_build/prod/rel/events/bin/events start