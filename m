From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] staging: misplaced parentheses?
Date: Thu, 14 May 2009 14:19:26 +0200
Message-ID: <4A0C0C4E.6070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1M4aNV-000388-Hh
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 May 2009 12:49:37 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4aNO-0004VG-ER for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 May 2009 12:49:34 +0000
Received: by ewy17 with SMTP id 17so1591605ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 14 May 2009 05:49:29 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

The leftmost `+' has a higher precedence than the `?' so this returns
(vres * hres * (1 << color_mode) + (VMODE && CMODE) ? 0x10 : 0x20) + 0x1000

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
The original code looks odd, but I am not entirely certain whether my patch is
correct. So please review.

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 03b3670..a88f4b6 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -224,7 +224,7 @@ static inline int platinum_vram_reqd(int video_mode, int color_mode)
 	return vmode_attrs[video_mode-1].vres *
 	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
 		((video_mode == VMODE_832_624_75) &&
-		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
+		 (color_mode > CMODE_8) ? 0x10 : 0x20)) + 0x1000;
 }
 
 #define STORE_D2(a, d) { \

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
