From: Torgeir Veimo <torgeir@pobox.com>
Subject: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 14:06:45 +0000
Message-ID: <1110636406.5997.86.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OHmkxlttZKggYm6A5hU+"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA7GW-0006oP-8q
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 06:06:52 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DA7GU-0001qh-GC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 06:06:52 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 8401F5D
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 09:06:43 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id DA81B8B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 09:06:42 -0500 (EST)
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


--=-OHmkxlttZKggYm6A5hU+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is an implementation of the FB_WAITFORVSYNC ioctl for the radeonfb.
A small test application is attached at the end. This patch is against
vanilla 2.6.11.

Signed-off-by: Torgeir Veimo <torgeir@pobox.com>


-- 
Torgeir Veimo <torgeir@pobox.com>

--=-OHmkxlttZKggYm6A5hU+
Content-Disposition: attachment; filename=vsynctest.c
Content-Type: text/x-csrc; name=vsynctest.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <strings.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/ioctl.h>

#define __u32 u_int32_t

#ifndef FBIO_WAITFORVSYNC
#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
#endif

/* check functionality of VSYNC ioctl & determine approximate vertical refresh frequency */
/* compile with gcc -o vsynctest vsynctest.c */
/* March 12th, 2005, torgeir at nothome dot com. */

int main(int argc, char** argv) {
    int retval = 0;
    int fd = 0;
    int zero = 0;
	int i;
    struct timeval start;
	struct timeval end;
	long total; float secs; float rate;
	
    printf("testing refresh rate using FB_WAITFORVSYNC ioctl, standby while i loop 500 times..\n");
    if ((fd = open( "/dev/fb0", O_RDWR )) < 0) {
		printf("unable to access /dev/fb0, exiting..\n");
		exit(1);
	}
	
	gettimeofday(&start, NULL);

	for (i = 0; i < 500; i++) {
		retval = ioctl(fd, FBIO_WAITFORVSYNC, &zero);	
		if (retval != 0) {
			printf("ioctl failed, aborting...\n");
			exit(1);
		}			
	}
	gettimeofday(&end, NULL);
	
	total = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_usec - start.tv_usec);
	secs = total / 1000000.0;
	rate = 500000000.0 / total;
    printf("time elapsed: %2.2f secs, refresh rate is %2.2f Hz\n", secs, rate);

    close( fd );
}

--=-OHmkxlttZKggYm6A5hU+
Content-Disposition: attachment; filename=irq.patch
Content-Type: text/x-patch; name=irq.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.11-orig/include/video/radeon.h	2005-03-02 07:38:33.000000000 +0000
+++ linux-2.6.11/include/video/radeon.h	2005-03-12 13:50:35.000000000 +0000
@@ -541,6 +541,14 @@
 #define CRTC_EN					   (1 << 25)
 #define CRTC_DISP_REQ_EN_B                         (1 << 26)
 
+/* GEN_INT_CNTL bit constants */
+#define CRTC_VBLANK_MASK          (1 << 0)
+#define CRTC_VBLANK_INT_EN        (1 << 0)
+
+/* GEN_INT_STATUS bit constants */
+#define CRTC_VBLANK_STAT          (1 << 0)
+#define CRTC_VBLANK_STAT_ACK      (1 << 0)
+
 /* CRTC_STATUS bit constants */
 #define CRTC_VBLANK                                0x00000001
 
--- linux-2.6.11-orig/drivers/video/aty/radeonfb.h	2005-03-02 07:38:37.000000000 +0000
+++ linux-2.6.11/drivers/video/aty/radeonfb.h	2005-03-03 17:09:23.000000000 +0000
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
 
@@ -344,6 +349,11 @@
 	struct timer_list	lvds_timer;
 	u32			pending_lvds_gen_cntl;
 
+	int			open;
+	struct radeon_interrupt	vblank;
+	unsigned long		irq_flags;
+	spinlock_t		int_lock;
+
 #ifdef CONFIG_FB_RADEON_I2C
 	struct radeon_i2c_chan 	i2c[4];
 #endif
--- linux-2.6.11-orig/drivers/video/aty/radeon_base.c	2005-03-02 07:37:54.000000000 +0000
+++ linux-2.6.11/drivers/video/aty/radeon_base.c	2005-03-12 13:53:32.000000000 +0000
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
@@ -863,6 +866,97 @@
 }
 
 
