From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 15 Jul 2017 20:07:35 +0000
Subject: [PATCH 00/11] Drop unnecessary static
Message-Id: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

These patches fix cases where there is a static on a local variable, but
the variable is initialized before any possible use.  Thus, the static has
no benefit.

---

 drivers/ata/sata_gemini.c                     |    2 +-
 drivers/clk/clk-moxart.c                      |    4 ++--
 drivers/clk/mmp/clk.c                         |    2 +-
 drivers/iio/orientation/hid-sensor-rotation.c |    2 +-
 drivers/irqchip/irq-digicolor.c               |    2 +-
 drivers/irqchip/irq-gic-realview.c            |    2 +-
 drivers/irqchip/irq-mips-cpu.c                |    2 +-
 drivers/mfd/max8925-i2c.c                     |    2 +-
 drivers/mfd/twl4030-irq.c                     |    2 +-
 drivers/mtd/maps/physmap_of_versatile.c       |    2 +-
 drivers/video/fbdev/da8xx-fb.c                |    2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)
