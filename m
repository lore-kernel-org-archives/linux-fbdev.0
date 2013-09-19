From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 21:52:02 +0000
Subject: [PATCH 27/51] DMA-API: provide a helper to setup DMA masks
Message-Id: <E1VMm8o-0007iV-Ac@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
In-Reply-To: <20130919212235.GD12758-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, b43-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-crypto-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvme-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Solarflare linux maintainers <linux-net-drivers-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Many drivers contain code such as:

	dev->dma_mask = &dev->coherent_dma_mask;
	dev->coherent_dma_mask = MASK;

Let's move this pattern out of drivers and have the DMA API provide a
helper for it.  This helper uses dma_set_mask_and_coherent() to allow
platform issues to be properly dealt with via dma_set_mask()/
dma_is_supported().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/dma-mapping.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ec951f9..27d1421 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -111,6 +111,16 @@ static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
 	return rc;
 }
 
+/*
+ * Similar to the above, except it deals with the case where the device
+ * does not have dev->dma_mask appropriately setup.
+ */
+static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
+{
+	dev->dma_mask = &dev->coherent_dma_mask;
+	return dma_set_mask_and_coherent(dev, mask);
+}
+
 extern u64 dma_get_required_mask(struct device *dev);
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
1.7.4.4

