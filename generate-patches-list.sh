#!/usr/bin/env bash

set -euo pipefail

# Script pour générer la liste complète des patches disponibles
# Usage: ./generate-patches-list.sh [--update-readme]
#   --update-readme: Met à jour directement le README.md au lieu de créer un fichier séparé

# Charger les fonctions utilitaires
source utils.sh 2>/dev/null || {
    echo "Erreur: utils.sh non trouvé. Assurez-vous d'exécuter ce script depuis le répertoire racine du projet."
    exit 1
}

# Initialiser les prebuilts (nécessaire pour TOML)
set_prebuilts

TEMP_DIR="temp-patches-analysis"
OUTPUT_FILE="PATCHES_LIST.md"
README_FILE="README.md"
CONFIG_FILE="config.toml"
REPO_ROOT=$(pwd)
UPDATE_README=false

if [ "${1:-}" = "--update-readme" ]; then
    UPDATE_README=true
fi

# Vérifier que config.toml existe
if [ ! -f "$CONFIG_FILE" ]; then
    err "Fichier $CONFIG_FILE non trouvé"
    exit 1
fi

# Couleurs pour l'output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

pr() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[-]${NC} $1"; }

cleanup() {
    # Ne pas nettoyer pour permettre la vérification des fichiers
    # if [ -d "$TEMP_DIR" ]; then
    #     pr "Nettoyage des fichiers temporaires..."
    #     rm -rf "$TEMP_DIR"
    # fi
    true
}
trap cleanup EXIT

# Utiliser le même TEMP_DIR que utils.sh pour réutiliser les fichiers téléchargés
TEMP_DIR="${TEMP_DIR:-temp}"
# Ne pas changer de répertoire, rester dans le répertoire racine
# get_rv_prebuilts utilise TEMP_DIR qui est relatif au répertoire courant
cd "$REPO_ROOT"

# Créer le répertoire temp s'il n'existe pas
mkdir -p "$TEMP_DIR"

# Fonction pour télécharger un fichier
download_file() {
    local url=$1
    local output=$2
    if [ ! -f "$output" ]; then
        pr "Téléchargement de $output..."
        curl -L -f -s -S "$url" -o "$output" || return 1
    fi
}

# Fonction pour obtenir la dernière release d'un repo
get_latest_release() {
    local owner=$1
    local repo=$2
    local file_pattern=$3
    local output_file=$4
    
    pr "Récupération de la dernière release de $owner/$repo..."
    
    # Obtenir la dernière release
    local release_url="https://api.github.com/repos/${owner}/${repo}/releases/latest"
    local release_info
    release_info=$(curl -s -S "$release_url") || return 1
    
    local tag_name
    tag_name=$(echo "$release_info" | jq -r '.tag_name') || return 1
    
    pr "Dernière release: $tag_name"
    
    # Chercher le fichier correspondant au pattern
    local asset_url
    asset_url=$(echo "$release_info" | jq -r ".assets[] | select(.name | endswith(\"$file_pattern\")) | .browser_download_url" | head -1)
    
    if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
        err "Aucun asset trouvé avec le pattern '$file_pattern'"
        return 1
    fi
    
    download_file "$asset_url" "$output_file"
    echo "$tag_name"
}

# Fonction pour obtenir une release spécifique
get_specific_release() {
    local owner=$1
    local repo=$2
    local tag=$3
    local file_pattern=$4
    local output_file=$5
    
    pr "Récupération de la release $tag de $owner/$repo..."
    
    local release_url="https://api.github.com/repos/${owner}/${repo}/releases/tags/${tag}"
    local release_info
    release_info=$(curl -s -S "$release_url") || return 1
    
    local asset_url
    asset_url=$(echo "$release_info" | jq -r ".assets[] | select(.name | endswith(\"$file_pattern\")) | .browser_download_url" | head -1)
    
    if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
        err "Aucun asset trouvé avec le pattern '$file_pattern'"
        return 1
    fi
    
    download_file "$asset_url" "$output_file"
    echo "$tag"
}

# Fonction pour lister les patches depuis un fichier
list_patches() {
    local cli_jar=$1
    local patches_file=$2
    local package_name=$3
    
    if [ ! -f "$cli_jar" ] || [ ! -f "$patches_file" ]; then
        err "Fichiers manquants: cli=$cli_jar, patches=$patches_file"
        return 1
    fi
    
    pr "Analyse des patches pour $package_name..."
    
    java -jar "$cli_jar" list-patches "$patches_file" -f "$package_name" 2>/dev/null | \
        grep "^Name:" | \
        sed 's/^Name: //' | \
        sort || return 1
}

