From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/10] pxafb: Add hsync time reporting hook
Date: Fri, 02 Sep 2005 05:41:20 +0800
Message-ID: <43177580.5080205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2g-0004lb-JM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:18 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2g-0004QB-0x
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:18 -0700
Received: by wproxy.gmail.com with SMTP id i22so261027wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:12 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard Purdie <rpurdie@rpsys.net>

    To solve touchscreen interference problems devices like the Sharp Zaurus
    SL-C3000 need to know the length of the horitzontal sync pulses. This
    patch adds a hook to pxafb so the touchscreen driver can function
    correctly.

    From: Richard Purdie <rpurdie@rpsys.net>
    Signed-Off-By: Richard Purdie <rpurdie@rpsys.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 drivers/video/pxafb.c            |   32 ++++++++++++++++++++++++++++++++
 drivers/video/pxafb.h            |    2 ++
 include/asm-arm/arch-pxa/pxafb.h |    1 +
 3 files changed, 35 insertions(+)


diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -468,6 +468,36 @@ static inline unsigned int get_pcd(unsig
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
@@ -631,6 +661,7 @@ static int pxafb_activate_var(struct fb_
 	fbi->reg_lccr1 = new_regs.lccr1;
 	fbi->reg_lccr2 = new_regs.lccr2;
 	fbi->reg_lccr3 = new_regs.lccr3;
+	set_hsync_time(fbi, pcd);
 	local_irq_restore(flags);
 
 	/*
@@ -907,6 +938,7 @@ pxafb_freq_transition(struct notifier_bl
 
 	case CPUFREQ_POSTCHANGE:
 		pcd = get_pcd(fbi->fb.var.pixclock);
+		set_hsync_time(fbi, pcd);
 		fbi->reg_lccr3 = (fbi->reg_lccr3 & ~0xff) | LCCR3_PixClkDiv(pcd);
 		set_ctrlr_state(fbi, C_ENABLE_CLKCHANGE);
 		break;
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -83,6 +83,8 @@ struct pxafb_info {
 	u_int			reg_lccr2;
 	u_int			reg_lccr3;
 
+	unsigned long	hsync_time;
+
 	volatile u_char		state;
 	volatile u_char		task_state;
 	struct semaphore	ctrlr_sem;
diff --git a/include/asm-arm/arch-pxa/pxafb.h b/include/asm-arm/arch-pxa/pxafb.h
--- a/include/asm-arm/arch-pxa/pxafb.h
+++ b/include/asm-arm/arch-pxa/pxafb.h
@@ -66,3 +66,4 @@ struct pxafb_mach_info {
 
 };
 void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
+unsigned long pxafb_get_hsync_time(struct device *dev);



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
