From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/16] savagefb: Driver cleanup
Date: Mon, 28 Nov 2005 23:15:28 +0800
Message-ID: <438B1F10.7090708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGmv-00022J-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:37 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGmo-0001SK-3A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:37 -0800
Received: by zproxy.gmail.com with SMTP id r28so881625nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:29:29 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- remove redundant casts
- remove symbol_get/symbol_put

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/savage/savagefb-i2c.c    |   45 ++++++++++++--------------------
 drivers/video/savage/savagefb_accel.c  |    8 +++---
 drivers/video/savage/savagefb_driver.c |   33 +++++++++++------------
 3 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index aeec437..00719a9 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -49,7 +49,7 @@
 
 static void savage4_gpio_setscl(void *data, int val)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 	unsigned int r;
 
 	r = readl(chan->ioaddr + chan->reg);
@@ -63,7 +63,7 @@ static void savage4_gpio_setscl(void *da
 
 static void savage4_gpio_setsda(void *data, int val)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 
 	unsigned int r;
 	r = readl(chan->ioaddr + chan->reg);
@@ -77,21 +77,21 @@ static void savage4_gpio_setsda(void *da
 
 static int savage4_gpio_getscl(void *data)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 
 	return (0 != (readl(chan->ioaddr + chan->reg) & SAVAGE4_I2C_SCL_IN));
 }
 
 static int savage4_gpio_getsda(void *data)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 
 	return (0 != (readl(chan->ioaddr + chan->reg) & SAVAGE4_I2C_SDA_IN));
 }
 
 static void prosavage_gpio_setscl(void* data, int val)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 	u32			  r;
 
 	SET_CR_IX(chan->ioaddr, chan->reg);