+static irqreturn_t radeon_irq(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct radeonfb_info *rinfo = dev_id;
+	u32 int_cntl = 0;
+	u32 stat = 0;
+
+	int_cntl = INREG(GEN_INT_CNTL);
+	stat = INREG(GEN_INT_STATUS) & (CRTC_VBLANK_MASK); 
+	if (!stat)
+		return IRQ_NONE;
+	if (stat) {
+		/* clear interrupt */
+		OUTREG(GEN_INT_STATUS, stat);
+
+		(rinfo->vblank.count)++;
+		wake_up_interruptible(&rinfo->vblank.wait);
+	}
+	return IRQ_HANDLED;
+}
+
+static int radeon_enable_irq(struct radeonfb_info *rinfo, int reenable)
+{
+	u32 int_cntl;
+
+	if (!test_and_set_bit(0, &rinfo->irq_flags)) {
+		if (request_irq(rinfo->pdev->irq, radeon_irq, SA_SHIRQ, 
+			"radeonfb", rinfo)) {
+			printk("radeonfb: request_irq failed..\n");
+			clear_bit(0, &rinfo->irq_flags);
+			return -EINVAL;
+		}
+		int_cntl = INREG(GEN_INT_CNTL) & CRTC_VBLANK_MASK;
+		/* clear interrupt */
+		//OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_STAT_ACK);
+		/* enable interrupt */
+		OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN);
+		printk("radeonfb: enabled IRQ\n");
+	} else if (reenable) {
+		int_cntl = INREG(GEN_INT_CNTL) & CRTC_VBLANK_MASK;
+		if (!(int_cntl & CRTC_VBLANK_INT_EN)) {
+			printk("radeonfb: someone disabled IRQ [%08x]\n", int_cntl);
+			/* re-enable interrupt */
+			OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN);
+		}
+	}
+
+	return 0;
+}
+
+static void radeon_disable_irq(struct radeonfb_info *rinfo)
+{
+	u32 int_cntl;
+
+	if (test_and_clear_bit(0, &rinfo->irq_flags)) {
+		int_cntl = INREG(GEN_INT_CNTL) & CRTC_VBLANK_MASK;
+		/* disable interrupt */
+		OUTREG(GEN_INT_CNTL, int_cntl & ~CRTC_VBLANK_INT_EN);
+		free_irq(rinfo->pdev->irq, rinfo);
+		printk("radeonfb: disabled IRQ\n");
+	}
+}
+
+static int radeon_waitforvblank(struct radeonfb_info *rinfo)
+{
+	struct radeon_interrupt *vbl;
+	unsigned int count;
+	int ret;
+
+	vbl = &rinfo->vblank;
+
+	ret = radeon_enable_irq(rinfo, 0);
+	if (ret) {
+		return ret;
+	}
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
@@ -927,6 +1021,8 @@
 				value |= 0x02;
 
 			return put_user(value, (__u32 __user *)arg);
+		case FBIO_WAITFORVSYNC:
+			return radeon_waitforvblank(rinfo);
 		default:
 			return -EINVAL;
 	}
@@ -1464,6 +1560,30 @@
 	RTRACE("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
 }
 
+static int radeonfb_open(struct fb_info *info, int user)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+	if (user) {
+		rinfo->open++;
+	}
+	return (0);
+}
+
+static int radeonfb_release(struct fb_info *info, int user)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+	if (user) {
+		rinfo->open--;
+		mdelay(1);
+		//wait_for_idle(rinfo);
+		if (!rinfo->open) {
+			radeon_disable_irq(rinfo);
+		}
+	}
+	return (0);
+}
+
+
 static int radeonfb_set_par(struct fb_info *info)
 {
 	struct radeonfb_info *rinfo = info->par;
@@ -1788,6 +1908,8 @@
 
 static struct fb_ops radeonfb_ops = {
 	.owner			= THIS_MODULE,
+	.fb_open	        = radeonfb_open,
+	.fb_release	        = radeonfb_release,        
 	.fb_check_var		= radeonfb_check_var,
 	.fb_set_par		= radeonfb_set_par,
 	.fb_setcolreg		= radeonfb_setcolreg,
@@ -2338,6 +2460,10 @@
 	radeon_create_i2c_busses(rinfo);
 #endif
 
+	rinfo->irq_flags = 0;
+	init_waitqueue_head(&rinfo->vblank.wait);
+	spin_lock_init(&(rinfo->int_lock));
+
 	/* set all the vital stuff */
 	radeon_set_fbinfo (rinfo);

--=-OHmkxlttZKggYm6A5hU+--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
