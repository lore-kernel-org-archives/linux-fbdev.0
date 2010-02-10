From: "Phil Edworthy" <Phil.Edworthy@renesas.com>
Date: Wed, 10 Feb 2010 15:00:14 +0000
Subject: [PATCH] sh: Add wait for vsync ioctl
Message-Id: <AB12B32E73474741A2C5361C433A44DE017832D3@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Added FBIO_WAITFORVSYNC ioctl for SH-Mobile devices. Tested on MS7724 board
against 2.6.33-rc7

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
+#include <linux/ioctl.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/atomic.h>
 
@@ -40,6 +41,10 @@
 #define _LDDWAR 0x900
 #define _LDDRAR 0x904
 
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
 /* shared registers and their order for context save/restore */
 static int lcdc_shared_regs[] = {
 	_LDDCKR,
@@ -106,6 +111,7 @@
 #define LDRCNTR_SRC	0x00010000
 #define LDRCNTR_MRS	0x00000002
 #define LDRCNTR_MRC	0x00000001
+#define LDSR_MRS    0x00000100
 
 struct sh_mobile_lcdc_priv;
 struct sh_mobile_lcdc_chan {
@@ -124,6 +130,8 @@
 	unsigned long pan_offset;
 	unsigned long new_pan_offset;
 	wait_queue_head_t frame_end_wait;
+	unsigned long seen_vsync;
+	wait_queue_head_t wait_vsync;
 };
 
 struct sh_mobile_lcdc_priv {
@@ -367,17 +375,22 @@
 
 		/* VSYNC End */
 		if (ldintr & LDINTR_VES) {
-			unsigned long ldrcntr = lcdc_read(priv, _LDRCNTR);
-			/* Set the source address for the next refresh */
-			lcdc_write_chan_mirror(ch, LDSA1R, ch->dma_handle +
-					       ch->new_pan_offset);
-			if (lcdc_chan_is_sublcd(ch))
-				lcdc_write(ch->lcdc, _LDRCNTR,
-					   ldrcntr ^ LDRCNTR_SRS);
-			else
-				lcdc_write(ch->lcdc, _LDRCNTR,
-					   ldrcntr ^ LDRCNTR_MRS);
-			ch->pan_offset = ch->new_pan_offset;
+			if (ch->pan_offset != ch->new_pan_offset) {
+				unsigned long ldrcntr = lcdc_read(priv,
_LDRCNTR);
+				/* Set the source address for the next
refresh */
+				lcdc_write_chan_mirror(ch, LDSA1R,
ch->dma_handle +
+
ch->new_pan_offset);
+				if (lcdc_chan_is_sublcd(ch))
+					lcdc_write(ch->lcdc, _LDRCNTR,
+						   ldrcntr ^ LDRCNTR_SRS);
+				else
+					lcdc_write(ch->lcdc, _LDRCNTR,
+						   ldrcntr ^ LDRCNTR_MRS);
+				ch->pan_offset = ch->new_pan_offset;
+			}
+
+			ch->seen_vsync = 1;
+			wake_up(&ch->wait_vsync);
 		}
 	}
 
@@ -786,6 +799,48 @@
 	return 0;
 }
 
+static int sh_mobile_wait_for_vsync(struct fb_info *info)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	unsigned long ldintr;
+	int ret;
+
+	ch->seen_vsync = 0;
+
+	/* Enable VSync End interrupt */
+	ldintr = lcdc_read(ch->lcdc, _LDINTR);
+	ldintr |= LDINTR_VEE;
+	lcdc_write(ch->lcdc, _LDINTR, ldintr);
+
+	ret = wait_event_interruptible_timeout(ch->wait_vsync,
+					       ch->seen_vsync,
+					       HZ / 10);
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
+		       unsigned long arg)
+{
+	int retval = -EFAULT;
+
+	switch (cmd) {
+	case FBIO_WAITFORVSYNC:
+		{
+			retval = sh_mobile_wait_for_vsync(info);
+			break;
+		}
+
+	default:
+		retval = -ENOIOCTLCMD;
+		break;
+	}
+	return retval;
+}
+
+
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
@@ -795,6 +850,8 @@
 	.fb_copyarea	= sh_mobile_lcdc_copyarea,
 	.fb_imageblit	= sh_mobile_lcdc_imageblit,
 	.fb_pan_display = sh_mobile_fb_pan_display,
+	.fb_ioctl       = sh_mobile_ioctl,
+	.fb_compat_ioctl = sh_mobile_ioctl
 };
 
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
@@ -962,6 +1019,7 @@
 			goto err1;
 		}
 		init_waitqueue_head(&priv->ch[i].frame_end_wait);
+		init_waitqueue_head(&priv->ch[i].wait_vsync);
 		priv->ch[j].pan_offset = 0;
 		priv->ch[j].new_pan_offset = 0;