@@ -107,7 +107,7 @@ static void prosavage_gpio_setscl(void* 
 
 static void prosavage_gpio_setsda(void* data, int val)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 	unsigned int r;
 
 	SET_CR_IX(chan->ioaddr, chan->reg);
@@ -123,7 +123,7 @@ static void prosavage_gpio_setsda(void* 
 
 static int prosavage_gpio_getscl(void* data)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 
 	SET_CR_IX(chan->ioaddr, chan->reg);
 	return (0 != (GET_CR_DATA(chan->ioaddr) & PROSAVAGE_I2C_SCL_IN));
@@ -131,7 +131,7 @@ static int prosavage_gpio_getscl(void* d
 
 static int prosavage_gpio_getsda(void* data)
 {
-	struct savagefb_i2c_chan *chan = (struct savagefb_i2c_chan *)data;
+	struct savagefb_i2c_chan *chan = data;
 
 	SET_CR_IX(chan->ioaddr, chan->reg);
 	return (0 != (GET_CR_DATA(chan->ioaddr) & PROSAVAGE_I2C_SDA_IN));
@@ -140,10 +140,9 @@ static int prosavage_gpio_getsda(void* d
 static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,
 				const char *name)
 {
-	int (*add_bus)(struct i2c_adapter *) = symbol_get(i2c_bit_add_bus);
 	int rc = 0;
 
-	if (add_bus && chan->par) {
+	if (chan->par) {
 		strcpy(chan->adapter.name, name);
 		chan->adapter.owner		= THIS_MODULE;
 		chan->adapter.id		= I2C_HW_B_SAVAGE;
@@ -161,7 +160,7 @@ static int savage_setup_i2c_bus(struct s
 		chan->algo.setscl(chan, 1);
 		udelay(20);
 
-		rc = add_bus(&chan->adapter);
+		rc = i2c_bit_add_bus(&chan->adapter);
 
 		if (rc == 0)
 			dev_dbg(&chan->par->pcidev->dev,
@@ -169,8 +168,6 @@ static int savage_setup_i2c_bus(struct s
 		else
 			dev_warn(&chan->par->pcidev->dev,
 				 "Failed to register I2C bus %s.\n", name);
-
-		symbol_put(i2c_bit_add_bus);
 	} else
 		chan->par = NULL;
 
@@ -179,7 +176,7 @@ static int savage_setup_i2c_bus(struct s
 
 void savagefb_create_i2c_busses(struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	par->chan.par	= par;
 
 	switch(info->fix.accel) {
@@ -210,14 +207,10 @@ void savagefb_create_i2c_busses(struct f
 
 void savagefb_delete_i2c_busses(struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
-	int (*del_bus)(struct i2c_adapter *) =
-		symbol_get(i2c_bit_del_bus);
-
-	if (del_bus && par->chan.par) {
-		del_bus(&par->chan.adapter);
-		symbol_put(i2c_bit_del_bus);
-	}
+	struct savagefb_par *par = info->par;
+
+	if (par->chan.par)
+		i2c_bit_del_bus(&par->chan.adapter);
 
 	par->chan.par = NULL;
 }
@@ -225,8 +218,6 @@ void savagefb_delete_i2c_busses(struct f
 static u8 *savage_do_probe_i2c_edid(struct savagefb_i2c_chan *chan)
 {
 	u8 start = 0x0;
-	int (*transfer)(struct i2c_adapter *, struct i2c_msg *, int) =
-		symbol_get(i2c_transfer);
 	struct i2c_msg msgs[] = {
 		{
 			.addr	= SAVAGE_DDC,
@@ -240,21 +231,19 @@ static u8 *savage_do_probe_i2c_edid(stru
 	};
 	u8 *buf = NULL;
 
-	if (transfer && chan->par) {
+	if (chan->par) {
 		buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
 
 		if (buf) {
 			msgs[1].buf = buf;
 
-			if (transfer(&chan->adapter, msgs, 2) != 2) {
+			if (i2c_transfer(&chan->adapter, msgs, 2) != 2) {
 				dev_dbg(&chan->par->pcidev->dev,
 					"Unable to read EDID block.\n");
 				kfree(buf);
 				buf = NULL;
 			}
 		}
-
-		symbol_put(i2c_transfer);
 	}
 
 	return buf;
diff --git a/drivers/video/savage/savagefb_accel.c b/drivers/video/savage/savagefb_accel.c
index bac8ea3..bbcc055 100644
--- a/drivers/video/savage/savagefb_accel.c
+++ b/drivers/video/savage/savagefb_accel.c
@@ -21,7 +21,7 @@ static u32 savagefb_rop[] = {
 
 int savagefb_sync(struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 
 	par->SavageWaitIdle(par);
 	return 0;
@@ -29,7 +29,7 @@ int savagefb_sync(struct fb_info *info)
 
 void savagefb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	int sx = region->sx, dx = region->dx;
 	int sy = region->sy, dy = region->dy;
 	int cmd;
@@ -63,7 +63,7 @@ void savagefb_copyarea(struct fb_info *i
 
 void savagefb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	int cmd, color;
 
 	if (!rect->width || !rect->height)
@@ -90,7 +90,7 @@ void savagefb_fillrect(struct fb_info *i
 
 void savagefb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	int fg, bg, size, i, width;
 	int cmd;
 	u32 *src = (u32 *) image->data;
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 09e2f28..baddd2b 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -686,7 +686,7 @@ static void savage_update_var(struct fb_
 static int savagefb_check_var (struct fb_var_screeninfo   *var,
 			       struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	int memlen, vramlen, mode_valid = 0;
 
 	DBG("savagefb_check_var");
@@ -1025,7 +1025,7 @@ static int savagefb_setcolreg(unsigned  
 			      unsigned        transp,
 			      struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 
 	if (regno >= NR_PALETTE)
 		return -EINVAL;
@@ -1328,7 +1328,7 @@ static void savagefb_set_fix(struct fb_i
 #if defined(CONFIG_FB_SAVAGE_ACCEL)
 static void savagefb_set_clip(struct fb_info *info)
 {
-    struct savagefb_par *par = (struct savagefb_par *)info->par;
+    struct savagefb_par *par = info->par;
     int cmd;
 
     cmd = BCI_CMD_NOP | BCI_CMD_CLIP_NEW;
@@ -1342,7 +1342,7 @@ static void savagefb_set_clip(struct fb_
 
 static int savagefb_set_par (struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	int err;
 
@@ -1381,7 +1381,7 @@ static int savagefb_set_par (struct fb_i
 static int savagefb_pan_display (struct fb_var_screeninfo *var,
 				 struct fb_info           *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	u_int y_bottom;
 
 	y_bottom = var->yoffset;
@@ -1534,7 +1534,7 @@ static void savage_disable_mmio (struct 
 
 static int __devinit savage_map_mmio (struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	DBG ("savage_map_mmio");
 
 	if (S3_SAVAGE3D_SERIES (par->chip))
@@ -1567,7 +1567,7 @@ static int __devinit savage_map_mmio (st
 
 static void __devinit savage_unmap_mmio (struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	DBG ("savage_unmap_mmio");
 
 	savage_disable_mmio(par);
@@ -1581,7 +1581,7 @@ static void __devinit savage_unmap_mmio 
 static int __devinit savage_map_video (struct fb_info *info,
 				       int video_len)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	int resource;
 
 	DBG("savage_map_video");
@@ -1619,7 +1619,7 @@ static int __devinit savage_map_video (s
 
 static void __devinit savage_unmap_video (struct fb_info *info)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 
 	DBG("savage_unmap_video");
 
@@ -1869,7 +1869,7 @@ static int __devinit savage_init_fb_info
 					  struct pci_dev *dev,
 					  const struct pci_device_id *id)
 {
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_par *par = info->par;
 	int err = 0;
 
 	par->pcidev  = dev;
@@ -2139,8 +2139,7 @@ static int __devinit savagefb_probe (str
 
 static void __devexit savagefb_remove (struct pci_dev *dev)
 {
-	struct fb_info *info =
-		(struct fb_info *)pci_get_drvdata(dev);
+	struct fb_info *info = pci_get_drvdata(dev);
 
 	DBG("savagefb_remove");
 
@@ -2174,9 +2173,8 @@ static void __devexit savagefb_remove (s
 
 static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
-	struct fb_info *info =
-		(struct fb_info *)pci_get_drvdata(dev);
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct fb_info *info = pci_get_drvdata(dev);
+	struct savagefb_par *par = info->par;
 
 	DBG("savagefb_suspend");
 
@@ -2210,9 +2208,8 @@ static int savagefb_suspend (struct pci_
 
 static int savagefb_resume (struct pci_dev* dev)
 {
-	struct fb_info *info =
-		(struct fb_info *)pci_get_drvdata(dev);
-	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct fb_info *info = pci_get_drvdata(dev);
+	struct savagefb_par *par = info->par;
 	int cur_state = par->pm_state;
 
 	DBG("savage_resume");



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
