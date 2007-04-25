From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/41] nvidiafb: VGA state save and
	restore
Date: Wed, 25 Apr 2007 14:17:09 +0800
Message-ID: <462EF265.7050607@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc4B-0000ih-5o for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:37:31 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc4A-0002Sk-OX
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:37:31 -0700
Received: by py-out-1112.google.com with SMTP id a29so115915pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:37:30 -0700 (PDT)
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
first open and restored on the last close. Because of the non-linear mapping
of the VGA registers to the MMIO space, this will be done only on X86
platforms where the device is the primary display.

An echo 0 > /sys/class/vtconsole/vtcon1/bind will convert the display from
graphics to text mode.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Makefile         |    2 +
 drivers/video/nvidia/nv_type.h |    6 +++
 drivers/video/nvidia/nvidia.c  |   74 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 3b24098..13ab41b 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
-obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
+obj-$(CONFIG_FB_NVIDIA)		  += nvidia/ vgastate.o
 obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_RADEON)		  += aty/
diff --git a/drivers/video/nvidia/nv_type.h b/drivers/video/nvidia/nv_type.h
index ee430af..38f7cc0 100644
--- a/drivers/video/nvidia/nv_type.h
+++ b/drivers/video/nvidia/nv_type.h
@@ -5,6 +5,8 @@ #include <linux/fb.h>
 #include <linux/types.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/mutex.h>
+#include <video/vga.h>
 
 #define NV_ARCH_04  0x04
 #define NV_ARCH_10  0x10
@@ -93,7 +95,10 @@ struct riva_regs {
 struct nvidia_par {
 	RIVA_HW_STATE SavedReg;
 	RIVA_HW_STATE ModeReg;
+	RIVA_HW_STATE initial_state;
 	RIVA_HW_STATE *CurrentState;
+	struct vgastate vgastate;
+	struct mutex open_lock;
 	u32 pseudo_palette[16];
 	struct pci_dev *pci_dev;
 	u32 Architecture;
@@ -141,6 +146,7 @@ struct nvidia_par {
 	int BlendingPossible;
 	u32 paletteEnabled;
 	u32 forceCRTC;
+	u32 open_count;
 	u8 DDCBase;
 #ifdef CONFIG_MTRR
 	struct {
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index c6afafc..6105753 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -949,8 +949,80 @@ static int nvidiafb_blank(int blank, str
 	return 0;
 }
 
+/*
+ * Because the VGA registers are not mapped linearly in its MMIO space,
+ * restrict VGA register saving and restore to x86 only, where legacy VGA IO
+ * access is legal. Consequently, we must also check if the device is the
+ * primary display.
+ */
+#ifdef CONFIG_X86
+static void save_vga_x86(struct nvidia_par *par)
+{
+	struct resource *res= &par->pci_dev->resource[PCI_ROM_RESOURCE];
+
+	if (res && res->flags & IORESOURCE_ROM_SHADOW) {
+		memset(&par->vgastate, 0, sizeof(par->vgastate));
+		par->vgastate.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS |
+			VGA_SAVE_CMAP;
+		save_vga(&par->vgastate);
+	}
+}
+
+static void restore_vga_x86(struct nvidia_par *par)
+{
+	struct resource *res= &par->pci_dev->resource[PCI_ROM_RESOURCE];
+
+	if (res && res->flags & IORESOURCE_ROM_SHADOW)
+		restore_vga(&par->vgastate);
+}
+#else
+#define save_vga_x86(x) do {} while (0)
+#define restore_vga_x86(x) do {} while (0)
+#endif /* X86 */
+
+static int nvidiafb_open(struct fb_info *info, int user)
+{
+	struct nvidia_par *par = info->par;
+
+	mutex_lock(&par->open_lock);
+
+	if (!par->open_count) {
+		save_vga_x86(par);
+		nvidia_save_vga(par, &par->initial_state);
+	}
+
+	par->open_count++;
+	mutex_unlock(&par->open_lock);
+	return 0;
+}
+
+static int nvidiafb_release(struct fb_info *info, int user)
+{
+	struct nvidia_par *par = info->par;
+	int err = 0;
+
+	mutex_lock(&par->open_lock);
+
+	if (!par->open_count) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (par->open_count == 1) {
+		nvidia_write_regs(par, &par->initial_state);
+		restore_vga_x86(par);
+	}
+
+	par->open_count--;
+done:
+	mutex_unlock(&par->open_lock);
+	return 0;
+}
+
 static struct fb_ops nvidia_fb_ops = {
 	.owner          = THIS_MODULE,
+	.fb_open        = nvidiafb_open,
+	.fb_release     = nvidiafb_release,
 	.fb_check_var   = nvidiafb_check_var,
 	.fb_set_par     = nvidiafb_set_par,
 	.fb_setcolreg   = nvidiafb_setcolreg,
@@ -1208,7 +1280,7 @@ static int __devinit nvidiafb_probe(stru
 
 	par = info->par;
 	par->pci_dev = pd;
-
+	mutex_init(&par->open_lock);
 	info->pixmap.addr = kzalloc(8 * 1024, GFP_KERNEL);
 
 	if (info->pixmap.addr == NULL)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
