From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 28 Jun 2013 07:14:18 +0000
Subject: [PATCH V2 0/3] Generic PHY driver for the Exynos SoC DP PHY
Message-Id: <001e01ce73cf$1ab3ab50$501b01f0$@samsung.com>
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

This PATCH v2 follows:
 * PATCH v1, sent on June, 28th 2013

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
[2] http://www.spinics.net/lists/linux-samsung-soc/msg20034.html

Jingoo Han (3):
  phy: Add driver for Exynos DP PHY
  ARM: dts: Add DP PHY node to exynos5250.dtsi
  video: exynos_dp: Use the generic PHY driver

 .../phy/samsung,exynos5250-dp-video-phy.txt        |    7 ++
 .../devicetree/bindings/video/exynos_dp.txt        |   17 ---
 arch/arm/boot/dts/exynos5250.dtsi                  |   13 ++++++++-----
 drivers/phy/Kconfig                                |    8 ++
 drivers/phy/Makefile                               |    3 +-
 drivers/phy/phy-exynos-dp-video.c                  |  122 ++++++++++++++++++++
 drivers/video/exynos/exynos_dp_core.c              |  118 ++------------------
 drivers/video/exynos/exynos_dp_core.h              |    2 +
 include/video/exynos_dp.h                          |    6 +-
 9 files changed, 162 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
 create mode 100644 drivers/phy/phy-exynos-dp-video.c

--
1.7.10.4

