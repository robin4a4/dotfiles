#!/bin/bash

# Dotfiles Install Script
# This script creates symlinks for aerospace and ghostty configurations to ~/.config

set -e  # Exit on any error

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🚀 Dotfiles Install Script${NC}"
echo "=================================="

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    if [ -L "$target" ]; then
        echo -e "${YELLOW}⚠️  $name symlink already exists, removing old symlink...${NC}"
        rm "$target"
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}⚠️  $name directory/file already exists, creating backup...${NC}"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    echo -e "${BLUE}🔗 Creating symlink for $name...${NC}"
    ln -s "$source" "$target"
    echo -e "${GREEN}✅ $name symlink created successfully!${NC}"
}

# Create ~/.config directory if it doesn't exist
CONFIG_DIR="$HOME/.config"
if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${BLUE}📁 Creating ~/.config directory...${NC}"
    mkdir -p "$CONFIG_DIR"
fi

# Create symlinks
echo -e "\n${BLUE}📋 Creating symlinks...${NC}"

# Aerospace symlink
create_symlink "$SCRIPT_DIR/aerospace" "$CONFIG_DIR/aerospace" "AeroSpace"

# Ghostty symlink
create_symlink "$SCRIPT_DIR/ghostty" "$CONFIG_DIR/ghostty" "Ghostty"

echo -e "\n${GREEN}🎉 Installation completed successfully!${NC}"
echo -e "${BLUE}📝 Summary:${NC}"
echo "  • AeroSpace config: $CONFIG_DIR/aerospace -> $SCRIPT_DIR/aerospace"
echo "  • Ghostty config: $CONFIG_DIR/ghostty -> $SCRIPT_DIR/ghostty"
echo -e "\n${YELLOW}💡 Note: You may need to restart AeroSpace and Ghostty for changes to take effect.${NC}"
