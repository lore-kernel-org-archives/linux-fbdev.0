From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: vblank irq support
Date: Thu, 22 Jul 2004 21:49:37 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040722184937.GA11361@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BnidS-0001lG-D8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Jul 2004 11:49:42 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BnidR-0005Da-AN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Jul 2004 11:49:42 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 0BE004408B
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Jul 2004 21:49:38 +0300 (EEST)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds vblank interrupt support to atyfb. The added features are=
=20
FB_ACTIVATE_VBL flag for panning and FBIO_WAITFORVSYNC ioctl.

The code is basically copied from matroxfb. I've tested it on two laptops=
=20
(Mobility and LT Pro) using DirectFB.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-vblank_irq.patch"

diff -urN linux/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux/drivers/video/aty/atyfb.h	2004-06-18 01:14:39.000000000 +0300
+++ linux/drivers/video/aty/atyfb.h	2004-07-22 21:08:19.000000000 +0300
@@ -3,6 +3,8 @@
  */
 
 #include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
     /*
      *  Elements of the hardware specific atyfb_par structure
      */
@@ -33,6 +35,12 @@
 #endif
 };
 
+struct aty_interrupt {
+	wait_queue_head_t wait;
+	unsigned int count;
+	int pan_display;
+};
+
 struct pll_info {
 	int pll_max;
 	int pll_min;
@@ -142,8 +150,8 @@
 #ifdef __sparc__
 	struct pci_mmap_map *mmap_map;
 	u8 mmaped;
-	int open;
 #endif
+	int open;
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	unsigned long bios_base_phys;
 	unsigned long bios_base;
@@ -166,6 +174,10 @@
 #endif
 	unsigned long aux_start; /* auxiliary aperture */
 	unsigned long aux_size;
+	struct aty_interrupt vblank;
+	unsigned long irq_flags;
+	unsigned int irq;
+	spinlock_t int_lock;
 };
 
     /*
diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2004-06-18 01:14:39.000000000 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-07-22 21:26:36.633215432 +0300
@@ -62,6 +62,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1441,7 +1444,6 @@
 	u32 bpp = info->var.bits_per_pixel;
 
 	par->crtc.off_pitch = ((yoffset * vxres + xoffset) * bpp / 64) | (vxres << 19);
-	aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
 }
 
 
@@ -1451,26 +1453,103 @@
 
 static int atyfb_open(struct fb_info *info, int user)
 {
-#ifdef __sparc__
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
 	if (user) {
 		par->open++;
+#ifdef __sparc__
 		par->mmaped = 0;
-	}
 #endif
+	}
 	return (0);
 }
 
+static irqreturn_t aty_irq(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct atyfb_par *par = dev_id;
+	int handled = 0;
+	u32 int_cntl;
+
+	spin_lock(&par->int_lock);
+
+	int_cntl = aty_ld_le32(CRTC_INT_CNTL, par);
+
+	if (int_cntl & CRTC_VBLANK_INT) {
+		/* clear interrupt */
+		aty_st_le32(CRTC_INT_CNTL, (int_cntl & CRTC_INT_EN_MASK) | CRTC_VBLANK_INT_AK, par);
+		par->vblank.count++;
+		if (par->vblank.pan_display) {
+			par->vblank.pan_display = 0;
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+		}
+		wake_up_interruptible(&par->vblank.wait);
+		handled = 1;
+	}
+
+	spin_unlock(&par->int_lock);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int aty_enable_irq(struct atyfb_par *par, int reenable)
+{
+	u32 int_cntl;
+
+	if (!test_and_set_bit(0, &par->irq_flags)) {
+		if (request_irq(par->irq, aty_irq, SA_SHIRQ, "atyfb", par)) {
+			clear_bit(0, &par->irq_flags);
+			return -EINVAL;
+		}
+		spin_lock_irq(&par->int_lock);
+		int_cntl = aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		/* clear interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_AK, par);
+		/* enable interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN, par);
+		spin_unlock_irq(&par->int_lock);
+	} else if (reenable) {
+		spin_lock_irq(&par->int_lock);
+		int_cntl = aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		if (!(int_cntl & CRTC_VBLANK_INT_EN)) {
+			printk("atyfb: someone disabled IRQ [%08x]\n", int_cntl);
+			/* re-enable interrupt */
+			aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN, par );
+		}
+		spin_unlock_irq(&par->int_lock);
+	}
+
+	return 0;
+}
+
+static int aty_disable_irq(struct atyfb_par *par)
+{
+	u32 int_cntl;
+
+	if (test_and_clear_bit(0, &par->irq_flags)) {
+		if (par->vblank.pan_display) {
+			par->vblank.pan_display = 0;
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+		}
+		spin_lock_irq(&par->int_lock);
+		int_cntl = aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		/* disable interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl & ~CRTC_VBLANK_INT_EN, par );
+		spin_unlock_irq(&par->int_lock);
+		free_irq(par->irq, par);
+	}
+
+	return 0;
+}
+
 static int atyfb_release(struct fb_info *info, int user)
 {
-#ifdef __sparc__
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	if (user) {
 		par->open--;
 		mdelay(1);
 		wait_for_idle(par);
 		if (!par->open) {
+#ifdef __sparc__
 			int was_mmaped = par->mmaped;
 
 			par->mmaped = 0;
@@ -1495,9 +1574,10 @@
 						var.yres_virtual = var.yres;
 				}
 			}
+#endif
+			aty_disable_irq(par);
 		}
 	}
-#endif
 	return (0);
 }
 
@@ -1524,10 +1604,50 @@
 	info->var.yoffset = yoffset;
 	if (par->asleep)
 		return 0;
+
 	set_off_pitch(par, info);
+	if ((var->activate & FB_ACTIVATE_VBL) && !aty_enable_irq(par, 0)) {
+		par->vblank.pan_display = 1;
+	} else {
+		par->vblank.pan_display = 0;
+		aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+	}
+
+	return 0;
+}
+
+static int aty_waitforvblank(struct atyfb_par *par, u32 crtc)
+{
+	struct aty_interrupt *vbl;
+	unsigned int count;
+	int ret;
+
+	switch (crtc) {
+	case 0:
+		vbl = &par->vblank;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = aty_enable_irq(par, 0);
+	if (ret)
+		return ret;
+
+	count = vbl->count;
+	ret = wait_event_interruptible_timeout(vbl->wait, count != vbl->count, HZ/10);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret == 0) {
+		aty_enable_irq(par, 1);
+		return -ETIMEDOUT;
+	}
+
 	return 0;
 }
 
+
 #ifdef DEBUG
 #define ATYIO_CLKR		0x41545900	/* ATY\00 */
 #define ATYIO_CLKW		0x41545901	/* ATY\01 */
@@ -1552,12 +1672,14 @@
 #define ATYIO_FEATW		0x41545903	/* ATY\03 */
 #endif
 
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 	u_long arg, struct fb_info *info)
 {
-#if defined(__sparc__) || (defined(DEBUG) && defined(CONFIG_FB_ATY_CT))
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-#endif /* __sparc__ || DEBUG */
 #ifdef __sparc__
 	struct fbtype fbtyp;
 #endif
@@ -1575,6 +1697,18 @@
 			return -EFAULT;
 		break;
 #endif /* __sparc__ */
+
+	case FBIO_WAITFORVSYNC:
+		{
+			u32 crtc;
+
+			if (get_user(crtc, (__u32 *) arg))
+				return -EFAULT;
+
+			return aty_waitforvblank(par, crtc);
+		}
+		break;
+
 #if defined(DEBUG) && defined(CONFIG_FB_ATY_CT)
 	case ATYIO_CLKR:
 		if (M64_HAS(INTEGRATED)) {
@@ -1771,6 +1905,7 @@
 				info->var.yoffset = atyfb_save.yoffset;
 				set_off_pitch(par, info);
 			}
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
 			break;
 		}
 	}