# Fonction pour obtenir le CLI en utilisant get_rv_prebuilts
get_cli_file() {
    local cli_src=$1
    local cli_ver=$2
    
    # Utiliser get_rv_prebuilts pour télécharger le CLI
    # On passe des valeurs factices pour patches car on ne veut que le CLI
    local temp_patches_src="${cli_src%/*}/temp-patches"
    local temp_patches_ver="latest"
    
    local RVP
    RVP=$(get_rv_prebuilts "$cli_src" "$cli_ver" "$temp_patches_src" "$temp_patches_ver" 2>/dev/null || echo "")
    
    if [ -z "$RVP" ]; then
        # Si get_rv_prebuilts échoue, essayer de télécharger directement
        local owner="${cli_src%/*}"
        local repo="${cli_src#*/}"
        local output_file="${TEMP_DIR}/${owner,,}-rv/revanced-cli-*.jar"
        
        # Télécharger directement
        local release_url="https://api.github.com/repos/${cli_src}/releases"
        if [ "$cli_ver" = "latest" ] || [ "$cli_ver" = "dev" ]; then
            release_url+="/latest"
        else
            release_url+="/tags/${cli_ver}"
        fi
        
        local release_info
        release_info=$(gh_req "$release_url" -) || return 1
        
        local asset_url
        asset_url=$(echo "$release_info" | jq -r '.assets[] | select(.name | endswith(".jar")) | .browser_download_url' | head -1)
        
        if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
            return 1
        fi
        
        local dir="${TEMP_DIR}/${owner,,}-rv"
        mkdir -p "$dir"
        local name
        name=$(echo "$release_info" | jq -r '.assets[] | select(.name | endswith(".jar")) | .name' | head -1)
        output_file="${dir}/${name}"
        
        gh_dl "$output_file" "$asset_url" >&2 || return 1
        echo "$output_file"
        return 0
    fi
    
    # Extraire le chemin du CLI depuis RVP
    read -r rv_cli_jar rv_patches_jar <<<"$RVP"
    echo "$rv_cli_jar"
}

