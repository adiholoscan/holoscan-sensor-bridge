#!/bin/bash
#!/bin/bash
set -e

echo "========================================"
echo "ROS 2 Installer"
echo "========================================"
echo
echo "This script will:"
echo "  - Detect Ubuntu version"
echo "  - Install ROS 2 Humble (22.04)"
echo "    or ROS 2 Jazzy (24.04)"
echo "  - Install CycloneDDS"
echo "  - Configure ROS environment"
echo
read -rp "Do you want to continue? [Y/N]: " INSTALL_ROS

case "$INSTALL_ROS" in
    Y|y)
        echo "Proceeding with ROS installation..."
        ;;
    *)
        echo "Installation cancelled."
        exit 0
        ;;
esac

# --------------------------------------------------------------------------
# Detect Ubuntu Version
# --------------------------------------------------------------------------

echo "Detecting Ubuntu release..."
source /etc/os-release

case "${VERSION_ID}" in
    "22.04")
        ROS_DISTRO="humble"
        ;;
    "24.04")
        ROS_DISTRO="jazzy"
        ;;
    *)
        echo "Unsupported Ubuntu version: ${VERSION_ID}"
        exit 1
        ;;
esac

echo "Installing ROS2 ${ROS_DISTRO}..."

export DEBIAN_FRONTEND=noninteractive


echo "Installing ROS2 ${ROS_DISTRO} on Ubuntu ${UBUNTU_VERSION}"


export CYCLONEDDS_URI=file:///etc/cyclonedds/config1.xml

#source /opt/ros/${ROS_DISTRO}/setup.bash

ros2 doctor --report || true


echo "Note: If you are running this within container, ROS2 will be removed on next container launch..need to rerun this script"
echo "Manually run 'source /opt/ros/${ROS_DISTRO}/setup.bash' on the shell to setup the environment before running ADI IMU capture"
