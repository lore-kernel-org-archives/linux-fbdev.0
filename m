From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 02 Mar 2005 14:42:13 +0000
Message-ID: <1109774533.18009.4.camel@atlantis.netenviron.com>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <1109747415.5611.92.camel@gaston>  <20050302073027.GA17607@sci.fi>
	 <1109750012.5611.98.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vEC3VFjPaBs8lr/9Id9l"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6V3N-0008P8-0J
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 06:42:21 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6V3J-0004DK-Kk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 06:42:20 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 3E4C3D3
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  2 Mar 2005 09:42:13 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 8558387
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  2 Mar 2005 09:42:12 -0500 (EST)
In-Reply-To: <1109750012.5611.98.camel@gaston>
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
To: linux-fbdev-devel@lists.sourceforge.net


--=-vEC3VFjPaBs8lr/9Id9l
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-02 at 18:53 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-02 at 09:30 +0200, Ville Syrj=E4l=E4 wrote:
> > On Wed, Mar 02, 2005 at 06:10:14PM +1100, Benjamin Herrenschmidt wrot=
e:
> > > On Wed, 2005-03-02 at 00:50 -0500, Jon Smirl wrote:
> > > > For the r128 driver both the fbdev and drm drivers have implement=
ed
> > > > waitforVBlank and they both play with the interrupt registers. I =
can
> > > > only assume that no one has ever tried to use them at the same ti=
me.
> > > > In the radeon case the DRM driver has implemented waitforVBlank a=
nd
> > > > the fbdev driver has not.
> > > >=20
> > > > This is a mess and it is yet another reason for merging DRM and f=
bdev
> > > > into a sane, combined driver.
> > >=20
> > > I'd say nobody ever used both :)
> >=20
> > I (and others) have with mga. The easiest solution was to disable the=
 irq=20
> > code in the drm. That was for running OpenGL on DirectFB btw.
>=20
> I'd rather have disabled the IRQ code in the fbdev and added a
> waitForVBlank in the DRM ...

That doesn't help when you need it for a DirectFB application..

I've been trying to implement wait-for-vsync irq support in the radeonfb
driver, using the patch for the mga and the code in the dri driver as a
base, but am having some basic problems actually getting request_irq to
succeed. My test setup is a radeon QD, and the bios assigns it an
interrupt. I dont have the dri driver loaded.

Maybe someone with a little more kernel experience can help me spot the
problem. Attached is a patch against kernel 2.6.11.


--=20
Torgeir Veimo <torgeir@pobox.com>

--=-vEC3VFjPaBs8lr/9Id9l
Content-Disposition: attachment; filename=radeon-irq.patch
Content-Type: text/x-patch; name=radeon-irq.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.11-orig/drivers/video/aty/radeon_base.c	2005-03-02 13:25:16.000000000 +0000
+++ linux-2.6.11/drivers/video/aty/radeon_base.c	2005-03-02 12:13:13.000000000 +0000
@@ -68,6 +68,9 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -863,6 +885,108 @@
 }
 
 
+static irqreturn_t radeon_irq(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct radeonfb_info *rinfo = dev_id;
+	int handled = 0;
+	u32 int_cntl;
+
+	spin_lock(&rinfo->int_lock);
+
+        int_cntl = INREG(GEN_INT_CNTL);
+
+	if (int_cntl & CRTC_VBLANK_MASK) {
+		/* clear interrupt */
+                OUTREG(GEN_INT_CNTL, (int_cntl & CRTC_VBLANK_STAT_ACK) | CRTC_VBLANK_STAT_ACK);
+		rinfo->vblank.count++;
+		wake_up_interruptible(&rinfo->vblank.wait);
+		handled = 1;
+	}
+
+	spin_unlock(&rinfo->int_lock);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int radeon_enable_irq(struct radeonfb_info *rinfo, int reenable)
+{
+	u32 int_cntl;
+
+	if (!test_and_set_bit(0, &rinfo->irq_flags)) {
+		if (request_irq(rinfo->irq, radeon_irq, SA_SHIRQ, "radeonfb", rinfo)) {
+			printk("radeonfb: request_irq failed..\n");
+			clear_bit(0, &rinfo->irq_flags);
+			return -EINVAL;
+		}
+		spin_lock_irq(&rinfo->int_lock);
+                int_cntl = INREG(GEN_INT_CNTL) & CRTC_INT_EN_MASK;
+		/* clear interrupt */
+                OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_STAT_ACK);
+		/* enable interrupt */
+                OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN);
+		spin_unlock_irq(&rinfo->int_lock);
+		printk("radeonfb: enabled IRQ\n");
+	} else if (reenable) {
+		spin_lock_irq(&rinfo->int_lock);
+                int_cntl = INREG(GEN_INT_CNTL) & CRTC_INT_EN_MASK;
+		if (!(int_cntl & CRTC_VBLANK_INT_EN)) {
+			printk("radeonfb: someone disabled IRQ [%08x]\n", int_cntl);
+			/* re-enable interrupt */
+                        OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN);
+		}
+		spin_unlock_irq(&rinfo->int_lock);
+	}
+
+	return 0;
+}
+
+static int radeon_disable_irq(struct radeonfb_info *rinfo)
+{
+	u32 int_cntl;
+
+	if (test_and_clear_bit(0, &rinfo->irq_flags)) {
+		spin_lock_irq(&rinfo->int_lock);
+                                
+                int_cntl = INREG(GEN_INT_CNTL) & CRTC_INT_EN_MASK;
+		/* disable interrupt */
+                OUTREG(GEN_INT_CNTL, int_cntl & ~CRTC_VBLANK_INT_EN);
+		spin_unlock_irq(&rinfo->int_lock);
+		free_irq(rinfo->irq, rinfo);
+		printk("radeonfb: disabled IRQ\n");
+	}
+
+	return 0;
+}
+
+static int radeon_waitforvblank(struct radeonfb_info *rinfo)
+{
+	struct radeon_interrupt *vbl;
+	unsigned int count;
+	int ret;
+
+        vbl = &rinfo->vblank;
+
+	ret = radeon_enable_irq(rinfo, 0);
+	if (ret)
+		return ret;
+
+	count = vbl->count;
+	ret = wait_event_interruptible_timeout(vbl->wait, count != vbl->count, HZ/10);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret == 0) {
+		radeon_enable_irq(rinfo, 1);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
 static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
                            unsigned long arg, struct fb_info *info)
 {
@@ -927,6 +1051,11 @@
 				value |= 0x02;
 
 			return put_user(value, (__u32 __user *)arg);
+		case FBIO_WAITFORVSYNC:
+			printk("radeonfb: waitforvblank..\n");
+			return radeon_waitforvblank(rinfo);
+			//return 0;
+                        
 		default:
 			return -EINVAL;
 	}
