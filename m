From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 21:49:01 +0000
Subject: [PATCH 24/51] DMA-API: dma: pl330: add dma_set_mask_and_coherent() call
Message-Id: <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, b43-dev@lists.infradead.org, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, e1000-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-ide@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Solarflare linux maintainers <linux-net-drivers@solarflare.com>, uclinux-dist-devel@blackfin.uclinux.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

The DMA API requires drivers to call the appropriate dma_set_mask()
functions before doing any DMA mapping.  Add this required call to
the AMBA PL08x driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/pl330.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index a562d24..df8b10f 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2903,6 +2903,10 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pdat = dev_get_platdata(&adev->dev);
 
+	ret = dma_set_mask_and_coherent(&adev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	/* Allocate a new DMAC and its Channels */
 	pdmac = devm_kzalloc(&adev->dev, sizeof(*pdmac), GFP_KERNEL);
 	if (!pdmac) {
-- 
1.7.4.4

