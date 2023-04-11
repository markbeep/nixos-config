## Airplane Mode on/off:

nmcli r all [on|off]

## WiFi

list wifi:
nmcli device

connect to WiFi:
nmcli device connect <ssid> password <password>

## Fonts

Find the exact name of a font:
fc-list

## Test Build Custom Package

`nix-build -E "with import <nixpkgs> {}; callPackage ./default.nix {}"`

## Multiple Monitors

Add monitor to the right with 1.5 scale (zoom out)
`xrandr --output DP1 --scale 1.5x1.5 --right-of eDP1`
Simple GUI tool: `arandr`

# kubectl

- get namespaces: `kubectl get ns`
- get names of pod deployments: `kubectl get pods -n <pod name>`
- get logs of deployment: `kubectl logs -n <pod name> <deployment>`
- remove registered application from wrong "namespace vis-cat-prod": `kubectl delete application.sip -n vis-cat-prod infoscreen-ui`
- list all keycload instances: `kubectl get keycloakclient -n vis-cat-prod`
- get name of keycloak instance: `kubectl describe keycloakclient -n vis-cat-prod infoscreen-ui-oidc`
- force update of an app: `sipctl update -n vis-cat-prod infoscreen-ui`
- see deployed stuff: `sipctl get deploy`
- change url for (old) deployment: `kubectl edit ingress ampel-admin-ingress -n production-120`
- see logs: `kubectl logs -n vis-cat-prod infoscreen-backend-deployment-68dc5d75b8-8b9n4 infoscreen-backend-app`
- see all pods: `kubectl get pods -n production-120`
- delete pod (for eventmanager update): `kubectl delete pod -n production-120 eventmanager-deployment-d6476c4cc-4txds`
- Change Coffee Limit during lernphase: `kubectl edit deployment drinks-deployment -n production-120`
- Interactive terminal on the pod: `kubectl exec -it <pod-name> -- bin/bash`

# sipctl

- list all sipctl apps: `sipctl get apps`
- register an app: `sipctl -n vis-cat-apps register infoscreen-ui -r vseth/1100-fv/1116-vis/cat/sip-vis-cat-apps/infoscreen-ui`
- deploy an app `sipctl deploy -n vis-cat-apps infoscreen-ui vis-cat-prod/infoscreen-ui -u Auto -i`
- `sipctl delete <namespace/app>`
- `sipctl unregister -n <namespace> <name>` -- namespace "should" be vis-cat-apps
- Get all currently registered apps: `siptctl get apps`
- Get all currently deployed apps: `sipctl get deploy`
- to delete running apps (not really needed): `siptctl delete <name>`
- edit a deployment (to give it more pods for example): `sipctl edit community-solutions -n vis-cat-prod`

# vis db

### Postgres

1. ssh vis@db.vis.ethz.ch
2. sudo su postgres
3. psql

### Mariadb

2. sudo su
3. mysql

### recently executed SQL queries from the comsol db

```sql
SELECT pid, age(clock_timestamp(), query_start), usename, query
FROM pg_stat_activity
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' AND usename = 'vis_cat_prod_community_solutions_db'
ORDER BY query_start desc;
```

# vis

reboot pi incase infoscreen or coffee machine doesn't work anymore:

https://wiki.vseth.ethz.ch/pages/viewpage.action?pageId=15925521