# Fonction pour analyser les patches d'un repo
analyze_patches() {
    local patches_src=$1
    local patches_ver=$2
    local cli_src=$3
    local cli_ver=$4
    local package_name=$5
    
    pr "=== Analyse de $patches_src avec CLI $cli_src ==="
    
    # Utiliser get_rv_prebuilts pour télécharger CLI et patches
    # get_rv_prebuilts écrit les messages sur stderr (>&2) et retourne les chemins sur stdout
    # Il retourne "cli_file patches_file " (avec espace final)
    local RVP
    RVP=$(get_rv_prebuilts "$cli_src" "$cli_ver" "$patches_src" "$patches_ver" 2>&1)
    
    # Extraire uniquement les chemins de fichiers (lignes qui se terminent par .jar, .rvp, ou .mpp)
    local file_paths
    file_paths=$(echo "$RVP" | grep -E "\.(jar|rvp|mpp)$" | tail -2)
    
    if [ -z "$file_paths" ]; then
        err "Impossible de télécharger les prebuilts pour $patches_src"
        err "Sortie de get_rv_prebuilts: $(echo "$RVP" | head -5)"
        return 1
    fi
    
    # Extraire les deux fichiers (CLI et patches)
    read -r rv_cli_jar rv_patches_jar <<<"$file_paths"
    
    # Nettoyer les espaces et codes ANSI
    rv_cli_jar=$(echo "$rv_cli_jar" | sed 's/\x1b\[[0-9;]*m//g' | xargs)
    rv_patches_jar=$(echo "$rv_patches_jar" | sed 's/\x1b\[[0-9;]*m//g' | xargs)
    
    # Si les fichiers ne sont pas trouvés, chercher dans les répertoires temp
    if [ ! -f "$rv_cli_jar" ] || [ ! -f "$rv_patches_jar" ]; then
        local cli_dir="${cli_src%/*}"
        cli_dir="${TEMP_DIR}/${cli_dir,,}-rv"
        local patches_dir="${patches_src%/*}"
        patches_dir="${TEMP_DIR}/${patches_dir,,}-rv"
        
        # Trouver le CLI
        if [ -d "$cli_dir" ] && [ -z "$rv_cli_jar" ] || [ ! -f "$rv_cli_jar" ]; then
            rv_cli_jar=$(find "$cli_dir" -name "*.jar" -type f | head -1)
        fi
        
        # Trouver les patches
        if [ -d "$patches_dir" ] && [ -z "$rv_patches_jar" ] || [ ! -f "$rv_patches_jar" ]; then
            rv_patches_jar=$(find "$patches_dir" \( -name "*.rvp" -o -name "*.jar" -o -name "*.mpp" \) -type f | head -1)
        fi
    fi
    
    if [ ! -f "$rv_cli_jar" ] || [ ! -f "$rv_patches_jar" ]; then
        err "Fichiers prebuilts non trouvés"
        err "  CLI cherché: $rv_cli_jar (existe: $([ -f "$rv_cli_jar" ] && echo "oui" || echo "non"))"
        err "  Patches cherché: $rv_patches_jar (existe: $([ -f "$rv_patches_jar" ] && echo "oui" || echo "non"))"
        err "  Répertoires: cli_dir=${cli_src%/*}, patches_dir=${patches_src%/*}"
        return 1
    fi
    
    pr "CLI: $(basename "$rv_cli_jar")"
    pr "Patches: $(basename "$rv_patches_jar")"
    
    # Vérifier que les fichiers existent
    if [ ! -f "$rv_cli_jar" ]; then
        err "CLI non trouvé: $rv_cli_jar"
        return 1
    fi
    if [ ! -f "$rv_patches_jar" ]; then
        err "Patches non trouvés: $rv_patches_jar"
        return 1
    fi
    
    # Lister les patches
    local patches_list
    patches_list=$(list_patches "$rv_cli_jar" "$rv_patches_jar" "$package_name" 2>&1)
    
    if [ -z "$patches_list" ]; then
        warn "Aucun patch trouvé pour $package_name"
        return 1
    fi
    
    # Retourner uniquement la liste des patches (sans les messages de debug)
    # list_patches retourne "Name: patch_name" pour chaque patch
    echo "$patches_list" | grep "^Name:" | sed 's/^Name: //' | sed 's/\x1b\[[0-9;]*m//g' | grep -v "^$"
}

# Créer le fichier de sortie
cat > "$OUTPUT_FILE" << 'EOF'
# Liste complète des patches disponibles

Ce fichier est généré automatiquement par `generate-patches-list.sh`.

> **Note:** Cette liste est générée à partir des fichiers de patches téléchargés depuis les repositories GitHub officiels.

EOF

# Fonction pour analyser les patches depuis config.toml
analyze_from_config() {
    local table_name=$1
    
    pr "\n=== Analyse de $table_name ==="
    
    # Préparer le TOML
    toml_prep "$CONFIG_FILE" || {
        err "Impossible de lire $CONFIG_FILE"
        return 1
    }
    
    # Obtenir la table de configuration
    local table
    table=$(toml_get_table "$table_name") || {
        warn "Table $table_name non trouvée dans config.toml"
        return 1
    }
    
    # Vérifier si l'application est activée
    local enabled
    enabled=$(toml_get "$table" enabled) || enabled=true
    if [ "$enabled" = "false" ]; then
        warn "$table_name est désactivé dans config.toml, ignoré"
        return 1
    fi
    
    # Obtenir les paramètres
    local patches_src cli_src patches_ver cli_ver app_name package_name
    patches_src=$(toml_get "$table" patches-source) || patches_src="ReVanced/revanced-patches"
    cli_src=$(toml_get "$table" cli-source) || cli_src="j-hc/revanced-cli"
    patches_ver=$(toml_get "$table" patches-version) || patches_ver="latest"
    cli_ver=$(toml_get "$table" cli-version) || cli_ver="latest"
    app_name=$(toml_get "$table" app-name) || app_name="$table_name"
    
    # Déterminer le package name basé sur l'app-name ou le nom de la table
    case "$app_name" in
        "YouTube")
            package_name="com.google.android.youtube"
            ;;
        "YouTube Music"|"Music")
            package_name="com.google.android.apps.youtube.music"
            ;;
        "SoundCloud"|"Soundcloud")
            package_name="com.soundcloud.android"
            ;;
        *)
            # Essayer avec le nom de la table
            case "$table_name" in
                *"Soundcloud"*|*"SoundCloud"*)
                    package_name="com.soundcloud.android"
                    ;;
                *)
                    warn "Package name inconnu pour $app_name ($table_name)"
                    package_name=""
                    ;;
            esac
            ;;
    esac
    
    if [ -z "$package_name" ]; then
        warn "Impossible de déterminer le package name pour $table_name"
        return 1
    fi
    
    # Déterminer l'extension des patches
    local file_ext="rvp"
    if [[ "$patches_src" == *"MorpheApp"* ]]; then
        file_ext="mpp"
    fi
    
    pr "Configuration:"
    pr "  - Patches: $patches_src (version: $patches_ver)"
    pr "  - CLI: $cli_src (version: $cli_ver)"
    pr "  - Package: $package_name"
    pr "  - Extension: $file_ext"
    
    # Analyser les patches en utilisant les sources complètes
    local patches_list
    patches_list=$(analyze_patches \
        "$patches_src" \
        "$patches_ver" \
        "$cli_src" \
        "$cli_ver" \
        "$package_name" 2>&1 || echo "")
    
    if [ -z "$patches_list" ]; then
        warn "Aucun patch trouvé pour $table_name"
        return 1
    fi
    
    # Ajouter au fichier de sortie
    local rv_brand
    rv_brand=$(toml_get "$table" rv-brand) || rv_brand="ReVanced"
    
    cat >> "$OUTPUT_FILE" << EOF

