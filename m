From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 04/11] ps3fb: Inline macros that are
	used only once
Date: Fri, 25 Jan 2008 16:06:27 +0100
Message-ID: <20080125153107.177014292@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============2096251203=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JIQY1-00021x-An for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:32:53 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JIQXy-0004kU-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:32:53 -0800
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org

--===============2096251203==
Content-Disposition: inline; filename=ps3-wip/ps3fb-inline-macros.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: inline the X_OFF(), Y_OFF(), WIDTH(), HEIGHT(), and VP_OFF() macros,
as they're used in one place only

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -287,15 +287,8 @@ static const struct fb_videomode ps3fb_m
 #define HEAD_A
 #define HEAD_B
 
-#define X_OFF(i)	(ps3fb_res[i].xoff)	/* left/right margin (pixel) */
-#define Y_OFF(i)	(ps3fb_res[i].yoff)	/* top/bottom margin (pixel) */
-#define WIDTH(i)	(ps3fb_res[i].xres)	/* width of FB */
-#define HEIGHT(i)	(ps3fb_res[i].yres)	/* height of FB */
 #define BPP		4			/* number of bytes per pixel */
 
-/* Start of the virtual frame buffer (relative to fullscreen ) */
-#define VP_OFF(i)	((WIDTH(i) * Y_OFF(i) + X_OFF(i)) * BPP)
-
 
 static int ps3fb_mode;
 module_param(ps3fb_mode, int, 0);
@@ -611,7 +604,10 @@ static int ps3fb_set_par(struct fb_info 
 
 	par->width = info->var.xres;
 	par->height = info->var.yres;
-	offset = VP_OFF(i);
+
+	/* Start of the virtual frame buffer (relative to fullscreen) */
+	offset = ps3fb_res[i].yoff * ddr_line_length + ps3fb_res[i].xoff * BPP;
+
 	par->fb_offset = GPU_ALIGN_UP(offset);
 	par->full_offset = par->fb_offset - offset;
 	par->pan_offset = info->var.yoffset * xdr_line_length +

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



--===============2096251203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2096251203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2096251203==--
