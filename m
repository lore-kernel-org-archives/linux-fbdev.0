From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch] pxafb: Add hsync time reporting hook
Date: Wed, 31 Aug 2005 12:33:34 +0100
Message-ID: <1125488014.8298.5.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAQqh-0005sZ-5R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Aug 2005 04:33:47 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EAQqg-0006pZ-IC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Aug 2005 04:33:47 -0700
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: FB-Dev <linux-fbdev-devel@lists.sourceforge.net>

To solve touchscreen interference problems devices like the Sharp Zaurus
SL-C3000 need to know the length of the horitzontal sync pulses. This
patch adds a hook to pxafb so the touchscreen driver can function
correctly.

Signed-Off-By: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/video/pxafb.c
===================================================================
--- linux-2.6.12.orig/drivers/video/pxafb.c	2005-08-25 11:46:09.000000000 +0100
+++ linux-2.6.12/drivers/video/pxafb.c	2005-08-25 11:59:22.000000000 +0100
@@ -468,6 +468,36 @@
 }
 
 /*
+ * Some touchscreens need hsync information from the video driver to
+ * function correctly. We export it here.
+ */
+static inline void set_hsync_time(struct pxafb_info *fbi, unsigned int pcd)
+{
+	unsigned long long htime;
+
+	if ((pcd == 0) || (fbi->fb.var.hsync_len == 0)) {
+		fbi->hsync_time=0;
+		return;
+	}
+
+	htime = (unsigned long long)get_lcdclk_frequency_10khz() * 10000;
+	do_div(htime, pcd * fbi->fb.var.hsync_len);
+	fbi->hsync_time = htime;
+}
+
+unsigned long pxafb_get_hsync_time(struct device *dev)
+{
+	struct pxafb_info *fbi = dev_get_drvdata(dev);
+
+	/* If display is blanked/suspended, hsync isn't active */
+	if (!fbi || (fbi->state != C_ENABLE))
+		return 0;
+
+	return fbi->hsync_time;
+}
+EXPORT_SYMBOL(pxafb_get_hsync_time);
+
+/*
  * pxafb_activate_var():
  *	Configures LCD Controller based on entries in var parameter.  Settings are
  *	only written to the controller if changes were made.
@@ -631,6 +661,7 @@
 	fbi->reg_lccr1 = new_regs.lccr1;
 	fbi->reg_lccr2 = new_regs.lccr2;
 	fbi->reg_lccr3 = new_regs.lccr3;
+	set_hsync_time(fbi, pcd);
 	local_irq_restore(flags);
 
 	/*
@@ -901,6 +932,7 @@
 
 	case CPUFREQ_POSTCHANGE:
 		pcd = get_pcd(fbi->fb.var.pixclock);
+		set_hsync_time(fbi, pcd);
 		fbi->reg_lccr3 = (fbi->reg_lccr3 & ~0xff) | LCCR3_PixClkDiv(pcd);
 		set_ctrlr_state(fbi, C_ENABLE_CLKCHANGE);
 		break;
Index: linux-2.6.12/include/asm-arm/arch-pxa/pxafb.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/arch-pxa/pxafb.h	2005-08-25 11:45:49.000000000 +0100
+++ linux-2.6.12/include/asm-arm/arch-pxa/pxafb.h	2005-08-25 11:46:41.000000000 +0100
@@ -66,3 +66,4 @@
 
 };
 void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
+unsigned long pxafb_get_hsync_time(struct device *dev);
Index: linux-2.6.12/drivers/video/pxafb.h
===================================================================
--- linux-2.6.12.orig/drivers/video/pxafb.h	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.12/drivers/video/pxafb.h	2005-08-25 11:51:03.000000000 +0100
@@ -83,6 +83,8 @@
 	u_int			reg_lccr2;
 	u_int			reg_lccr3;
 
+	unsigned long	hsync_time;
+
 	volatile u_char		state;
 	volatile u_char		task_state;
 	struct semaphore	ctrlr_sem;




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
