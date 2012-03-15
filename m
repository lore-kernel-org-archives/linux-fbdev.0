From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Mar 2012 17:43:54 +0000
Subject: [RFC/PATCH 6/6] fbdev: sh_mobile_lcdc: Added MERAM-backed frame buffer support
Message-Id: <1331833434-11934-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Storing the frame buffer in the MERAM allows system memory to be put to
a low power state (assuming the CPU is idle). However, the MERAM size
doesn't allow for double-buffering of large frame buffers in a high bit
per pixel format. The frame buffer can't thus be permanently stored in
MERAM.

The optional frame buffer MERAM backing store allows switching between
system memory and MERAM at runtime. The backing store is selected by
userspace through the backingstore sysfs property. When switching to
MERAM to frame buffer contents are copied to the allocated MERAM backing
store. This freezes the display until switching back to system memory,
or panning which triggers a display update.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |  145 +++++++++++++++++++++++++++++++++++---
 drivers/video/sh_mobile_lcdcfb.h |    3 +
 include/video/sh_mobile_lcdc.h   |    1 +
 3 files changed, 139 insertions(+), 10 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 23d0446..a443592 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -971,6 +971,117 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 }
 
 /* -----------------------------------------------------------------------------
+ * MERAM backing store
+ */
+
+static void sh_mobile_lcdc_set_fb_addr(struct sh_mobile_lcdc_chan *ch,
+				       unsigned long addr_y,
+				       unsigned long addr_c)
+{
+	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
+	unsigned long ldrcntr;
+
+	lcdc_write_chan_mirror(ch, LDSA1R, addr_y);
+	if (ch->format->yuv)
+		lcdc_write_chan_mirror(ch, LDSA2R, addr_c);
+
+	ldrcntr = lcdc_read(priv, _LDRCNTR);
+	if (lcdc_chan_is_sublcd(ch))
+		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
+	else
+		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_MRS);
+}
+
+/*
+ * sh_mobile_lcdc_copy_fb_memory - Copy frame buffer from system memory to MERAM
+ *
+ * Copy the visible frame buffer content (taking pan offsets into account) from
+ * system memory to a contiguous memory block in MERAM.
+ */
+static void sh_mobile_lcdc_copy_fb_memory(struct sh_mobile_lcdc_chan *ch)
+{
+	void *fb_mem = ch->fb_mem;
+	void __iomem *mem;
+	size_t size;
+
+	if (ch->fb_meram = 0)
+		return;
+
+	size = ch->xres * ch->yres * ch->format->bpp / 8;
+	mem = ioremap_wc(ch->fb_meram, size);
+	if (mem = NULL)
+		return;
+
+	memcpy_toio(mem, fb_mem + ch->pan_y_offset, size);
+	if (ch->format->yuv) {
+		fb_mem = ch->fb_mem + ch->xres_virtual * ch->yres_virtual;
+		memcpy_toio(mem + ch->xres * ch->yres,
+			    fb_mem + ch->pan_c_offset,
+			    size - ch->xres * ch->yres);
+	}
+
+	iounmap(mem);
+}
+
+static ssize_t lcdc_backing_store_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 ch->fb_in_meram ? "meram" : "system");
+}
+
+static ssize_t lcdc_backing_store_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	bool fb_in_meram;
+
+	if (strncmp(buf, "system", 6) = 0)
+		fb_in_meram = false;
+	else if (strncmp(buf, "meram", 5) = 0)
+		fb_in_meram = true;
+	else
+		return -EINVAL;
+
+	mutex_lock(&ch->meram_lock);
+
+	printk(KERN_INFO "%s: fb_in_meram is %s, wants %s\n", __func__,
+		ch->fb_in_meram ? "true" : "false",
+		fb_in_meram ? "true" : "false");
+	if (ch->fb_in_meram = fb_in_meram)
+		goto done;
+
+	if (fb_in_meram) {
+		unsigned long base_addr_y;
+		unsigned long base_addr_c;
+
+		base_addr_y = ch->fb_meram;
+		base_addr_c = ch->fb_meram + ch->xres * ch->yres;
+
+		sh_mobile_lcdc_copy_fb_memory(ch);
+		sh_mobile_lcdc_set_fb_addr(ch, base_addr_y, base_addr_c);
+	} else {
+		sh_mobile_lcdc_set_fb_addr(ch, ch->base_addr_y,
+					   ch->base_addr_c);
+	}
+
+	ch->fb_in_meram = fb_in_meram;
+
+done:
+	mutex_unlock(&ch->meram_lock);
+	return count;
+}
+
+static const struct device_attribute lcdc_backing_store_attr +	__ATTR(backingstore, S_IRUGO|S_IWUSR,
+	       lcdc_backing_store_show, lcdc_backing_store_store);
+
+/* -----------------------------------------------------------------------------
  * Frame buffer operations
  */
 
