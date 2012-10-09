From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 09 Oct 2012 20:13:50 +0000
Subject: [PATCH v2 0/8]  ARM: mostly harmless gcc warnings
Message-Id: <1349813638-4617-1-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Most patches from the first time this was posted have been
adopted by a subsystem maintainer or were show to be obsolete.
Here are the remaining ones again.

I'm planning to submit those patches that are still necessary
by the time we have an -rc1 through the arm-soc tree, but
my preference is still to have them go through the subsystem
maintainers.

Olof: should we add it to for-next?

	Arnd

Arnd Bergmann (8):
  SCSI: ARM: ncr5380/oak uses no interrupts
  SCSI: ARM: make fas216_dumpinfo function conditional
  mm/slob: use min_t() to compare ARCH_SLAB_MINALIGN
  USB: EHCI: mark ehci_orion_conf_mbus_windows __devinit
  clk: don't mark clkdev_add_table as init
  pcmcia: sharpsl: don't discard sharpsl_pcmcia_ops
  video: mark nuc900fb_map_video_memory as __devinit
  spi/s3c64xx: use correct dma_transfer_direction type

 drivers/clk/clkdev.c            |    2 +-
 drivers/pcmcia/pxa2xx_sharpsl.c |    2 +-
 drivers/scsi/arm/fas216.c       |    2 +-
 drivers/scsi/arm/oak.c          |    1 +
 drivers/spi/spi-s3c64xx.c       |    2 +-
 drivers/usb/host/ehci-orion.c   |    2 +-
 drivers/video/nuc900fb.c        |    2 +-
 mm/slob.c                       |    6 +++---
 8 files changed, 10 insertions(+), 9 deletions(-)

-- 
1.7.10

Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Pavel Machek <pavel@suse.cz>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net
Cc: stable@vger.kernel.org
