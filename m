From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 28 Jun 2013 05:21:15 +0000
Subject: [PATCH 0/3] Generic PHY driver for the Exynos SoC DP PHY
Message-Id: <001401ce73bf$4f9a67b0$eecf3710$@samsung.com>
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
 drivers/phy/phy-exynos-dp-video.c                  |  130 ++++++++++++++++++++
 drivers/video/exynos/exynos_dp_core.c              |  118 ++------------------
 drivers/video/exynos/exynos_dp_core.h              |    2 +
 include/video/exynos_dp.h                          |    6 +-
 9 files changed, 170 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
 create mode 100644 drivers/phy/phy-exynos-dp-video.c

--
1.7.10.4