@@ -1464,6 +1593,30 @@
 	RTRACE("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
 }
 
+static int radeonfb_open(struct fb_info *info, int user)
+{
+      struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+      if (user) {
+              rinfo->open++;
+      }
+      return (0);
+}
+
+static int radeonfb_release(struct fb_info *info, int user)
+{
+      struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+      if (user) {
+              rinfo->open--;
+              mdelay(1);
+              //wait_for_idle(rinfo);
+              if (!rinfo->open) {
+                      radeon_disable_irq(rinfo);
+              }
+      }
+      return (0);
+}
+
+
 static int radeonfb_set_par(struct fb_info *info)
 {
 	struct radeonfb_info *rinfo = info->par;
@@ -1788,6 +1941,8 @@
 
 static struct fb_ops radeonfb_ops = {
 	.owner			= THIS_MODULE,
+        .fb_open	        = radeonfb_open,
+	.fb_release	        = radeonfb_release,        
 	.fb_check_var		= radeonfb_check_var,
 	.fb_set_par		= radeonfb_set_par,
 	.fb_setcolreg		= radeonfb_setcolreg,
@@ -2338,6 +2494,8 @@
 	radeon_create_i2c_busses(rinfo);
 #endif
 
+	rinfo->irq_flags = 0;
+
 	/* set all the vital stuff */
 	radeon_set_fbinfo (rinfo);
 
--- linux-2.6.11-orig/drivers/video/aty/radeonfb.h	2005-03-02 13:25:16.000000000 +0000
+++ linux-2.6.11/drivers/video/aty/radeonfb.h	2005-02-26 23:17:18.000000000 +0000
@@ -269,6 +269,11 @@
 	radeon_pm_off	= 0x00000002,	/* Can resume from D3 cold */
 };
 
+struct radeon_interrupt {
+	wait_queue_head_t wait;
+	unsigned int count;
+};
+
 struct radeonfb_info {
 	struct fb_info		*info;
 
@@ -344,6 +349,12 @@
 	struct timer_list	lvds_timer;
 	u32			pending_lvds_gen_cntl;
 
+	int			open;
+	struct radeon_interrupt	vblank;
+	unsigned long		irq_flags;
+	unsigned int		irq;
+	spinlock_t		int_lock;
+
 #ifdef CONFIG_FB_RADEON_I2C
 	struct radeon_i2c_chan 	i2c[4];
 #endif
--- linux-2.6.11-orig/include/video/radeon.h	2005-03-02 07:38:33.000000000 +0000
+++ linux-2.6.11/include/video/radeon.h	2005-02-26 23:22:56.000000000 +0000
@@ -541,6 +541,34 @@
 #define CRTC_EN					   (1 << 25)
 #define CRTC_DISP_REQ_EN_B                         (1 << 26)
 
+#define GEN_INT_CNTL                           0x0040
+#define GEN_INT_STATUS                         0x0044
+
+/* GEN_INT_CNTL bit constants */
+#define CRTC_VBLANK_MASK          (1 << 0)
+#define CRTC_VBLANK_INT_EN        (1 << 0)
+#define FP_DETECT_ENABLE          (1 << 4)
+#define FP2_DETECT_ENABLE         (1 << 10)
+#define GUI_IDLE_INT_ENABLE       (1 << 19)
+#define SW_INT_ENABLE             (1 << 25)
+
+/* GEN_INT_STATUS bit constants */
+#define CRTC_VBLANK_STAT          (1 << 0)
+#define CRTC_VBLANK_STAT_ACK      (1 << 0)
+#define FP_DETECT_STAT            (1 << 4)
+#define FP_DETECT_ACK             (1 << 4)
+#define FP2_DETECT_STAT           (1 << 10)
+#define FP2_DETECT_ACK            (1 << 10)
+#define GUI_IDLE_INT_TEST_ACK     (1 << 19)
+#define SW_INT_TEST               (1 << 25)
+#define SW_INT_TEST_ACK           (1 << 25)
+
+#define CRTC_INT_EN_MASK       (CRTC_VBLANK_MASK |     \
+				FP_DETECT_ENABLE |     \
+				FP2_DETECT_ENABLE |    \
+				GUI_IDLE_INT_ENABLE |  \
+				SW_INT_ENABLE)
+
 /* CRTC_STATUS bit constants */
 #define CRTC_VBLANK                                0x00000001
 

--=-vEC3VFjPaBs8lr/9Id9l--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