@@ -2005,6 +2140,9 @@
 	int sense;
 #endif
 
+	init_waitqueue_head(&par->vblank.wait);
+	spin_lock_init(&par->int_lock);
+
 	par->aty_cmap_regs =
 	    (struct aty_cmap_regs *) (par->ati_regbase + 0xc0);
 
@@ -3207,6 +3345,8 @@
 	info->fix = atyfb_fix;
 	par->pci_id = aty_chips[i].pci_id;
 
+	par->irq = pdev->irq;
+
 	/* Reserve space */
 	par->res_start = rp->start;
 	par->res_size = rp->end - rp->start + 1;
@@ -3300,6 +3440,8 @@
 
 		info->fix = atyfb_fix;
 
+		par->irq = (unsigned int) -1; /* something invalid */
+
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
 		 *  kernel address space.
diff -urN linux/include/video/mach64.h linux/include/video/mach64.h
--- linux/include/video/mach64.h	2004-06-18 01:14:39.000000000 +0300
+++ linux/include/video/mach64.h	2004-07-13 19:52:39.000000000 +0300
@@ -630,10 +630,70 @@
 #define CRTC_CUR_B_TEST		0x80000000
 
 #define CRTC_CRNT_VLINE		0x07f00000
-#define CRTC_VBLANK		0x00000001
 
 #define CRTC_PRESERVED_MASK	0x0001f000
 
