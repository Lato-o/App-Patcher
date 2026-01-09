#!/usr/bin/env bash

# Script pour mettre à jour le README.md avec la liste complète des patches
# Usage: ./update-readme-patches.sh

set -euo pipefail

source utils.sh 2>/dev/null || true

TEMP_DIR="temp-patches-analysis"
README_FILE="README.md"
REPO_ROOT=$(pwd)

# Couleurs pour l'output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

pr() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[-]${NC} $1"; }

cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        pr "Nettoyage des fichiers temporaires..."
        rm -rf "$TEMP_DIR"
    fi
}
trap cleanup EXIT

mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Fonction pour obtenir les patches depuis un fichier
get_patches_from_file() {
    local cli_jar=$1
    local patches_file=$2
    local package_name=$3
    
    if [ ! -f "$cli_jar" ] || [ ! -f "$patches_file" ]; then
        return 1
    fi
    
    java -jar "$cli_jar" list-patches "$patches_file" -f "$package_name" 2>/dev/null | \
        grep "^Name:" | \
        sed 's/^Name: //' | \
        sort || return 1
}

# Fonction pour formater les patches en markdown
format_patches_markdown() {
    local patches_list=$1
    local category=$2
    
    if [ -z "$patches_list" ]; then
        return
    fi
    
    echo ""
    echo "**$category:****"
    echo ""
    echo "$patches_list" | while IFS= read -r patch; do
        if [ -n "$patch" ]; then
            echo "- $patch"
        fi
    done
}

# Analyser les patches et générer le markdown
pr "Début de l'analyse des patches..."

# YouTube (anddea/revanced-patches)
pr "Analyse de YouTube (anddea/revanced-patches)..."
youtube_cli=$(get_cli "inotia00" "revanced-cli" "latest" 2>/dev/null || echo "")
youtube_patches_file=$(get_patches "anddea" "revanced-patches" "dev" "rvp" 2>/dev/null || echo "")

YOUTUBE_PATCHES_MD=""
if [ -n "$youtube_cli" ] && [ -n "$youtube_patches_file" ]; then
    youtube_patches=$(get_patches_from_file "$youtube_cli" "$youtube_patches_file" "com.google.android.youtube" 2>/dev/null || echo "")
    if [ -n "$youtube_patches" ]; then
        YOUTUBE_PATCHES_MD=$(format_patches_markdown "$youtube_patches" "Tous les patches disponibles")
    fi
fi

# YouTube Music (anddea/revanced-patches)
pr "Analyse de YouTube Music (anddea/revanced-patches)..."
music_patches_file=$(get_patches "anddea" "revanced-patches" "dev" "rvp" 2>/dev/null || echo "")

MUSIC_PATCHES_MD=""
if [ -n "$youtube_cli" ] && [ -n "$music_patches_file" ]; then
    music_patches=$(get_patches_from_file "$youtube_cli" "$music_patches_file" "com.google.android.apps.youtube.music" 2>/dev/null || echo "")
    if [ -n "$music_patches" ]; then
        MUSIC_PATCHES_MD=$(format_patches_markdown "$music_patches" "Tous les patches disponibles")
    fi
fi

# YouTube (MorpheApp)
pr "Analyse de YouTube (MorpheApp)..."
morphe_cli=$(get_cli "MorpheApp" "morphe-cli" "latest" 2>/dev/null || echo "")
morphe_youtube_patches_file=$(get_patches "MorpheApp" "morphe-patches" "dev" "mpp" 2>/dev/null || echo "")

MORPHE_YOUTUBE_PATCHES_MD=""
if [ -n "$morphe_cli" ] && [ -n "$morphe_youtube_patches_file" ]; then
    morphe_youtube_patches=$(get_patches_from_file "$morphe_cli" "$morphe_youtube_patches_file" "com.google.android.youtube" 2>/dev/null || echo "")
    if [ -n "$morphe_youtube_patches" ]; then
        MORPHE_YOUTUBE_PATCHES_MD=$(format_patches_markdown "$morphe_youtube_patches" "Tous les patches disponibles")
    fi
fi

# YouTube Music (MorpheApp)
pr "Analyse de YouTube Music (MorpheApp)..."
morphe_music_patches_file=$(get_patches "MorpheApp" "morphe-patches" "v1.2.1-dev.2" "mpp" 2>/dev/null || echo "")

MORPHE_MUSIC_PATCHES_MD=""
if [ -n "$morphe_cli" ] && [ -n "$morphe_music_patches_file" ]; then
    morphe_music_patches=$(get_patches_from_file "$morphe_cli" "$morphe_music_patches_file" "com.google.android.apps.youtube.music" 2>/dev/null || echo "")
    if [ -n "$morphe_music_patches" ]; then
        MORPHE_MUSIC_PATCHES_MD=$(format_patches_markdown "$morphe_music_patches" "Tous les patches disponibles")
    fi
fi

# SoundCloud (ReVanced)
pr "Analyse de SoundCloud (ReVanced)..."
revanced_cli=$(get_cli "j-hc" "revanced-cli" "latest" 2>/dev/null || echo "")
soundcloud_patches_file=$(get_patches "ReVanced" "revanced-patches" "latest" "rvp" 2>/dev/null || echo "")

