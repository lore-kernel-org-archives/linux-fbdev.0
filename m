From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fix for using >16 pixel wide font in fb console
Date: Mon, 8 Nov 2004 18:34:26 +0800
Message-ID: <200411081834.26877.adaplas@hotpop.com>
References: <Pine.LNX.4.58.0411080202040.5524@glomgold-9.cs.helsinki.fi> <200411081816.15633.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CR6rA-0001Sj-Oo
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 02:34:40 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CR6r9-0002u7-70
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 02:34:40 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 250D69C2536
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  8 Nov 2004 10:34:26 +0000 (UTC)
In-Reply-To: <200411081816.15633.adaplas@hotpop.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jjaakkol@cs.Helsinki.FI

On Monday 08 November 2004 18:16, Antonino A. Daplas wrote:
> On Monday 08 November 2004 08:17, Jani Jaakkola wrote:

> PS: Diff is against 2.6.10-rc1-mm3

And I forgot to attach the patch :-)

Tony

diff -Nru a/drivers/video/softcursor.c b/drivers/video/softcursor.c
--- a/drivers/video/softcursor.c	2004-10-27 16:28:36 +08:00
+++ b/drivers/video/softcursor.c	2004-11-08 18:10:58 +08:00
@@ -28,16 +28,17 @@
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	src = kmalloc(64 + sizeof(struct fb_image), GFP_ATOMIC);
+	s_pitch = (cursor->image.width + 7) >> 3;
+	dsize = s_pitch * cursor->image.height;
 
+	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
 	if (!src)
 		return -ENOMEM;
 
-	image = (struct fb_image *) (src + 64);
+	image = (struct fb_image *) (src + dsize);
 	*image = cursor->image;
-	s_pitch = (image->width + 7) >> 3;
-	dsize = s_pitch * image->height;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
+
 	size = d_pitch * image->height + buf_align;
 	size &= ~buf_align;
 	dst = fb_get_buffer_offset(info, &info->pixmap, size);




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