+#define CRTC_VBLANK		0x00000001
+#define CRTC_VBLANK_INT_EN	0x00000002
+#define CRTC_VBLANK_INT		0x00000004
+#define CRTC_VBLANK_INT_AK	CRTC_VBLANK_INT
+#define CRTC_VLINE_INT_EN	0x00000008
+#define CRTC_VLINE_INT		0x00000010
+#define CRTC_VLINE_INT_AK	CRTC_VLINE_INT
+#define CRTC_VLINE_SYNC		0x00000020
+#define CRTC_FRAME		0x00000040
+#define SNAPSHOT_INT_EN		0x00000080
+#define SNAPSHOT_INT		0x00000100
+#define SNAPSHOT_INT_AK		SNAPSHOT_INT
+#define I2C_INT_EN		0x00000200
+#define I2C_INT			0x00000400
+#define I2C_INT_AK		I2C_INT
+#define CRTC2_VBLANK		0x00000800
+#define CRTC2_VBLANK_INT_EN	0x00001000
+#define CRTC2_VBLANK_INT	0x00002000
+#define CRTC2_VBLANK_INT_AK	CRTC2_VBLANK_INT
+#define CRTC2_VLINE_INT_EN	0x00004000
+#define CRTC2_VLINE_INT		0x00008000
+#define CRTC2_VLINE_INT_AK	CRTC2_VLINE_INT
+#define CAPBUF0_INT_EN		0x00010000
+#define CAPBUF0_INT		0x00020000
+#define CAPBUF0_INT_AK		CAPBUF0_INT
+#define CAPBUF1_INT_EN		0x00040000
+#define CAPBUF1_INT		0x00080000
+#define CAPBUF1_INT_AK		CAPBUF1_INT
+#define OVERLAY_EOF_INT_EN	0x00100000
+#define OVERLAY_EOF_INT		0x00200000
+#define OVERLAY_EOF_INT_AK	OVERLAY_EOF_INT
+#define ONESHOT_CAP_INT_EN	0x00400000
+#define ONESHOT_CAP_INT		0x00800000
+#define ONESHOT_CAP_INT_AK	ONESHOT_CAP_INT
+#define BUSMASTER_EOL_INT_EN	0x01000000
+#define BUSMASTER_EOL_INT	0x02000000
+#define BUSMASTER_EOL_INT_AK	BUSMASTER_EOL_INT
+#define GP_INT_EN		0x04000000
+#define GP_INT			0x08000000
+#define GP_INT_AK		GP_INT
+#define CRTC2_VLINE_SYNC	0x10000000
+#define SNAPSHOT2_INT_EN	0x20000000
+#define SNAPSHOT2_INT		0x40000000
+#define SNAPSHOT2_INT_AK	SNAPSHOT2_INT
+#define VBLANK_BIT2_INT		0x80000000
+#define VBLANK_BIT2_INT_AK	VBLANK_BIT2_INT
+
+#define CRTC_INT_EN_MASK	(CRTC_VBLANK_INT_EN |	\
+				 CRTC_VLINE_INT_EN |	\
+				 SNAPSHOT_INT_EN |	\
+				 I2C_INT_EN |		\
+				 CRTC2_VBLANK_INT_EN |	\
+				 CRTC2_VLINE_INT_EN |	\
+				 CAPBUF0_INT_EN |	\
+				 CAPBUF1_INT_EN |	\
+				 OVERLAY_EOF_INT_EN |	\
+				 ONESHOT_CAP_INT_EN |	\
+				 BUSMASTER_EOL_INT_EN |	\
+				 GP_INT_EN |		\
+				 SNAPSHOT2_INT_EN)
+
 /* DAC control values */
 
 #define DAC_EXT_SEL_RS2		0x01

--4Ckj6UjgE2iN1+kY--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
