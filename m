From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 4/6] fbdev: Add fb_append_extra_logo()
Date: Tue, 30 Jan 2007 19:02:20 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301902040.2830@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBxJa-00069y-Tr for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:02:42 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBxJO-0004Uf-QP
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:02:39 -0800
In-Reply-To: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

Add fb_append_extra_logo(), to append extra lines of logos below the standard
Linux logo.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/video/fbmem.c      |   50 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/linux_logo.h |    1 
 2 files changed, 47 insertions(+), 4 deletions(-)

--- geert-linux-src.orig/drivers/video/fbmem.c
+++ geert-linux-src/drivers/video/fbmem.c
@@ -319,6 +319,13 @@ static struct logo_data {
 	const struct linux_logo *logo;
 } fb_logo __read_mostly;
 
+#define FB_LOGO_EX_NUM_MAX 10
+static struct logo_data_extra {
+	const struct linux_logo *logo;
+	int n;
+} fb_logo_ex[FB_LOGO_EX_NUM_MAX];
+static int fb_logo_ex_num = 0;
+
 static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, u32 height)
 {
 	u32 size = width * height, i;
@@ -408,10 +415,20 @@ static void fb_do_show_logo(struct fb_in
 	}
 }
 
+void fb_append_extra_logo(const struct linux_logo *logo, int n)
+{
+	if (n <= 0 || fb_logo_ex_num == FB_LOGO_EX_NUM_MAX)
+		return;
+
+	fb_logo_ex[fb_logo_ex_num].logo = logo;
+	fb_logo_ex[fb_logo_ex_num].n = n;
+	fb_logo_ex_num++;
+}
+
 int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
-	int yres;
+	int yres, height, i;
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
@@ -470,7 +487,21 @@ int fb_prepare_logo(struct fb_info *info
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
@@ -541,10 +572,20 @@ static int fb_show_logo_line(struct fb_i
 
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
+void fb_append_extra_logo(const struct linux_logo *logo, int n) {}
 int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }
 int fb_show_logo(struct fb_info *info, int rotate) { return 0; }
 #endif /* CONFIG_LOGO */
@@ -1560,6 +1601,7 @@ EXPORT_SYMBOL(register_framebuffer);
 EXPORT_SYMBOL(unregister_framebuffer);
 EXPORT_SYMBOL(num_registered_fb);
 EXPORT_SYMBOL(registered_fb);
+EXPORT_SYMBOL(fb_append_extra_logo);
 EXPORT_SYMBOL(fb_prepare_logo);
 EXPORT_SYMBOL(fb_show_logo);
 EXPORT_SYMBOL(fb_set_var);
--- geert-linux-src.orig/include/linux/linux_logo.h
+++ geert-linux-src/include/linux/linux_logo.h
@@ -33,5 +33,6 @@ struct linux_logo {
 };
 
 extern const struct linux_logo *fb_find_logo(int depth);
+extern void fb_append_extra_logo(const struct linux_logo *logo, int n);
 
 #endif /* _LINUX_LINUX_LOGO_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
