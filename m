From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/12] atyfb: Fix hardware cursor handling
Date: Sat, 29 Apr 2006 08:30:31 +0800
Message-ID: <4452B3A7.6090907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdhr-0003jl-W8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:07 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdhs-000163-29
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:08 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdhq-0006gw-Tn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:08 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:06 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alexander Kern <alex.kern@gmx.de>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

Fix image and color handling in atyfb_cursor()

- In the 2-bit scheme of the cursor image, just set the first bit to
be always zero (turn off transparency and/or XOR), and just do the masking
manually
- The cursor color is converted into 32-bit RGBA8888 using struct fb_cmap.
Each component in the cmap is u16 in size, so mask the upper 8 bits.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/mach64_cursor.c |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
index ad8b749..27bf013 100644
--- a/drivers/video/aty/mach64_cursor.c
+++ b/drivers/video/aty/mach64_cursor.c
@@ -66,11 +66,6 @@ static const u8 cursor_bits_lookup[16] =
 	0x01, 0x41, 0x11, 0x51, 0x05, 0x45, 0x15, 0x55
 };
 
-static const u8 cursor_mask_lookup[16] = {
-	0xaa, 0x2a, 0x8a, 0x0a, 0xa2, 0x22, 0x82, 0x02,
-	0xa8, 0x28, 0x88, 0x08, 0xa0, 0x20, 0x80, 0x00
-};
-
 static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -130,13 +125,13 @@ static int atyfb_cursor(struct fb_info *
 		fg_idx = cursor->image.fg_color;
 		bg_idx = cursor->image.bg_color;
 
-		fg = (info->cmap.red[fg_idx] << 24) |
-		     (info->cmap.green[fg_idx] << 16) |
-		     (info->cmap.blue[fg_idx] << 8) | 15;
-
-		bg = (info->cmap.red[bg_idx] << 24) |
-		     (info->cmap.green[bg_idx] << 16) |
-		     (info->cmap.blue[bg_idx] << 8);
+		fg = ((info->cmap.red[fg_idx] & 0xff) << 24) |
+		     ((info->cmap.green[fg_idx] & 0xff) << 16) |
+		     ((info->cmap.blue[fg_idx] & 0xff) << 8) | 0xff;
+
+		bg = ((info->cmap.red[bg_idx] & 0xff) << 24) |
+		     ((info->cmap.green[bg_idx] & 0xff) << 16) |
+		     ((info->cmap.blue[bg_idx] & 0xff) << 8);
 
 		wait_for_fifo(2, par);
 		aty_st_le32(CUR_CLR0, bg, par);
@@ -166,19 +161,17 @@ static int atyfb_cursor(struct fb_info *
 			switch (cursor->rop) {
 			case ROP_XOR:
 			    // Upper 4 bits of mask data
-			    fb_writeb(cursor_mask_lookup[m >> 4 ] |
-				cursor_bits_lookup[(b ^ m) >> 4], dst++);
+			    fb_writeb(cursor_bits_lookup[(b ^ m) >> 4], dst++);
 			    // Lower 4 bits of mask
-			    fb_writeb(cursor_mask_lookup[m & 0x0f ] |
-				cursor_bits_lookup[(b ^ m) & 0x0f], dst++);
+			    fb_writeb(cursor_bits_lookup[(b ^ m) & 0x0f],
+				      dst++);
 			    break;
 			case ROP_COPY:
 			    // Upper 4 bits of mask data
-			    fb_writeb(cursor_mask_lookup[m >> 4 ] |
-				cursor_bits_lookup[(b & m) >> 4], dst++);
+			    fb_writeb(cursor_bits_lookup[(b & m) >> 4], dst++);
 			    // Lower 4 bits of mask
-			    fb_writeb(cursor_mask_lookup[m & 0x0f ] |
-				cursor_bits_lookup[(b & m) & 0x0f], dst++);
+			    fb_writeb(cursor_bits_lookup[(b & m) & 0x0f],
+				      dst++);
 			    break;
 			}
 		}



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
