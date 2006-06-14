From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Problems with rotated Logos
Date: Thu, 15 Jun 2006 05:27:37 +0800
Message-ID: <44907F49.7050609@gmail.com>
References: <1150279997.27375.15.camel@localhost.localdomain>	
	<4490091B.4090900@gmail.com>
	<1150311401.9240.9.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqcvC-0003ey-SW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 14:29:06 -0700
Received: from wr-out-0506.google.com ([64.233.184.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FqcvB-0001w1-DI
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 14:29:06 -0700
Received: by wr-out-0506.google.com with SMTP id i24so240325wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 14 Jun 2006 14:29:03 -0700 (PDT)
In-Reply-To: <1150311401.9240.9.camel@localhost.localdomain>
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
> On Wed, 2006-06-14 at 21:03 +0800, Antonino A. Daplas wrote:
>> Richard Purdie wrote:
>>> Hi,
>>>
>>> I've been experimenting with logos on the Sharp Zaurus C3000 which has a
>>> 480x640 framebuffer which is rotated clockwise to give 640x480. I'm
>>> using a 2.6.16 based kernel.
>>>
>>> If I use the standard Linux logo (clut224), all is well. I added a
>>> 640x185 logo and this locked the machine up when booting. Space was
>>> cleared at the top of the console for the logo and some boot messages
>>> appeared beneath it. Also, 639x185 gave the same result.
>> Yes, it's a bug. Also present in CCW. Try this patch.
> 
> The patch helps in that the 640x185 image no longer locks the system up
> and it displays something, thanks! The image is corrupted however.
> Rather than trying to describe it:
> 
> http://www.rpsys.net/openzaurus/temp/logo-corrupt.jpg
> 
> (I'm refraining from comment about the logo itself ;-)

:-)

> 
> As well as the wrapping, the blue colour to the left is also corruption,
> and marks the edge of the screen.
> 
> I suspect the rotation function has a bug...
> 

Yes, you're right, the dimensions where reversed. Can you revert the previous
patch, and then apply this one?

Tony

PS: If this still doesn't work, can you send me your logo ppm file?

fbdev: Fix logo rotation if width != height

Logo drawing crashes or produces corrupt display if the logo width and
height are not equal.  The dimensions are transposed prior to the actual
rotation, which produces a corrupt image.  Reverse the sequence to fix.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 9527a52..a6b0629 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -334,11 +334,11 @@ static void fb_rotate_logo_ud(const u8 *
 
 static void fb_rotate_logo_cw(const u8 *in, u8 *out, u32 width, u32 height)
 {
-	int i, j, w = width - 1;
+	int i, j, h = height - 1;
 
 	for (i = 0; i < height; i++)
 		for (j = 0; j < width; j++)
-			out[height * j + w - i] = *in++;
+			out[height * j + h - i] = *in++;
 }
 
 static void fb_rotate_logo_ccw(const u8 *in, u8 *out, u32 width, u32 height)
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
