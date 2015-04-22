From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 22 Apr 2015 23:04:09 +0000
Subject: [PATCHv3 0/4] add devm_of_phy_get_by_index and update platform drivers
Message-Id: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch set adds a new API to get phy by index when multiple 
phys are present. This patch is based on discussion with Arnd Bergmann
about dt bindings for multiple phys.

History:
v1:
    - Removed null pointers on Dmitry's suggestion
    - Improved documentation in commit messages
    - Exported new phy api
v2:
    - EHCI and OHCI platform Kconfigs select Generic Phy
      to fix build errors in certain configs.
v3:
    - Made GENERIC_PHY an invisible option so 
    that other configs can select it
    - Added stubs for devm_of_phy_get_by_index
    - Reformated code

Arun Ramamurthy (4):
  phy: phy-core: Make GENERIC_PHY an invisible option
  phy: core: Add devm_of_phy_get_by_index to phy-core
  usb: ehci-platform: Use devm_of_phy_get_by_index
  usb: ohci-platform: Use devm_of_phy_get_by_index

 Documentation/phy.txt                     |  7 +++-
 drivers/ata/Kconfig                       |  1 -
 drivers/media/platform/exynos4-is/Kconfig |  2 +-
 drivers/phy/Kconfig                       |  4 +-
 drivers/phy/phy-core.c                    | 32 ++++++++++++++
 drivers/usb/host/Kconfig                  |  4 +-
 drivers/usb/host/ehci-platform.c          | 69 +++++++++++--------------------
 drivers/usb/host/ohci-platform.c          | 69 +++++++++++--------------------
 drivers/video/fbdev/exynos/Kconfig        |  2 +-
 include/linux/phy/phy.h                   |  8 ++++
 10 files changed, 100 insertions(+), 98 deletions(-)

-- 
2.3.4

