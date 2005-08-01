From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/2] tridentfb: Fix scrolling artifacts if acceleration is
 enabled
Date: Mon, 01 Aug 2005 23:46:44 +0800
Message-ID: <42EE43E4.7020704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzcbN-0007E3-Dk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 08:53:17 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DzcbL-0002O8-K9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 08:53:17 -0700
Received: by wproxy.gmail.com with SMTP id i27so1139660wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Aug 2005 08:53:04 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Knut Petersen <Knut_Petersen@t-online.de>, Jochen Hein <jochen@jochen.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Reported by: Jochen Hein (Bugzilla Bug 4386)

    booting leaves the end of long lines in the last line on screen when
    scrolling. When X is running, scrolling puts garbage on the screen (looks
    like X data) Console switch fixes the screen.  Behaviour seems to be
    identical with noaccel and without on the video=tridentfb parameter in
    lilo.conf.

    This bug was explained by: Knut_Petersen

    Acceleration is broken for all BLADE 3D chips for all versions of kernel 2.6
    except for 32bit modes. Most important reason is that the u32 col parameter of
    the graphics engine needs the color value replicated to all u8 of the u32 (8bit
    modes) and to both u16 of the u32.

    Fix color value passed to graphics engine, verified by the reporter:

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 tridentfb.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -454,13 +454,16 @@ static struct accel_switch accel_image =
 static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
 {
 	int bpp = info->var.bits_per_pixel;
-	int col;
+	int col = 0;
 	
 	switch (bpp) {
 		default:
-		case 8: col = fr->color;
+		case 8: col |= fr->color;
+			col |= col << 8;
+			col |= col << 16;
 			break;
 		case 16: col = ((u32 *)(info->pseudo_palette))[fr->color];
+			
 			 break;
 		case 32: col = ((u32 *)(info->pseudo_palette))[fr->color];
 			 break;
@@ -882,8 +885,9 @@ static int tridentfb_set_par(struct fb_i
 
 	write3X4(GraphEngReg, 0x80);	//enable GE for text acceleration
 
-//	if (info->var.accel_flags & FB_ACCELF_TEXT)
-//FIXME		acc->init_accel(info->var.xres,bpp);
+#ifdef CONFIG_FB_TRIDENT_ACCEL	
+	acc->init_accel(info->var.xres,bpp);
+#endif
 	
 	switch (bpp) {
 		case 8:  tmp = 0x00; break;
@@ -981,12 +985,14 @@ static int tridentfb_setcolreg(unsigned 
 		t_outb(green>>10,0x3C9);
 		t_outb(blue>>10,0x3C9);
 
-	} else
-	if (bpp == 16) 			/* RGB 565 */
-			((u32*)info->pseudo_palette)[regno] = (red & 0xF800) |
-			((green & 0xFC00) >> 5) | ((blue & 0xF800) >> 11);
-	else
-	if (bpp == 32)		/* ARGB 8888 */
+	} else if (bpp == 16) {	/* RGB 565 */
+		u32 col;
+
+		col = (red & 0xF800) | ((green & 0xFC00) >> 5) |
+			((blue & 0xF800) >> 11);
+		col |= col << 16;	
+		((u32 *)(info->pseudo_palette))[regno] = col;
+	} else if (bpp == 32)		/* ARGB 8888 */
 		((u32*)info->pseudo_palette)[regno] =
 			((transp & 0xFF00) <<16) 	|
 			((red & 0xFF00) << 8) 		|



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
