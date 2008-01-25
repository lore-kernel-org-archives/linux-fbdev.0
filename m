From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 06/11] ps3fb: Make frame buffer offsets
	unsigned int
Date: Fri, 25 Jan 2008 16:06:29 +0100
Message-ID: <20080125153107.297253543@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1340676983=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JIQY5-00022B-No for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:32:57 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JIQY5-0004tQ-91
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:32:57 -0800
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

--===============1340676983==
Content-Disposition: inline; filename=ps3-wip/ps3fb-unsigned-int-offsets.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Frame buffer offsets don't have to be `unsigned long', `unsigned int' is
sufficient

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -140,9 +140,9 @@ struct ps3fb_par {
 	unsigned int ddr_line_length;
 	unsigned int ddr_frame_size;
 	unsigned int xdr_frame_size;
-	unsigned long full_offset;	/* start of fullscreen DDR fb */
-	unsigned long fb_offset;	/* start of actual DDR fb */
-	unsigned long pan_offset;
+	unsigned int full_offset;	/* start of fullscreen DDR fb */
+	unsigned int fb_offset;		/* start of actual DDR fb */
+	unsigned int pan_offset;
 };
 
 
@@ -512,8 +512,7 @@ static int ps3fb_set_par(struct fb_info 
 {
 	struct ps3fb_par *par = info->par;
 	unsigned int mode, ddr_line_length, xdr_line_length, lines, maxlines;
-	unsigned int ddr_xoff, ddr_yoff;
-	unsigned long offset;
+	unsigned int ddr_xoff, ddr_yoff, offset;
 	const struct fb_videomode *vmode;
 	u64 dst;
 

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



--===============1340676983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1340676983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1340676983==--