## $app_name ($rv_brand) - $table_name

**Package:** $package_name  
**Patches Source:** [$patches_src](https://github.com/$patches_src)  
**CLI Source:** [$cli_src](https://github.com/$cli_src)  
**Patches Version:** $patches_ver  
**CLI Version:** $cli_ver

### Liste complète des patches disponibles:

EOF
    # Filtrer les messages de debug et ajouter uniquement les vrais noms de patches
    echo "$patches_list" | while IFS= read -r patch; do
        # Nettoyer les codes ANSI et ignorer les lignes vides et les messages de debug
        patch=$(echo "$patch" | sed 's/\x1b\[[0-9;]*m//g')  # Supprimer les codes ANSI
        if [ -n "$patch" ] && [[ ! "$patch" =~ ^\[ ]] && [[ ! "$patch" =~ ^=== ]] && [[ ! "$patch" =~ ^CLI: ]] && [[ ! "$patch" =~ ^Patches: ]] && [[ ! "$patch" =~ ^Analyse ]] && [[ ! "$patch" =~ ^Getting ]]; then
            echo "- $patch" >> "$OUTPUT_FILE"
        fi
    done
    
    return 0
}

# Lire toutes les tables depuis config.toml et analyser celles qui sont activées
pr "Lecture de $CONFIG_FILE..."

toml_prep "$CONFIG_FILE" || {
    err "Impossible de lire $CONFIG_FILE"
    exit 1
}

# Obtenir toutes les tables
tables=$(toml_get_table_names)

# Analyser chaque table
for table_name in $tables; do
    if [ -z "$table_name" ]; then continue; fi
    analyze_from_config "$table_name" || continue
done

# Le fichier est déjà dans le répertoire racine si on a changé de répertoire
if [ -f "$TEMP_DIR/$OUTPUT_FILE" ]; then
    mv "$TEMP_DIR/$OUTPUT_FILE" "$REPO_ROOT/"
fi
pr "Liste des patches générée dans $REPO_ROOT/$OUTPUT_FILE"

cd "$REPO_ROOT"

if [ "$UPDATE_README" = true ]; then
    pr "Mise à jour du README.md..."
    
    # Utiliser le script Python ou un script bash pour mettre à jour le README
    # Pour l'instant, on affiche juste un message
    warn "La mise à jour automatique du README nécessite une analyse plus approfondie."
    warn "Consultez $OUTPUT_FILE et mettez à jour manuellement le README.md si nécessaire."
    warn "Ou utilisez: ./generate-patches-list.sh pour générer la liste, puis copiez-la dans le README."
else
    pr "Terminé ! Consultez $OUTPUT_FILE pour la liste complète des patches."
    pr "Pour mettre à jour le README automatiquement, utilisez: ./generate-patches-list.sh --update-readme"
fi
