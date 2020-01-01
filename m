From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Wed, 01 Jan 2020 17:49:40 +0000
Subject: [PATCH 00/10] use resource_size
Message-Id: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-fbdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes these changes is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@
struct resource ptr;
@@

- ((ptr.end) - (ptr.start) + 1)
+ resource_size(&ptr)

@@
struct resource *ptr;
@@

- ((ptr->end) - (ptr->start) + 1)
+ resource_size(ptr)

@@
struct resource ptr;
@@

- ((ptr.end) + 1 - (ptr.start))
+ resource_size(&ptr)

@@
struct resource *ptr;
@@

- ((ptr->end) + 1 - (ptr->start))
+ resource_size(ptr)
</smpl>

---

 arch/mips/kernel/setup.c                  |    6 ++----
 arch/powerpc/platforms/83xx/km83xx.c      |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 ++--
 arch/x86/kernel/crash.c                   |    2 +-
 drivers/net/ethernet/freescale/fman/mac.c |    4 ++--
 drivers/usb/gadget/udc/omap_udc.c         |    6 +++---
 drivers/video/fbdev/cg14.c                |    3 +--
 drivers/video/fbdev/s1d13xxxfb.c          |   16 ++++++++--------
 sound/drivers/ml403-ac97cr.c              |    4 +---
 sound/soc/sof/imx/imx8.c                  |    3 +--
 10 files changed, 22 insertions(+), 28 deletions(-)
