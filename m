From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 30 Sep 2013 07:58:15 +0000
Subject: [PATCH V8 0/3] Generic PHY driver for the Exynos SoC DP PHY
Message-Id: <000f01cebdb2$d1a20e10$74e62a30$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>

This patch series adds a simple driver for the Samsung Exynos SoC
series DP transmitter PHY, using the generic PHY framework [1].
Previously the DP PHY used an internal DT node to control the PHY
power enable bit.

This PATCH v8 follows:
 * PATCH v7, sent on August, 26th 2013
 * PATCH v6, sent on July, 9th 2013
 * PATCH v5, sent on July, 8th 2013
 * PATCH v4, sent on July, 2nd 2013
 * PATCH v3, sent on July, 1st 2013
 * PATCH v2, sent on June, 28th 2013
 * PATCH v1, sent on June, 28th 2013

Changes from v7:
  * Re-based on git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
 
Changes from v6:
  * Re-based on git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git

Changes from v5:
  * Re-based on git://gitorious.org/linuxphy/linuxphy.git

Changes from v4:
  * Marked original bindings as deprecated in 'exynos_dp.txt'
  * Fixed typo of commit message.
  * Added Tomasz Figa's Reviewed-by.

Changes from v3:
  * Added OF dependancy.
  * Removed redundant local variable 'void __iomem *addr'.
  * Removed unnecessary dev_set_drvdata().
  * Added a patch that remove non-DT support for Exynos
    Display Port driver.
  * Removed unnecessary 'struct exynos_dp_platdata'.
  * Kept supporting the original bindings for DT compatibility.

Changes from v2:
  * Removed redundant spinlock
  * Removed 'struct phy' from 'struct exynos_dp_video_phy'
  * Updated 'samsung-phy.txt', instead of creating
    'samsung,exynos5250-dp-video-phy.txt'.
  * Removed unnecessary additional specifier from 'phys'
    DT property.
  * Added 'phys', 'phy-names' properties to 'exynos_dp.txt' file.
  * Added Felipe Balbi's Acked-by.

Changes from v1:
  * Replaced exynos_dp_video_phy_xlate() with of_phy_simple_xlate(),
    as Kishon Vijay Abraham I guided.
  * Set the value of phy-cells as 0, because the phy_provider implements
    only one PHY.
  * Removed unnecessary header include.
  * Added '#ifdef CONFIG_OF' and of_match_ptr macro.

This series depends on the generic PHY framework [1]. These patches
refer to Sylwester Nawrocki's patches about Exynos MIPI [2].

[1] http://www.spinics.net/lists/kernel/msg1609491.html
[2] http://www.spinics.net/lists/linux-samsung-soc/msg23073.html

Jingoo Han (3):
  phy: Add driver for Exynos DP PHY
  video: exynos_dp: remove non-DT support for Exynos Display Port
  video: exynos_dp: Use the generic PHY driver

 .../devicetree/bindings/phy/samsung-phy.txt        |    8 ++
 .../devicetree/bindings/video/exynos_dp.txt        |   17 +--
 drivers/phy/Kconfig                                |    7 ++
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-exynos-dp-video.c                  |  111 ++++++++++++++++
 drivers/video/exynos/Kconfig                       |    2 +-
 drivers/video/exynos/exynos_dp_core.c              |  132 ++++++--------------
 drivers/video/exynos/exynos_dp_core.h              |  110 ++++++++++++++++
 drivers/video/exynos/exynos_dp_reg.c               |    2 -
 include/video/exynos_dp.h                          |  131 -------------------
 10 files changed, 284 insertions(+), 237 deletions(-)
 create mode 100644 drivers/phy/phy-exynos-dp-video.c
 delete mode 100644 include/video/exynos_dp.h
--
1.7.10.4