SOUNDCLOUD_PATCHES_MD=""
if [ -n "$revanced_cli" ] && [ -n "$soundcloud_patches_file" ]; then
    soundcloud_patches=$(get_patches_from_file "$revanced_cli" "$soundcloud_patches_file" "com.soundcloud.android" 2>/dev/null || echo "")
    if [ -n "$soundcloud_patches" ]; then
        SOUNDCLOUD_PATCHES_MD=$(format_patches_markdown "$soundcloud_patches" "Tous les patches disponibles")
    fi
fi

cd "$REPO_ROOT"

# Mettre à jour le README.md
pr "Mise à jour du README.md..."

# Créer un fichier temporaire pour le nouveau README
TEMP_README=$(mktemp)

# Copier le README jusqu'à la section "Applied Patches"
awk '/^### Applied Patches/{exit} {print}' "$README_FILE" > "$TEMP_README"

# Ajouter la nouvelle section Applied Patches
cat >> "$TEMP_README" << 'EOF'
### Applied Patches

> **Note:** For the complete and up-to-date list of all available patches, please refer to the official patch repositories:
> - [anddea/revanced-patches](https://github.com/anddea/revanced-patches) - [Full patch list](https://github.com/anddea/revanced-patches#-patches)
> - [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches) - [Full patch list](https://github.com/MorpheApp/morphe-patches)
> - [ReVanced/revanced-patches](https://github.com/ReVanced/revanced-patches) - [Full patch list](https://github.com/ReVanced/revanced-patches#-patches)

#### YouTube (ReVanced Extended)

**Configuration:**
- **Included Patches (whitelist):**
  - Custom header for YouTube
  - Hide Shorts dimming
  - Hide shortcuts
  - MaterialYou
- **Excluded Patches:**
  - Custom branding icon for YouTube
  - Custom branding name for YouTube
- **Additional Options:**
  - Visual preferences icons: gear icon
  - Settings label: "ReVanced Extended"
  - Dark theme background color: black

**Available Patches from [anddea/revanced-patches](https://github.com/anddea/revanced-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

EOF

if [ -n "$YOUTUBE_PATCHES_MD" ]; then
    echo "$YOUTUBE_PATCHES_MD" >> "$TEMP_README"
else
    echo "*Note: Unable to fetch patches list. Please check the official repository.*" >> "$TEMP_README"
fi

cat >> "$TEMP_README" << EOF

</details>

#### YouTube Music (ReVanced Extended)

**Configuration:**
- **Included Patches (whitelist):**
  - Custom header for YouTube Music
  - Disable music video in album
  - Hide overlay filter
  - Hide player overlay filter
- **Excluded Patches:**
  - Dark theme
  - Custom branding name for YouTube Music
- **Additional Options:**
  - Visual preferences icons: gear icon
  - Settings label: "ReVanced Extended"

**Available Patches from [anddea/revanced-patches](https://github.com/anddea/revanced-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

EOF

if [ -n "$MUSIC_PATCHES_MD" ]; then
    echo "$MUSIC_PATCHES_MD" >> "$TEMP_README"
else
    echo "*Note: Unable to fetch patches list. Please check the official repository.*" >> "$TEMP_README"
fi

cat >> "$TEMP_README" << EOF

</details>

#### YouTube (Morphe)

**Configuration:**
- **Excluded Patches:**
  - Custom branding name for YouTube
  - Custom branding icon for YouTube
- **Included Patches:** All other available patches from MorpheApp are included by default

**Available Patches from [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

EOF

if [ -n "$MORPHE_YOUTUBE_PATCHES_MD" ]; then
    echo "$MORPHE_YOUTUBE_PATCHES_MD" >> "$TEMP_README"
else
    echo "*Note: Unable to fetch patches list. Please check the official repository.*" >> "$TEMP_README"
fi

cat >> "$TEMP_README" << EOF

</details>

#### YouTube Music (Morphe)

**Configuration:**
- **Excluded Patches:**
  - Custom branding name for YouTube Music
  - Custom branding icon for YouTube Music
- **Included Patches:** All other available patches from MorpheApp are included by default

**Available Patches from [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

EOF

if [ -n "$MORPHE_MUSIC_PATCHES_MD" ]; then
    echo "$MORPHE_MUSIC_PATCHES_MD" >> "$TEMP_README"
else
    echo "*Note: Unable to fetch patches list. Please check the official repository.*" >> "$TEMP_README"
fi

cat >> "$TEMP_README" << EOF

</details>

#### SoundCloud

**Configuration:**
- **Included Patches:** All available patches from ReVanced are included by default (no specific inclusions/exclusions configured)

**Available Patches from [ReVanced/revanced-patches](https://github.com/ReVanced/revanced-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

EOF

if [ -n "$SOUNDCLOUD_PATCHES_MD" ]; then
    echo "$SOUNDCLOUD_PATCHES_MD" >> "$TEMP_README"
else
    echo "*Note: Unable to fetch patches list. Please check the official repository.*" >> "$TEMP_README"
fi

cat >> "$TEMP_README" << EOF

</details>
EOF

# Ajouter le reste du README après la section Applied Patches
awk '/^### Installation Instructions/{found=1} found' "$README_FILE" >> "$TEMP_README"

# Remplacer le README original
mv "$TEMP_README" "$README_FILE"

pr "README.md mis à jour avec succès !"
