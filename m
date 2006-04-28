From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Frame buffer: remove cmap sysfs interface (fwd)
Date: Fri, 28 Apr 2006 14:56:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0604281456090.4303@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZSWv-0008Om-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 05:57:05 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZSWw-0002yQ-2g
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 05:57:06 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZSWu-0005Ia-93
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 05:57:06 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>


FYI...

---------- Forwarded message ----------
Date: Thu, 27 Apr 2006 21:59:59 GMT
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: git-commits-head@vger.kernel.org
Subject: [PATCH] Frame buffer: remove cmap sysfs interface

commit 913e7ec545462b9a49fa308d0c81697236f7d29d
tree a2cacb4c2536ce09f4c43032dabd54042e886bfc
parent 2be4d50295e2b6f62c07b614e1b103e280dddb84
author Jon Smirl <jonsmirl@gmail.com> Thu, 13 Apr 2006 03:43:35 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Apr 2006 03:08:56 -0700

[PATCH] Frame buffer: remove cmap sysfs interface

Remove it as it does not work properly due to sysfs core changes.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/video/fbsysfs.c |   92 +-----------------------------------------------
 1 files changed, 3 insertions(+), 89 deletions(-)

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index b72b052..34e0739 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -305,94 +305,6 @@ static ssize_t show_stride(struct class_
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
 }
 
-/* Format for cmap is "%02x%c%4x%4x%4x\n" */
-/* %02x entry %c transp %4x red %4x blue %4x green \n */
-/* 256 rows at 16 chars equals 4096, the normal page size */
-/* the code will automatically adjust for different page sizes */
-static ssize_t store_cmap(struct class_device *class_device, const char *buf,
-			  size_t count)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	int rc, i, start, length, transp = 0;
-
-	if ((count > PAGE_SIZE) || ((count % 16) != 0))
-		return -EINVAL;
-
-	if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
-		return -EINVAL;
-
-	sscanf(buf, "%02x", &start);
-	length = count / 16;
-
-	for (i = 0; i < length; i++)
-		if (buf[i * 16 + 2] != ' ')
-			transp = 1;
-
-	/* If we can batch, do it */
-	if (fb_info->fbops->fb_setcmap && length > 1) {
-		struct fb_cmap umap;
-
-		memset(&umap, 0, sizeof(umap));
-		if ((rc = fb_alloc_cmap(&umap, length, transp)))
-			return rc;
-
-		umap.start = start;
-		for (i = 0; i < length; i++) {
-			sscanf(&buf[i * 16 +  3], "%4hx", &umap.red[i]);
-			sscanf(&buf[i * 16 +  7], "%4hx", &umap.blue[i]);
-			sscanf(&buf[i * 16 + 11], "%4hx", &umap.green[i]);
-			if (transp)
-				umap.transp[i] = (buf[i * 16 +  2] != ' ');
-		}
-		rc = fb_info->fbops->fb_setcmap(&umap, fb_info);
-		fb_copy_cmap(&umap, &fb_info->cmap);
-		fb_dealloc_cmap(&umap);
-
-		return rc ?: count;
-	}
-	for (i = 0; i < length; i++) {
-		u16 red, blue, green, tsp;
-
-		sscanf(&buf[i * 16 +  3], "%4hx", &red);
-		sscanf(&buf[i * 16 +  7], "%4hx", &blue);
-		sscanf(&buf[i * 16 + 11], "%4hx", &green);
-		tsp = (buf[i * 16 +  2] != ' ');
-		if ((rc = fb_info->fbops->fb_setcolreg(start++,
-				      red, green, blue, tsp, fb_info)))
-			return rc;
-
-		fb_info->cmap.red[i] = red;
-		fb_info->cmap.blue[i] = blue;
-		fb_info->cmap.green[i] = green;
-		if (transp)
-			fb_info->cmap.transp[i] = tsp;
-	}
-	return count;
-}
-
-static ssize_t show_cmap(struct class_device *class_device, char *buf)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	unsigned int i;
-
-	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
-	   !fb_info->cmap.green)
-		return -EINVAL;
-
-	if (fb_info->cmap.len > PAGE_SIZE / 16)
-		return -EINVAL;
-
-	/* don't mess with the format, the buffer is PAGE_SIZE */
-	/* 256 entries at 16 chars per line equals 4096 = PAGE_SIZE */
-	for (i = 0; i < fb_info->cmap.len; i++) {
-		snprintf(&buf[ i * 16], PAGE_SIZE - i * 16, "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
-			((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
-			fb_info->cmap.red[i], fb_info->cmap.blue[i],
-			fb_info->cmap.green[i]);
-	}
-	return 16 * fb_info->cmap.len;
-}
-
 static ssize_t store_blank(struct class_device *class_device, const char * buf,
 			   size_t count)
 {
@@ -502,10 +414,12 @@ static ssize_t show_fbstate(struct class
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
 }
 
+/* When cmap is added back in it should be a binary attribute
+ * not a text one. Consideration should also be given to converting
+ * fbdev to use configfs instead of sysfs */
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
-	__ATTR(color_map, S_IRUGO|S_IWUSR, show_cmap, store_cmap),
 	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
 	__ATTR(cursor, S_IRUGO|S_IWUSR, show_cursor, store_cursor),
 	__ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode),
-
To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
