From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] 2.5.24 matroxfb memory corruption
Date: Sun, 30 Jun 2002 02:28:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <afles2$eas$2@main.gmane.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p015.as-l031.contactel.cz ([212.65.234.207] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ORNF-0001Zb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Jun 2002 16:11:26 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi,
  Linus, please apply this. When James converted all drivers to unified
do_install_cmap(), he blindly changed also matroxfb, which happily
uses fbcon.currcon == -1. This caused memory corruption because of
memory before fb_display[] array was overwritten.
  Default do_install_cmap() also installed invalid default color map
in some matroxfb resolutions. Not all world have >= 4bpp.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Fri Jun 21 00:53:55 2002
+++ linux/drivers/video/matrox/matroxfb_base.c	Sun Jun 30 02:19:15 2002
@@ -141,6 +141,19 @@
 
 
 /* --------------------------------------------------------------------- */
+static inline void my_install_cmap(WPMINFO2)
+{
+	/* Do not touch this code if you do not understand what it does! */
+	/* Never try to use do_install_cmap() instead. It is crap. */
+	struct fb_cmap* cmap = &ACCESS_FBINFO(currcon_display)->cmap;
+
+	if (cmap->len)
+		fb_set_cmap(cmap, 1, &ACCESS_FBINFO(fbcon));
+	else
+		fb_set_cmap(fb_default_cmap(ACCESS_FBINFO(curr.cmap_len)),
+			    1, &ACCESS_FBINFO(fbcon));
+}
+
 
 static void matrox_pan_var(WPMINFO struct fb_var_screeninfo *var) {
 	unsigned int pos;
@@ -869,7 +882,7 @@
 				up_read(&ACCESS_FBINFO(altout.lock));
 			}
 			matrox_cfbX_init(PMINFO display);
-			do_install_cmap(ACCESS_FBINFO(fbcon.currcon),&ACCESS_FBINFO(fbcon));
+			my_install_cmap(PMINFO2);
 #if defined(CONFIG_FB_COMPAT_XPMAC)
 			if (console_fb_info == &ACCESS_FBINFO(fbcon)) {
 				int vmode, cmode;
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun 21 00:53:48 2002
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Sun Jun 30 02:19:15 2002
@@ -84,6 +84,19 @@
 #undef m2info
 }
 
+static inline void my_install_cmap(struct matroxfb_dh_fb_info* m2info)
+{
+	/* Do not touch this code if you do not understand what it does! */
+	/* Never try to use do_install_cmap() instead. It is crap. */
+	struct fb_cmap* cmap = &m2info->currcon_display->cmap;
+	
+	if (cmap->len)
+		fb_set_cmap(cmap, 1, &m2info->fbcon);
+	else
+		fb_set_cmap(fb_default_cmap(16), 1, &m2info->fbcon);
+}
+
+
 static void matroxfb_dh_restore(struct matroxfb_dh_fb_info* m2info,
 		struct my_timming* mt,
 		struct display* p,
@@ -439,7 +452,7 @@
 			up_read(&ACCESS_FBINFO(altout.lock));
 		}
 		matroxfb_dh_cfbX_init(m2info, p);
-		do_install_cmap(ACCESS_FBINFO(fbcon.currcon), &ACCESS_FBINFO(fbcon));
+		my_install_cmap(m2info);
 	}
 	return 0;
 #undef m2info


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
