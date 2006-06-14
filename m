From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Problems with rotated Logos
Date: Wed, 14 Jun 2006 21:03:23 +0800
Message-ID: <4490091B.4090900@gmail.com>
References: <1150279997.27375.15.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqV1z-0006b6-Ti for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:03:35 -0700
Received: from wr-out-0506.google.com ([64.233.184.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FqV1y-00030L-80
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:03:35 -0700
Received: by wr-out-0506.google.com with SMTP id i32so113299wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 14 Jun 2006 06:03:31 -0700 (PDT)
In-Reply-To: <1150279997.27375.15.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Richard Purdie wrote:
> Hi,
> 
> I've been experimenting with logos on the Sharp Zaurus C3000 which has a
> 480x640 framebuffer which is rotated clockwise to give 640x480. I'm
> using a 2.6.16 based kernel.
> 
> If I use the standard Linux logo (clut224), all is well. I added a
> 640x185 logo and this locked the machine up when booting. Space was
> cleared at the top of the console for the logo and some boot messages
> appeared beneath it. Also, 639x185 gave the same result.

Yes, it's a bug. Also present in CCW. Try this patch.

Tony

fbdev: Fix logo rotation if width != height

Logo drawing crashes or produces corrupt display if the logo width and
height are not equal.  The dimensions are transposed prior to the actual
rotation, which produces a corrupt image.  Reverse the sequence to fix.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 9527a52..aaa4c9b 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -356,24 +356,24 @@ static void fb_rotate_logo(struct fb_inf
 	u32 tmp;
 
 	if (rotate == FB_ROTATE_UD) {
-		image->dx = info->var.xres - image->width;
-		image->dy = info->var.yres - image->height;
 		fb_rotate_logo_ud(image->data, dst, image->width,
 				  image->height);
+		image->dx = info->var.xres - image->width;
+		image->dy = info->var.yres - image->height;
 	} else if (rotate == FB_ROTATE_CW) {
-		tmp = image->width;
-		image->width = image->height;
-		image->height = tmp;
-		image->dx = info->var.xres - image->height;
 		fb_rotate_logo_cw(image->data, dst, image->width,
 				  image->height);
-	} else if (rotate == FB_ROTATE_CCW) {
 		tmp = image->width;
 		image->width = image->height;
 		image->height = tmp;
-		image->dy = info->var.yres - image->width;
+		image->dx = info->var.xres - image->width;
+	} else if (rotate == FB_ROTATE_CCW) {
 		fb_rotate_logo_ccw(image->data, dst, image->width,
 				   image->height);
+		tmp = image->width;
+		image->width = image->height;
+		image->height = tmp;
+		image->dy = info->var.yres - image->height;
 	}
 
 	image->data = dst;
