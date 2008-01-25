From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 11/11] ps3fb: Fix modedb typos
Date: Fri, 25 Jan 2008 16:06:34 +0100
Message-ID: <20080125153107.598867093@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1296157193=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JIQY8-00022m-50 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:33:00 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JIQY7-0004pL-6H
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:33:00 -0800
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, Geoff Levand <geoffrey.levand@am.sony.com>

--===============1296157193==
Content-Disposition: inline; filename=ps3-wip/ps3fb-modedb-typos.diff

From: Geoff Levand <geoffrey.levand@am.sony.com>

ps3fb: Fix modedb typos

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -184,7 +184,7 @@ static const struct fb_videomode ps3fb_m
         "720p", 50, 1124, 644, 13468, 298, 478, 57, 44, 80, 5,
         FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
     },    {
-        /* 1080 */
+        /* 1080i */
         "1080i", 50, 1688, 964, 13468, 264, 600, 94, 62, 88, 5,
         FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
     },    {
@@ -232,7 +232,7 @@ static const struct fb_videomode ps3fb_m
 	FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
     }, {
 	/* 1080if */
-	"1080f", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
+	"1080if", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
 	FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
     }, {
 	/* 1080pf */

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



--===============1296157193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1296157193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1296157193==--
