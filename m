From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Fix screen pointer updating in bit_putcs
Date: Fri, 02 Sep 2005 21:53:46 +0800
Message-ID: <4318596A.5020003@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBC1T-00074y-Rf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Sep 2005 06:56:03 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EBC1S-0000dk-Cf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Sep 2005 06:56:04 -0700
Received: by zproxy.gmail.com with SMTP id s18so389022nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 Sep 2005 06:55:55 -0700 (PDT)
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

Bug reported by Knut Petersen:

The screen pointer (*s) is not updated if the loop is iterated more than
once.

Do not pass unused variables (xx, yy, and count) to the component function
of bit_putcs()

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 bitblit.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)


diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -104,9 +104,8 @@ static void bit_clear(struct vc_data *vc
 }
 
 static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
-				     const u16 *s, u32 count, u32 yy, u32 xx,
-				     u32 attr, u32 cnt, u32 d_pitch,
-				     u32 s_pitch, u32 cellsize,
+				     const u16 *s, u32 attr, u32 cnt,
+				     u32 d_pitch, u32 s_pitch, u32 cellsize,
 				     struct fb_image *image, u8 *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
@@ -136,8 +135,7 @@ static inline void bit_putcs_aligned(str
 }
 
 static inline void bit_putcs_unaligned(struct vc_data *vc,
-				       struct fb_info *info,
-				       const u16 *s, u32 count, u32 yy, u32 xx,
+				       struct fb_info *info, const u16 *s,
 				       u32 attr, u32 cnt, u32 d_pitch,
 				       u32 s_pitch, u32 cellsize,
 				       struct fb_image *image, u8 *buf,
@@ -213,16 +211,16 @@ static void bit_putcs(struct vc_data *vc
 		image.data = dst;
 
 		if (!mod)
-			bit_putcs_aligned(vc, info, s, count, yy, xx,
-					  attribute, cnt, pitch, width,
-					  cellsize, &image, buf, dst);
+			bit_putcs_aligned(vc, info, s, attribute, cnt, pitch,
+					  width, cellsize, &image, buf, dst);
 		else
-			bit_putcs_unaligned(vc, info, s, count, yy, xx,
-					    attribute, cnt, pitch, width,
-					    cellsize, &image, buf, dst);
+			bit_putcs_unaligned(vc, info, s, attribute, cnt,
+					    pitch, width, cellsize, &image,
+					    buf, dst);
 
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;
+		s += cnt;
 	}
 
 	/* buf is always NULL except when in monochrome mode, so in this case



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
