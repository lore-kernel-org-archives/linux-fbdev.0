From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] au1100fb.c info->var.rotate fix
Date: Wed, 12 Jul 2006 08:12:39 +0200
Message-ID: <20060712061239.GF5994@gundam.enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KJY2Ze80yH5MUxol"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0dvC-0001aA-5O for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 05:34:40 -0700
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]
	helo=gundam.enneenne.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G0dvA-0004ez-Hb
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 05:34:30 -0700
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


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a little patch to fix "info->var.rotate" data settings.

This info should be deduced directly from "fbdev->panel->control_base"
defined into au1100fb.h.

Ciao,

Rodolfo


Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-rotate

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index f492fe8..dc5a673 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -177,10 +177,11 @@ int au1100fb_setmode(struct au1100fb_dev
 	}
 
 	info->screen_size = info->fix.line_length * info->var.yres_virtual;
+	info->var.rotate = ((fbdev->panel->control_base&LCD_CONTROL_SM_MASK) \
+				>> LCD_CONTROL_SM_BIT) * 90;
 
 	/* Determine BPP mode and format */
-	fbdev->regs->lcd_control = fbdev->panel->control_base |
-			    ((info->var.rotate/90) << LCD_CONTROL_SM_BIT);
+	fbdev->regs->lcd_control = fbdev->panel->control_base;
 
 	fbdev->regs->lcd_intenable = 0;
 	fbdev->regs->lcd_intstatus = 0;

--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--KJY2Ze80yH5MUxol--
