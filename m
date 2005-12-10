From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/18] atyfb: Reduce verbosity
Date: Sat, 10 Dec 2005 14:11:38 +0800
Message-ID: <439A719A.8040801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky58-0002pn-80
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:42 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky56-0004ad-TU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:42 -0800
Received: by zproxy.gmail.com with SMTP id 34so1064835nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:19:40 -0800 (PST)
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
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

From: Ville Syrj=E4l=E4 <syrjala@sci.fi>

Don't complain about invalid modes when FB_ACTIVATE_TEST is used.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index a627f67..fcb252f 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -109,9 +109,18 @@
 #define GUI_RESERVE	(1 * PAGE_SIZE)
=20
 /* FIXME: remove the FAIL definition */
-#define FAIL(msg) do { printk(KERN_CRIT "atyfb: " msg "\n"); return -EIN=
VAL; } while (0)
-#define FAIL_MAX(msg, x, _max_) do { if(x > _max_) { printk(KERN_CRIT "a=
tyfb: " msg " %x(%x)\n", x, _max_); return -EINVAL; } } while (0)
-
+#define FAIL(msg) do { \
+	if (!(var->activate & FB_ACTIVATE_TEST)) \
+		printk(KERN_CRIT "atyfb: " msg "\n"); \
+	return -EINVAL; \
+} while (0)
+#define FAIL_MAX(msg, x, _max_) do { \
+	if (x > _max_) { \
+		if (!(var->activate & FB_ACTIVATE_TEST)) \
+			printk(KERN_CRIT "atyfb: " msg " %x(%x)\n", x, _max_); \
+		return -EINVAL; \
+	} \
+} while (0)
 #ifdef DEBUG
 #define DPRINTK(fmt, args...)	printk(KERN_DEBUG "atyfb: " fmt, ## args)
 #else
@@ -840,11 +849,14 @@ static int aty_var_to_crtc(const struct=20
 			   know if one is connected. So it's better to fail then.
 			 */
 			if (crtc->lcd_gen_cntl & CRT_ON) {
-				PRINTKI("Disable LCD panel, because video mode does not fit.\n");
+				if (!(var->activate & FB_ACTIVATE_TEST))
+					PRINTKI("Disable LCD panel, because video mode does not fit.\n");
 				crtc->lcd_gen_cntl &=3D ~LCD_ON;
 				/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
 			} else {
-				FAIL("Video mode exceeds size of LCD panel.\nConnect this computer t=
o a conventional monitor if you really need this mode.");
+				if (!(var->activate & FB_ACTIVATE_TEST))
+					PRINTKE("Video mode exceeds size of LCD panel.\nConnect this comput=
er to a conventional monitor if you really need this mode.\n");
+				return -EINVAL;
 			}
 		}
 	}
@@ -1184,7 +1196,8 @@ static int aty_crtc_to_var(const struct=20
 		var->transp.length =3D 8;
 		break;
 	default:
-		FAIL("Invalid pixel width");
+		PRINTKE("Invalid pixel width\n");
+		return -EINVAL;
 	}
=20
 	/* output */
@@ -1241,7 +1254,8 @@ static int atyfb_set_par(struct fb_info=20
 	pixclock =3D atyfb_get_pixclock(var, par);
=20
 	if (pixclock =3D=3D 0) {
-		FAIL("Invalid pixclock");
+		PRINTKE("Invalid pixclock\n");
+		return -EINVAL;
 	} else {
 		if((err =3D par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pix=
el, &par->pll)))
 			return err;
@@ -1446,7 +1460,9 @@ static int atyfb_check_var(struct fb_var
 	pixclock =3D atyfb_get_pixclock(var, par);
=20
 	if (pixclock =3D=3D 0) {
-		FAIL("Invalid pixclock");
+		if (!(var->activate & FB_ACTIVATE_TEST))
+			PRINTKE("Invalid pixclock\n");
+		return -EINVAL;
 	} else {
 		if((err =3D par->pll_ops->var_to_pll(info, pixclock, var->bits_per_pix=
el, &pll)))
 			return err;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
