From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/7 RESEND] fbdev: Possible endian fix in cfbimageblit
Date: Tue, 08 Nov 2005 06:07:05 +0800
Message-ID: <436FD009.5010809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZF9J-0007Ba-RI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 14:07:33 -0800
Received: from xproxy.gmail.com ([66.249.82.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZF9H-0001aD-At
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 14:07:33 -0800
Received: by xproxy.gmail.com with SMTP id h29so477615wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 14:07:30 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix possible endian bug(?) when bit testing in slow_imageblit().  This
function is rarely called (only if (width * bpp) % 32 != 0) thus the bug is
not triggered.

However, if the console is rotated at 90 or 270 degrees, the height becomes
the width, and a variety of fonts have heights that will force a call to
slow_imageblit().

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 cfbimgblt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

I inadvertently included a semicolon here
#define BIT_NR(b)              (7 - (b));

Tony

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index da664ce..f3b89fe 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -80,10 +80,12 @@ static u32 cfb_tab32[] = {
 #define LEFT_POS(bpp)          (32 - bpp)
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
+#define BIT_NR(b)              (7 - (b))
 #else
 #define LEFT_POS(bpp)          (0)
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
+#define BIT_NR(b)              (b)
 #endif
 
 static inline void color_imageblit(const struct fb_image *image, 
@@ -177,7 +179,7 @@ static inline void slow_imageblit(const 
 
 		while (j--) {
 			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
+			color = (*s & 1 << (BIT_NR(l))) ? fgcolor : bgcolor;
 			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
