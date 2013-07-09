From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 09 Jul 2013 08:03:35 +0000
Subject: [PATCH V6 0/4] Generic PHY driver for the Exynos SoC DP PHY
Message-Id: <003d01ce7c7a$d04043d0$70c0cb70$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series adds a simple driver for the Samsung Exynos SoC
series DP transmitter PHY, using the generic PHY framework [1].
Previously the DP PHY used an internal DT node to control the PHY
power enable bit.

These patches was tested on Exynos5250.

This PATCH v6 follows:
 * PATCH v5, sent on July, 8th 2013
 * PATCH v4, sent on July, 2nd 2013
 * PATCH v3, sent on July, 1st 2013
 * PATCH v2, sent on June, 28th 2013
 * PATCH v1, sent on June, 28th 2013

Changes between v5 and v6:
  * Re-based on git://gitorious.org/linuxphy/linuxphy.git

Changes between v4 and v5:
  * Marked original bindings as deprecated in 'exynos_dp.txt'
  * Fixed typo of commit message.
  * Added Tomasz Figa's Reviewed-by.

Changes between v3 and v4:
  * Added OF dependancy.
  * Removed redundant local variable 'void __iomem *addr'.
  * Removed unnecessary dev_set_drvdata().
  * Added a patch that remove non-DT support for Exynos
    Display Port driver.
  * Removed unnecessary 'struct exynos_dp_platdata'.
  * Kept supporting the original bindings for DT compatibility.

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

Jingoo Han (4):
  ARM: dts: Add DP PHY node to exynos5250.dtsi
  phy: Add driver for Exynos DP PHY
  video: exynos_dp: remove non-DT support for Exynos Display Port
  video: exynos_dp: Use the generic PHY driver

 .../devicetree/bindings/phy/samsung-phy.txt        |    8 ++
 .../devicetree/bindings/video/exynos_dp.txt        |   18 +++++++++---------
 arch/arm/boot/dts/exynos5250.dtsi                  |   13 ++++++++-----
 drivers/phy/Kconfig                                |    6 ++
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-exynos-dp-video.c                  |  111 ++++++++++++++++++++
 drivers/video/exynos/Kconfig                       |    2 +-
 drivers/video/exynos/exynos_dp_core.c              |  132 +++++++----------------------
 drivers/video/exynos/exynos_dp_core.h              |  110 +++++++++++++++++++++++++++
 drivers/video/exynos/exynos_dp_reg.c               |    2 -
 include/video/exynos_dp.h                          |  131 ---------------------------------
 11 files changed, 291 insertions(+), 243 deletions(-) 
 create mode 100644 drivers/phy/phy-exynos-dp-video.c
 delete mode 100644 include/video/exynos_dp.h

--
1.7.10.4

