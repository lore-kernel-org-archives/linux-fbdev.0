From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] platinumfb: misplaced parenthesis
Date: Mon, 18 May 2009 12:23:57 +0200
Message-ID: <4A11373D.7030100@gmail.com>
References: <4A0C0C4E.6070401@gmail.com>	
	<20090514093827.33a099f7.akpm@linux-foundation.org>	
	<1242343459.1867.27.camel@pasglop>
	<4A0DD407.9090206@gmail.com>	 <20090515212449.GD6520@sci.fi>
	<1242426067.9691.4.camel@pasglop>	 <4A0FFA9C.5000404@gmail.com>
	<10f740e80905171011r7955a23bq24081e993b8f50cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1M600s-0001qC-A6
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 10:24:06 +0000
Received: from ey-out-1920.google.com ([74.125.78.150])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M600o-0004eN-1s for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 10:24:06 +0000
Received: by ey-out-1920.google.com with SMTP id 13so817386eye.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 May 2009 03:23:59 -0700 (PDT)
In-Reply-To: <10f740e80905171011r7955a23bq24081e993b8f50cb@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>

Since `+' has a higher precedence than the trinary operator `?', this
added `hres * (1 << color_mode)' to the boolean testing videomode
and depth.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
{Thanks,Bedankt} Geert.

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 03b3670..97f3bf4 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -221,10 +221,14 @@ static int platinumfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 static inline int platinum_vram_reqd(int video_mode, int color_mode)
 {
-	return vmode_attrs[video_mode-1].vres *
-	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
-		((video_mode == VMODE_832_624_75) &&
-		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
+	int baseval = vmode_attrs[video_mode-1].hres * (1<<color_mode);
+
+	if ((video_mode == VMODE_832_624_75) && (color_mode > CMODE_8))
+		baseval += 0x10;
+	else
+		baseval += 0x20;
+
+	return vmode_attrs[video_mode-1].vres * baseval + 0x1000;
 }
 
 #define STORE_D2(a, d) { \


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
