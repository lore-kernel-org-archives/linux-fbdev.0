From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 12/13] fb: Move and rename extern
	declaration for global_mode_option
Date: Fri, 12 Oct 2007 16:51:04 +0200
Message-ID: <20071012145130.867069000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1529162570=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgLsN-0003Dp-BF for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:52:31 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgLsK-0002qn-RH
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:52:31 -0700
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org

--===============1529162570==
Content-Disposition: inline; filename=ps3-stable/fb-fb_mode_option.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Move the extern declaration for global_mode_option to <linux/fb.h> and rename
the variable to fb_mode_option.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/fbmem.c  |    4 +---
 drivers/video/modedb.c |    4 ++--
 include/linux/fb.h     |    1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1567,8 +1567,6 @@ int fb_new_modelist(struct fb_info *info
 static char *video_options[FB_MAX] __read_mostly;
 static int ofonly __read_mostly;
 
-extern const char *global_mode_option;
-
 /**
  * fb_get_options - get kernel boot parameters
  * @name:   framebuffer name as it would appear in
@@ -1636,7 +1634,7 @@ static int __init video_setup(char *opti
  	}
 
  	if (!global && !strstr(options, "fb:")) {
- 		global_mode_option = options;
+ 		fb_mode_option = options;
  		global = 1;
  	}
 
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -27,7 +27,7 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-const char *global_mode_option;
+const char *fb_mode_option;
 
     /*
      *  Standard video mode definitions (taken from XFree86)
@@ -510,7 +510,7 @@ int fb_find_mode(struct fb_var_screeninf
 	default_bpp = 8;
 
     /* Did the user specify a video mode? */
-    if (mode_option || (mode_option = global_mode_option)) {
+    if (mode_option || (mode_option = fb_mode_option)) {
 	const char *name = mode_option;
 	unsigned int namelen = strlen(name);
 	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1054,6 +1054,7 @@ struct fb_videomode {
 	u32 flag;
 };
 
+extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 
 struct fb_modelist {

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



--===============1529162570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1529162570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1529162570==--
