From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 3/3] ps3fb: Set FBINFO_READS_FAST to
	speed up text console scrolling
Date: Fri, 20 Jul 2007 14:55:36 +0200
Message-ID: <20070720130425.323288000@pademelon.sonytel.be>
References: <20070720125533.933475000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1062038768=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBsB1-00023m-RM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Jul 2007 06:05:55 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBsB1-0001FR-9W
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Jul 2007 06:05:47 -0700
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
To: Antonino Daplas <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, Geoff Levand <geoffrey.levand@am.sony.com>

--===============1062038768==
Content-Disposition: inline;
	filename=ps3-stable/ps3fb-optimized-text-scrolling.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Set FBINFO_READS_FAST to speed up text console scrolling (on average
50%, according to my tests)

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1067,7 +1067,7 @@ static int __devinit ps3fb_probe(struct 
 	info->fix.smem_len = ps3fb_videomemory.size - offset;
 	info->pseudo_palette = info->par;
 	info->par = NULL;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT | FBINFO_READS_FAST;
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0)

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



--===============1062038768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1062038768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1062038768==--
