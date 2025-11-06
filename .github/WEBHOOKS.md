# Configuration des Webhooks GitHub pour les Releases

## ⚠️ Limitation importante

Les repos `ReVanced/revanced-patches` et `anddea/revanced-patches` **ne vous appartiennent pas**, donc vous **ne pouvez pas** configurer directement des webhooks dessus.

## Solutions alternatives

### ✅ Solution 1 : Workflow de surveillance amélioré (DÉJÀ IMPLÉMENTÉ)

Le workflow `watch-releases.yml` vérifie maintenant **toutes les 15 minutes** si de nouvelles releases sont disponibles. C'est la solution la plus pratique et fiable.

**Avantages :**
- ✅ Fonctionne sans accès aux repos externes
- ✅ Détection automatique toutes les 15 minutes
- ✅ Pas de configuration supplémentaire nécessaire
- ✅ Déclenche automatiquement le build

**Délai de détection :** Maximum 15 minutes après la publication d'une release

### 📋 Solution 2 : Configuration manuelle de webhooks (si vous aviez accès)

Si vous aviez accès aux repos, voici comment configurer un webhook :

#### Étapes pour configurer un webhook GitHub :

1. **Aller dans les paramètres du repo** (Settings)
   - Pour `ReVanced/revanced-patches` : https://github.com/ReVanced/revanced-patches/settings/hooks
   - Pour `anddea/revanced-patches` : https://github.com/anddea/revanced-patches/settings/hooks

2. **Cliquer sur "Add webhook"**

3. **Configurer le webhook :**
   - **Payload URL :** `https://api.github.com/repos/VOTRE_USERNAME/VOTRE_REPO/dispatches`
   - **Content type :** `application/json`
   - **Secret :** (optionnel) Créer un secret dans votre repo
   - **Events :** Sélectionner uniquement "Releases"
   - **Active :** ✅ Cocher

4. **Ajouter l'authentification :**
   - Dans "Add webhook", ajouter un Personal Access Token (PAT) avec les permissions `repo` et `workflow`
   - Le format de l'URL serait : `https://TOKEN@api.github.com/repos/VOTRE_USERNAME/VOTRE_REPO/dispatches`

5. **Format du payload :**
   ```json
   {
     "event_type": "revanced-patches-release",
     "client_payload": {
       "tag": "$(release.tag_name)",
       "repo": "ReVanced/revanced-patches"
     }
   }
   ```

**⚠️ Note :** Cette solution nécessite que vous soyez propriétaire ou collaborateur des repos, ce qui n'est pas le cas ici.

### 🔧 Solution 3 : Utiliser un service externe

Vous pourriez utiliser un service comme :
- **IFTTT** ou **Zapier** pour surveiller les releases et déclencher une action
- **GitHub App** avec des permissions pour écouter les releases (plus complexe)

### 📊 Comparaison des solutions

| Solution | Délai de détection | Complexité | Fiabilité |
|----------|-------------------|------------|-----------|
| Workflow actuel (15 min) | ~15 minutes | ⭐ Facile | ⭐⭐⭐⭐⭐ |
| Webhooks (si possible) | Immédiat | ⭐⭐⭐ Moyenne | ⭐⭐⭐⭐ |
| Service externe | Variable | ⭐⭐⭐⭐ Difficile | ⭐⭐⭐ |

## 🎯 Recommandation

**Utilisez la Solution 1** (workflow de surveillance) qui est déjà implémentée. Elle vérifie toutes les 15 minutes et déclenche automatiquement le build. C'est la solution la plus simple et la plus fiable pour votre cas.

Si vous avez besoin d'une détection plus rapide, vous pouvez réduire l'intervalle à 5 minutes en modifiant le cron dans `watch-releases.yml` :

```yaml
schedule:
  - cron: "*/5 * * * *"  # Toutes les 5 minutes
```

**Note :** GitHub limite les workflows à un maximum d'exécutions par mois selon votre plan. Vérifiez votre quota avant de réduire trop l'intervalle.

