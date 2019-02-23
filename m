From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 23 Feb 2019 13:20:31 +0000
Subject: [PATCH 00/12] add missing of_node_put after of_device_is_available
Message-Id: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-amlogic@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-crypto@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Failure of of_device_is_available implies that the device node
should be put, if it is not used otherwise.

---

 arch/arm/mach-omap2/display.c                            |    4 +++-
 arch/powerpc/platforms/83xx/usb.c                        |    4 +++-
 drivers/bus/arm-cci.c                                    |    4 +++-
 drivers/cpufreq/armada-8k-cpufreq.c                      |    4 +++-
 drivers/crypto/amcc/crypto4xx_trng.c                     |    4 +++-
 drivers/firmware/psci.c                                  |    4 +++-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c          |    4 +++-
 drivers/gpu/drm/tegra/rgb.c                              |    4 +++-
 drivers/phy/tegra/xusb.c                                 |    4 +++-
 drivers/soc/amlogic/meson-gx-socinfo.c                   |    4 +++-
 drivers/tee/optee/core.c                                 |    4 +++-
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c |    4 +++-
 12 files changed, 36 insertions(+), 12 deletions(-)
