Move `dapp kube deploy` functions into `helm`.

# Helm rollback experiment

* `helm instal`l => success
    * Release created
    * `helm list`
        * DEPLOYED state
        * REVISION=1
* `helm upgrade` => failed in post-upgrade hook
    * `helm list`
        * DEPLOYED state
        * REVISION=1
    * Actual resources state in kubernetes is not corresponding to REVISION=1. Part of resources has the new state, part has old state.
* `helm rollback <relese> 1` => success
    * `helm list` shows 2 releases in DEPLOYED state
        * REVISION=1 -- it looks like BUG.
        * REVISION=5 -- it is factual revision, that corresponds to resources state in kubernetes.
* `helm upgrade` => success
    * `helm list` shows 2 releases in DEPLOYED state
        * REVISION=5 -- old revision, not factual anymore, it looks like BUG.
        * REVISION=6 -- new factual revision
* After post-upgrade hook failure:
    * Release is in DEPLOYED state.
    * `helm list -a` shows new revision in PENDING_UPGRADE state.

## Conclusions

* Rollback rolls back resources to previous working state.
* Autorollback is the function of a tiller, because the upgrade will be more atomical that way.
* Without autorollback `helm upgrade` will break your cluster and leave it in incorrect state.
