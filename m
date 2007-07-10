From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 2/4] fbdev: Add fb_append_extra_logo()
Date: Tue, 10 Jul 2007 14:27:04 +0200
Message-ID: <20070710123540.678435000@pademelon.sonytel.be>
References: <20070710122702.765654000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1120634262=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8ExT-0000n2-04 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 05:36:47 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8ExS-0005zt-3D
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 05:36:46 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, cbe-oss-dev@ozlabs.org

--===============1120634262==
Content-Disposition: inline; filename=spe-logo/fb_append_extra_logo.diff

Add fb_append_extra_logo(), to append extra lines of logos below the standard
Linux logo.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-By: James Simmons <jsimmons@infradead.org>
---
 drivers/video/fbmem.c      |   50 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/linux_logo.h |    8 +++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -318,6 +318,13 @@ static struct logo_data {
 	const struct linux_logo *logo;
 } fb_logo __read_mostly;
 
+#define FB_LOGO_EX_NUM_MAX 10
+static struct logo_data_extra {
+	const struct linux_logo *logo;
+	unsigned int n;
+} fb_logo_ex[FB_LOGO_EX_NUM_MAX];
+static unsigned int fb_logo_ex_num;
+
 static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, u32 height)
 {
 	u32 size = width * height, i;
@@ -411,10 +418,22 @@ static void fb_do_show_logo(struct fb_in
 	}
 }
 
+#ifdef CONFIG_FB
+void fb_append_extra_logo(const struct linux_logo *logo, unsigned int n)
+{
+	if (!n || fb_logo_ex_num == FB_LOGO_EX_NUM_MAX)
+		return;
+
+	fb_logo_ex[fb_logo_ex_num].logo = logo;
+	fb_logo_ex[fb_logo_ex_num].n = n;
+	fb_logo_ex_num++;
+}
+#endif
+
 int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
-	int yres;
+	unsigned int yres, height, i;
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
@@ -474,7 +493,21 @@ int fb_prepare_logo(struct fb_info *info
 		fb_logo.depth = 4;
 	else
 		fb_logo.depth = 1;		
-	return fb_logo.logo->height;
+
+	/* FIXME: logo_ex supports only truecolor fb. */
+	if (info->fix.visual != FB_VISUAL_TRUECOLOR)
+		fb_logo_ex_num = 0;
+
+	height = fb_logo.logo->height;
+	for (i = 0; i < fb_logo_ex_num; i++) {
+		height += fb_logo_ex[i].logo->height;
+		if (height > yres) {
+			height -= fb_logo_ex[i].logo->height;
+			fb_logo_ex_num = i;
+			break;
+		}
+	}
+	return height;
 }
 
 static int fb_show_logo_line(struct fb_info *info, int rotate,
@@ -547,8 +580,17 @@ static int fb_show_logo_line(struct fb_i
 
 int fb_show_logo(struct fb_info *info, int rotate)
 {
-	return fb_show_logo_line(info, rotate, fb_logo.logo, 0,
-				 num_online_cpus());
+	int y, i;
+
+	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0,
+			      num_online_cpus());
+
+	for (i = 0; i < fb_logo_ex_num; i++) {
+		y += fb_show_logo_line(info, rotate,
+				       fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
+	}
+
+	return y;
 }
 #else
 int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -33,5 +33,13 @@ struct linux_logo {
 };
 
 extern const struct linux_logo *fb_find_logo(int depth);
+#if defined(CONFIG_LOGO) && defined(CONFIG_FB)
+extern void fb_append_extra_logo(const struct linux_logo *logo,
+				 unsigned int n);
+#else
+static inline void fb_append_extra_logo(const struct linux_logo *logo,
+					unsigned int n)
+{}
+#endif
 
 #endif /* _LINUX_LINUX_LOGO_H */

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village ������ Da Vincilaan 7-D1 ������ B-1935 Zaventem ������ Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 ������ B-1840 Londerzeel ������ Belgium	
VAT BE 0413.825.160 ������ RPR Brussels	
Fortis Bank Zaventem ������ Swift GEBABEBB08A ������ IBAN BE39001382358619



--===============1120634262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1120634262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1120634262==--