@@ -1035,7 +1146,6 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
-	unsigned long ldrcntr;
 	unsigned long base_addr_y, base_addr_c = 0;
 	unsigned long y_offset;
 	unsigned long c_offset;
@@ -1071,16 +1181,16 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	ch->pan_y_offset = y_offset;
 	ch->pan_c_offset = c_offset;
 
-	lcdc_write_chan_mirror(ch, LDSA1R, base_addr_y);
-	if (ch->format->yuv)
-		lcdc_write_chan_mirror(ch, LDSA2R, base_addr_c);
+	sh_mobile_lcdc_set_fb_addr(ch, base_addr_y, base_addr_c);
 
-	ldrcntr = lcdc_read(priv, _LDRCNTR);
-	if (lcdc_chan_is_sublcd(ch))
-		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
-	else
-		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_MRS);
+	if (ch->fb_in_meram) {
+		sh_mobile_wait_for_vsync(ch);
+		sh_mobile_lcdc_copy_fb_memory(ch);
 
+		base_addr_y = ch->fb_meram;
+		base_addr_c = ch->fb_meram + ch->xres * ch->yres;
+		sh_mobile_lcdc_set_fb_addr(ch, base_addr_y, base_addr_c);
+	}
 
 	sh_mobile_lcdc_deferred_io_touch(info);
 
@@ -1431,11 +1541,17 @@ sh_mobile_lcdc_channel_fb_register(struct sh_mobile_lcdc_chan *ch)
 		 "mainlcd" : "sublcd", info->var.xres, info->var.yres,
 		 info->var.bits_per_pixel);
 
+	if (ch->fb_meram) {
+		ret = device_create_file(info->dev, &lcdc_backing_store_attr);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* deferred io mode: disable clock to save power */
 	if (info->fbdefio || info->state = FBINFO_STATE_SUSPENDED)
 		sh_mobile_lcdc_clk_off(ch->lcdc);
 
-	return ret;
+	return 0;
 }
 
 static void
@@ -1722,6 +1838,9 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 		if (ch->fb_mem)
 			dma_free_coherent(&pdev->dev, ch->fb_size,
 					  ch->fb_mem, ch->dma_handle);
+		if (ch->fb_meram)
+			sh_mobile_meram_free(priv->meram_dev, ch->fb_meram,
+					     ch->fb_size / 2);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
@@ -1730,6 +1849,7 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 		if (ch->bl)
 			sh_mobile_lcdc_bl_remove(ch->bl);
 		mutex_destroy(&ch->open_lock);
+		mutex_destroy(&ch->meram_lock);
 	}
 
 	if (priv->dot_clk) {
@@ -1799,6 +1919,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	unsigned int i;
 
 	mutex_init(&ch->open_lock);
+	mutex_init(&ch->meram_lock);
 	ch->notify = sh_mobile_lcdc_display_notify;
 
 	/* Validate the format. */
@@ -1873,6 +1994,10 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 		return -ENOMEM;
 	}
 
+	if (cfg->meram_backing_store)
+		ch->fb_meram = sh_mobile_meram_alloc(priv->meram_dev,
+						     ch->fb_size / 2);
+
 	/* Initialize the transmitter device if present. */
 	if (cfg->tx_dev) {
 		if (!cfg->tx_dev->dev.driver ||
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 5320ad4..9796740 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -68,6 +68,9 @@ struct sh_mobile_lcdc_chan {
 
 	void *fb_mem;
 	unsigned long fb_size;
+	unsigned long fb_meram;
+	bool fb_in_meram;
+	struct mutex meram_lock;	/* protects fb_in_meram */
 
 	dma_addr_t dma_handle;
 	unsigned long pan_y_offset;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 7571b27..3ceb221 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -179,6 +179,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
 	const struct sh_mobile_meram_cfg *meram_cfg;
+	bool meram_backing_store;
 
 	struct platform_device *tx_dev;	/* HDMI/DSI transmitter device */
 };
-- 
1.7.3.4

