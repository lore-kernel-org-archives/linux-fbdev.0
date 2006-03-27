From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/7] fbcon: Fix big-endian bogosity in slow_imageblit()
Date: Mon, 27 Mar 2006 21:11:44 +0800
Message-ID: <4427E490.9010002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrXw-0002hp-Cf
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:14:12 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrXt-0007zZ-W4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:14:12 -0800
Received: by xproxy.gmail.com with SMTP id t4so937073wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:14:07 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Herbert Poetzl <herbert@13thfloor.at>, stable@kernel.org

The monochrome->color expansion routine that handles bitmaps which have
(widths % 8) != 0 (slow_imageblit) produces corrupt characters in big-endian.
This is caused by a bogus bit test in slow_imageblit().

Fix.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Acked-by: Herbert Poetzl <herbert@13thfloor.at>
---

This patch may deserve to go to the stable tree.  The code has already
been well tested in little-endian machines.  It's only in big-endian
where there is uncertainty and Herbert confirmed that this is the
correct way to go.

It should not introduce regressions.

Tony

 drivers/video/cfbimgblt.c |    2 +-
 include/linux/fb.h        |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 910e233..8ba6152 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -169,7 +169,7 @@ static inline void slow_imageblit(const 
 
 		while (j--) {
 			l--;
-			color = (*s & 1 << (FB_BIT_NR(l))) ? fgcolor : bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d03fadf..315d897 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -839,12 +839,10 @@ struct fb_info {
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
-#define FB_BIT_NR(b)              (7 - (b))
 #else
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
-#define FB_BIT_NR(b)              (b)
 #endif
 
     /*



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
