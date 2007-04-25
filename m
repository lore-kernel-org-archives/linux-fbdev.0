From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/41] savagefb: VGA state save and
	restore
Date: Wed, 25 Apr 2007 14:19:09 +0800
Message-ID: <462EF2DD.1080600@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc4o-0000nC-2E for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:10 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc4m-0002jG-MK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:10 -0700
Received: by py-out-1112.google.com with SMTP id a29so116069pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:38:08 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Allow the saving and restoration of VGA text mode.  The state is saved on the
first open and restored on the last close. Because of the VGA registers are
linearly mapped to the MMIO space, MMIO access is used which is not limited to
X86 platforms nor to the primary display device.

An echo 0 > /sys/class/vtconsole/vtcon1/bind will convert the display from
graphics to text mode.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Makefile                 |    2 +-
 drivers/video/savage/savagefb.h        |   10 +++++++-
 drivers/video/savage/savagefb_driver.c |   39 ++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 13ab41b..4fa1529 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_FB_ATY128)		  += aty/ macmo
 obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/
 obj-$(CONFIG_FB_KYRO)             += kyro/
-obj-$(CONFIG_FB_SAVAGE)		  += savage/
+obj-$(CONFIG_FB_SAVAGE)		  += savage/ vgastate.o
 obj-$(CONFIG_FB_GEODE)		  += geode/
 obj-$(CONFIG_FB_MBX)		  += mbx/
 obj-$(CONFIG_FB_I810)             += vgastate.o
diff --git a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
index e648a6c..8bfdfc3 100644
--- a/drivers/video/savage/savagefb.h
+++ b/drivers/video/savage/savagefb.h
@@ -15,6 +15,8 @@ #define __SAVAGEFB_H__
 #include <linux/i2c.h>
 #include <linux/i2c-id.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/mutex.h>
+#include <video/vga.h>
 #include "../edid.h"
 
 #ifdef SAVAGEFB_DEBUG
@@ -189,8 +191,12 @@ struct savagefb_par {
 	struct savagefb_i2c_chan chan;
 	struct savage_reg state;
 	struct savage_reg save;
+	struct savage_reg initial;
+	struct vgastate vgastate;
+	struct mutex open_lock;
 	unsigned char   *edid;
 	u32 pseudo_palette[16];
+	u32 open_count;
 	int paletteEnabled;
 	int pm_state;
 	int display_type;
@@ -203,7 +209,7 @@ struct savagefb_par {
 	int clock[4];
 	int MCLK, REFCLK, LCDclk;
 	struct {
-		u8   __iomem *vbase;
+		void   __iomem *vbase;
 		u32    pbase;
 		u32    len;
 #ifdef CONFIG_MTRR
@@ -212,7 +218,7 @@ #endif
 	} video;
 
 	struct {
-		volatile u8  __iomem *vbase;
+		void  __iomem *vbase;
 		u32           pbase;
 		u32           len;
 	} mmio;
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 0166ec2..3d7507a 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1623,8 +1623,46 @@ static void savagefb_restore_state(struc
 	savagefb_blank(FB_BLANK_UNBLANK, info);
 }
 
+static int savagefb_open(struct fb_info *info, int user)
+{
+	struct savagefb_par *par = info->par;
+
+	mutex_lock(&par->open_lock);
+
+	if (!par->open_count) {
+		memset(&par->vgastate, 0, sizeof(par->vgastate));
+		par->vgastate.flags = VGA_SAVE_CMAP | VGA_SAVE_FONTS |
+			VGA_SAVE_MODE;
+		par->vgastate.vgabase = par->mmio.vbase + 0x8000;
+		save_vga(&par->vgastate);
+		savage_get_default_par(par, &par->initial);
+	}
+
+	par->open_count++;
+	mutex_unlock(&par->open_lock);
+	return 0;
+}
+
+static int savagefb_release(struct fb_info *info, int user)
+{
+	struct savagefb_par *par = info->par;
+
+	mutex_lock(&par->open_lock);
+
+	if (par->open_count == 1) {
+		savage_set_default_par(par, &par->initial);
+		restore_vga(&par->vgastate);
+	}
+
+	par->open_count--;
+	mutex_unlock(&par->open_lock);
+	return 0;
+}
+
 static struct fb_ops savagefb_ops = {
 	.owner          = THIS_MODULE,
+	.fb_open        = savagefb_open,
+	.fb_release     = savagefb_release,
 	.fb_check_var   = savagefb_check_var,
 	.fb_set_par     = savagefb_set_par,
 	.fb_setcolreg   = savagefb_setcolreg,
@@ -2173,6 +2211,7 @@ static int __devinit savagefb_probe(stru
 	if (!info)
 		return -ENOMEM;
 	par = info->par;
+	mutex_init(&par->open_lock);
 	err = pci_enable_device(dev);
 	if (err)
 		goto failed_enable;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
