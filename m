From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 3/9] ps3fb: Kill PS3FB_FULL_MODE_BIT
Date: Mon, 26 Nov 2007 18:24:58 +0100
Message-ID: <20071126172712.241743000@pademelon.sonytel.be>
References: <20071126172455.308741000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============2080320188=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwhkY-0008HG-Jb for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 09:28:02 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwhkU-0000Wp-PV
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 09:28:02 -0800
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============2080320188==
Content-Disposition: inline;
	filename=ps3-wip/ps3fb-kill-PS3FB_FULL_MODE_BIT.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Kill PS3FB_FULL_MODE_BIT, use PS3AV_MODE_FULL instead

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -56,8 +56,6 @@
 #define GPU_ALIGN_UP(x)				_ALIGN_UP((x), 64)
 #define GPU_MAX_LINE_LENGTH			(65536 - 64)
 
-#define PS3FB_FULL_MODE_BIT			0x80
-
 #define GPU_INTR_STATUS_VSYNC_0			0	/* vsync on head A */
 #define GPU_INTR_STATUS_VSYNC_1			1	/* vsync on head B */
 #define GPU_INTR_STATUS_FLIP_0			3	/* flip head A */
@@ -309,7 +307,7 @@ static int ps3fb_get_res_table(u32 xres,
 	unsigned int i;
 	u32 x, y, f;
 
-	full_mode = (mode & PS3FB_FULL_MODE_BIT) ? PS3FB_RES_FULL : 0;
+	full_mode = (mode & PS3AV_MODE_FULL) ? PS3FB_RES_FULL : 0;
 	for (i = 0;; i++) {
 		x = ps3fb_res[i].xres;
 		y = ps3fb_res[i].yres;
@@ -372,7 +370,7 @@ found:
 	/* Full broadcast modes have the full mode bit set */
 	mode = i+1;
 	if (mode > PS3AV_MODE_WUXGA)
-		mode = (mode - PS3AV_MODE_WUXGA) | PS3FB_FULL_MODE_BIT;
+		mode = (mode - PS3AV_MODE_WUXGA) | PS3AV_MODE_FULL;
 
 	pr_debug("ps3fb_find_mode: mode %u\n", mode);
 
@@ -389,7 +387,7 @@ static const struct fb_videomode *ps3fb_
 
 	flags = id & ~PS3AV_MODE_MASK;
 
-	if (mode <= PS3AV_MODE_1080P50 && flags & PS3FB_FULL_MODE_BIT) {
+	if (mode <= PS3AV_MODE_1080P50 && flags & PS3AV_MODE_FULL) {
 		/* Full broadcast mode */
 		return &ps3fb_modedb[mode + PS3AV_MODE_WUXGA - 1];
 	}

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



--===============2080320188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2080320188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2080320188==--
