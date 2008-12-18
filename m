From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH] pxafb: additional check for 24bpp
Date: Thu, 18 Dec 2008 16:06:08 +0100
Message-ID: <1229612768-12651-1-git-send-email-l.fu@pengutronix.de>
References: <1229612737-12628-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <l.fu@pengutronix.de>) id 1LDKS6-0003dw-SS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 15:06:14 +0000
Received: from metis.ext.pengutronix.de ([92.198.50.35])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LDKS3-0005aV-P5
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 15:06:14 +0000
In-Reply-To: <1229612737-12628-1-git-send-email-l.fu@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, Luotao Fu <l.fu@pengutronix.de>

The pxa270 Manual reads: "NOTE: Configuring the LCD controller for 24bpp output
(BPP3.BPPto either 0b1001 or 0b1010) is invalid for panels without an internal
frame buffer (LCCR0[LCDT] clear) and will result in indeterminate behavior."
Add an additional check to make sure that only smartpanels can be configured
with 24bpp.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
 drivers/video/pxafb.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index b079f10..48dc565 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -370,6 +370,9 @@ static int pxafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		if (!mode)
 			return -EINVAL;
 
+		if (mode->depth > 19 && !(fbi->lccr0 & LCCR0_LCDT))
+			return -EINVAL;
+
 		switch (mode->depth) {
 		case 18: /* RGB666 */
 			var->transp.offset = var->transp.length     = 0;
@@ -887,8 +890,14 @@ static void pxafb_activate_var(struct fb_var_screeninfo *var,
 		case 4:
 		case 8:
 		case 16:
+			break;
 		case 24:
 		case 32:
+			if (var->red.length + var->green.length +
+					var->blue.length > 18)
+				printk(KERN_ERR "%s: 24bpp on pxafb is only"
+						"supported with smartpanel\n",
+						fbi->fb.fix.id);
 			break;
 		default:
 			printk(KERN_ERR "%s: invalid bit depth %d\n",
-- 
1.5.6.5


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
