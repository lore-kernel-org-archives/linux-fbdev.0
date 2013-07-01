From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 01 Jul 2013 05:22:04 +0000
Subject: [PATCH V3 0/3] Generic PHY driver for the Exynos SoC DP PHY
Message-Id: <005101ce761a$ec7d6070$c5782150$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series adds a simple driver for the Samsung Exynos SoC
series DP transmitter PHY, using the generic PHY framework [1].
Previously the DP PHY used a platform callback or internal DT node
to control the PHY power enable bit.
The platform callback and internal DT node can be dropped and this
driver does not need any calls back to the platform code.

These patches was tested on Exynos5250.

This PATCH v3 follows:
 * PATCH v2, sent on June, 28th 2013
 * PATCH v1, sent on June, 28th 2013

Changes between v2 and v3:
  * Removed redundant spinlock
  * Removed 'struct phy' from 'struct exynos_dp_video_phy'
  * Updated 'samsung-phy.txt', instead of creating
    'samsung,exynos5250-dp-video-phy.txt'.
  * Removed unnecessary additional specifier from 'phys'
    DT property.
  * Added 'phys', 'phy-names' properties to 'exynos_dp.txt' file.
  * Added Felipe Balbi's Acked-by.

Changes between v1 and v2:
  * Replaced exynos_dp_video_phy_xlate() with of_phy_simple_xlate(),
    as Kishon Vijay Abraham I guided.
  * Set the value of phy-cells as 0, because the phy_provider implements
    only one PHY.
  * Removed unnecessary header include.
  * Added '#ifdef CONFIG_OF' and of_match_ptr macro.

This series depends on the generic PHY framework [1]. These patches
refer to Sylwester Nawrocki's patches about Exynos MIPI [2].

[1] https://lkml.org/lkml/2013/6/26/259
[2] http://www.spinics.net/lists/linux-samsung-soc/msg20098.html

Jingoo Han (3):
  ARM: dts: Add DP PHY node to exynos5250.dtsi
  phy: Add driver for Exynos DP PHY
  video: exynos_dp: Use the generic PHY driver

 .../devicetree/bindings/phy/samsung-phy.txt        |    8 ++
 .../devicetree/bindings/video/exynos_dp.txt        |   23 +---
 arch/arm/boot/dts/exynos5250.dtsi                  |   13 ++++++++-----
 drivers/phy/Kconfig                                |    5 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-exynos-dp-video.c                  |  118 ++++++++++++++++++++
 drivers/video/exynos/exynos_dp_core.c              |  118 ++------------------
 drivers/video/exynos/exynos_dp_core.h              |    2 +
 include/video/exynos_dp.h                          |    6 +-
 9 files changed, 161 insertions(+), 133 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
 create mode 100644 drivers/phy/phy-exynos-dp-video.c

--
1.7.10.4

