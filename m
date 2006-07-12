From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] au1100fb.c startup sequence
Date: Wed, 12 Jul 2006 09:02:21 +0200
Message-ID: <20060712070221.GI5994@gundam.enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WHz+neNWvhIGAO8A"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0ela-0006Md-7P for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 06:28:38 -0700
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]
	helo=gundam.enneenne.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G0elZ-0001Rf-Hn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 06:28:38 -0700
Content-Disposition: inline
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
To: linux-mips@linux-mips.org
Cc: linux-fbdev-devel@lists.sourceforge.net


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch to fix up the start up sequence.

This new sequence allow you to correctly enable the LCD controller
even if the bootloader has already did it.

The patch also fixes up a wrong indentation issue.

Ciao,

Rodolfo


Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-startup-fix

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 1b9ad17..f9fcc65 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -167,7 +167,7 @@ int au1100fb_setmode(struct au1100fb_dev
 
 			info->fix.visual = FB_VISUAL_TRUECOLOR;
 			info->fix.line_length = info->var.xres_virtual << 1; /* depth=16 */
-	}
+		}
 	} else {
 		/* mono */
 		info->fix.visual = FB_VISUAL_MONO10;
@@ -180,16 +180,11 @@ int au1100fb_setmode(struct au1100fb_dev
 
 	/* Determine BPP mode and format */
 	fbdev->regs->lcd_control = fbdev->panel->control_base;
-
-	fbdev->regs->lcd_intenable = 0;
-	fbdev->regs->lcd_intstatus = 0;
-
 	fbdev->regs->lcd_horztiming = fbdev->panel->horztiming;
-
 	fbdev->regs->lcd_verttiming = fbdev->panel->verttiming;
-
 	fbdev->regs->lcd_clkcontrol = fbdev->panel->clkcontrol_base;
-
+	fbdev->regs->lcd_intenable = 0;
+	fbdev->regs->lcd_intstatus = 0;
 	fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(fbdev->fb_phys);
 
 	if (panel_is_dual(fbdev->panel)) {
@@ -217,7 +212,8 @@ int au1100fb_setmode(struct au1100fb_dev
 	fbdev->regs->lcd_pwmhi = 0;
 
 	/* Resume controller */
-	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
+	mdelay(10);
+	au1100fb_fb_blank(VESA_NO_BLANKING, info);
 
 	return 0;
 }

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--WHz+neNWvhIGAO8A--
