From: syrjala@sci.fi
Subject: [PATCH 1/8] atyfb: Reduce verbosity
Date: Thu, 17 Mar 2005 08:31:03 +0200 (EET)
Message-ID: <20050317063103.CF2D37A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBoXC-0006Fe-T2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:06 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBoXB-000495-4q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:06 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de

Don't complain about invalid modes when FB_ACTIVATE_TEST is used.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 16:44:26.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 16:46:41.000000000 +0200
@@ -109,8 +109,17 @@
 #define GUI_RESERVE	(1 * PAGE_SIZE)
 
 /* FIXME: remove the FAIL definition */
-#define FAIL(msg) do { printk(KERN_CRIT "atyfb: " msg "\n"); return -EINVAL; } while (0)
-#define FAIL_MAX(msg, x, _max_) do { if(x > _max_) { printk(KERN_CRIT "atyfb: " msg " %x(%x)\n", x, _max_); return -EINVAL; } } while (0)
+#define FAIL(msg) do {							\
+	if (!(var->activate & FB_ACTIVATE_TEST))			\
+		printk(KERN_CRIT "atyfb: " msg "\n");			\
+	return -EINVAL;							\
+} while (0)
+#define FAIL_MAX(msg, x, _max_) do {					\
+	if (!(var->activate & FB_ACTIVATE_TEST) && x > _max_) {		\
+		printk(KERN_CRIT "atyfb: " msg " %x(%x)\n", x, _max_);	\
+		return -EINVAL;						\
+	}								\
+} while (0)
 
 #ifdef DEBUG
 #define DPRINTK(fmt, args...)	printk(KERN_DEBUG "atyfb: " fmt, ## args)
@@ -840,7 +849,8 @@
 			   know if one is connected. So it's better to fail then.
 			 */
 			if (crtc->lcd_gen_cntl & CRT_ON) {
-				PRINTKI("Disable lcd panel, because video mode does not fit.\n");
+				if (!(var->activate & FB_ACTIVATE_TEST))
+					PRINTKI("Disable lcd panel, because video mode does not fit.\n");
 				crtc->lcd_gen_cntl &= ~LCD_ON;
 				/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
 			} else {
@@ -1198,7 +1208,8 @@
 		var->transp.length = 8;
 		break;
 	default:
-		FAIL("Invalid pixel width");
+		printk(KERN_CRIT "atyfb: Invalid pixel width\n");
+		return -EINVAL;
 	}
 
 	/* output */
@@ -1255,7 +1266,8 @@
 	pixclock = atyfb_get_pixclock(var, par);
 
 	if (pixclock == 0) {
-		FAIL("Invalid pixclock");
+		printk(KERN_CRIT "atyfb: Invalid pixclock\n");
+		return -EINVAL;
 	} else {
 		if((err = par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pixel, &par->pll)))
 			return err;
@@ -1460,7 +1472,9 @@
 	pixclock = atyfb_get_pixclock(var, par);
 
 	if (pixclock == 0) {
-		FAIL("Invalid pixclock");
+		if (!(var->activate & FB_ACTIVATE_TEST))
+			printk(KERN_CRIT "atyfb: Invalid pixclock\n");
+		return -EINVAL;
 	} else {
 		if((err = par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pixel, &pll)))
 			return err;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
