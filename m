From: akpm@osdl.org
Subject: fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace.patch added to -mm tree
Date: Mon, 25 Jul 2005 19:48:00 -0700
Message-ID: <200507260248.j6Q2mtPq026854@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxFV6-0001dz-G9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 19:49:00 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DxFV6-000720-7J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 19:49:00 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, mm-commits@vger.kernel.org


The patch titled

     fbdev: update info->cmap when setting cmap from user-/kernelspace.

has been added to the -mm tree.  Its filename is

     fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace.patch

Patches currently in -mm which might be from spock@gentoo.org are

dont-repaint-the-cursor-when-it-is-disabled.patch
fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace.patch



From: Michal Januszewski <spock@gentoo.org>

The fb_info struct, as defined in include/linux/fb.h, contains an element
that is supposed to hold the current color map:
  struct fb_cmap cmap;            /* Current cmap */

This cmap is currently never updated when either fb_set_cmap() or
fb_set_user_cmap() are called.  As a result, info->cmap contains the
default cmap that was set by a device driver/fbcon and a userspace
application using the FBIOGETCMAP ioctl will not always get the *currently*
used color map.

The patch fixes this by making sure the cmap is copied to info->cmap after
it is set correctly.  It moves most of the code that is responsible for
setting the cmap to fb_set_cmap() and out of fb_set_user_cmap() to avoid
code-duplication.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/fbcmap.c |   96 ++++++++++++++++++-------------------------------
 1 files changed, 36 insertions(+), 60 deletions(-)

diff -puN drivers/video/fbcmap.c~fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace drivers/video/fbcmap.c
--- devel/drivers/video/fbcmap.c~fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace	2005-07-25 19:47:37.000000000 -0700
+++ devel-akpm/drivers/video/fbcmap.c	2005-07-25 19:47:37.000000000 -0700
@@ -212,7 +212,7 @@ int fb_cmap_to_user(struct fb_cmap *from
 
 int fb_set_cmap(struct fb_cmap *cmap, struct fb_info *info)
 {
-	int i, start;
+	int i, start, rc = 0;
 	u16 *red, *green, *blue, *transp;
 	u_int hred, hgreen, hblue, htransp = 0xffff;
 
@@ -225,75 +225,51 @@ int fb_set_cmap(struct fb_cmap *cmap, st
 	if (start < 0 || (!info->fbops->fb_setcolreg &&
 			  !info->fbops->fb_setcmap))
 		return -EINVAL;
-	if (info->fbops->fb_setcmap)
-		return info->fbops->fb_setcmap(cmap, info);
-	for (i = 0; i < cmap->len; i++) {
-		hred = *red++;
-		hgreen = *green++;
-		hblue = *blue++;
-		if (transp)
-			htransp = *transp++;
-		if (info->fbops->fb_setcolreg(start++,
-					      hred, hgreen, hblue, htransp,
-					      info))
-			break;
+	if (info->fbops->fb_setcmap) {
+		rc = info->fbops->fb_setcmap(cmap, info);
+	} else {
+		for (i = 0; i < cmap->len; i++) {
+			hred = *red++;
+			hgreen = *green++;
+			hblue = *blue++;
+			if (transp)
+				htransp = *transp++;
+			if (info->fbops->fb_setcolreg(start++,
+						      hred, hgreen, hblue,
+						      htransp, info))
+				break;
+		}
 	}
-	return 0;
+	if (rc == 0)
+		fb_copy_cmap(cmap, &info->cmap);
+
+	return rc;
 }
 
 int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 {
-	int i, start;
-	u16 __user *red, *green, *blue, *transp;
-	u_int hred, hgreen, hblue, htransp = 0xffff;
-
-	red = cmap->red;
-	green = cmap->green;
-	blue = cmap->blue;
-	transp = cmap->transp;
-	start = cmap->start;
+	int rc, size = cmap->len * sizeof(u16);
+	struct fb_cmap umap;
 
-	if (start < 0 || (!info->fbops->fb_setcolreg &&
-			  !info->fbops->fb_setcmap))
+	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
+			        !info->fbops->fb_setcmap))
 		return -EINVAL;
 
-	/* If we can batch, do it */
-	if (info->fbops->fb_setcmap && cmap->len > 1) {
-		struct fb_cmap umap;
-		int size = cmap->len * sizeof(u16);
-		int rc;
-
-		memset(&umap, 0, sizeof(struct fb_cmap));
-		rc = fb_alloc_cmap(&umap, cmap->len, transp != NULL);
-		if (rc)
-			return rc;
-		if (copy_from_user(umap.red, red, size) ||
-		    copy_from_user(umap.green, green, size) ||
-		    copy_from_user(umap.blue, blue, size) ||
-		    (transp && copy_from_user(umap.transp, transp, size))) {
-			rc = -EFAULT;
-		}
-		umap.start = start;
-		if (rc == 0)
-			rc = info->fbops->fb_setcmap(&umap, info);
-		fb_dealloc_cmap(&umap);
+	memset(&umap, 0, sizeof(struct fb_cmap));
+	rc = fb_alloc_cmap(&umap, cmap->len, cmap->transp != NULL);
+	if (rc)
 		return rc;
+	if (copy_from_user(umap.red, cmap->red, size) ||
+	    copy_from_user(umap.green, cmap->green, size) ||
+	    copy_from_user(umap.blue, cmap->blue, size) ||
+	    (cmap->transp && copy_from_user(umap.transp, cmap->transp, size))) {
+		fb_dealloc_cmap(&umap);
+		return -EFAULT;
 	}
-
-	for (i = 0; i < cmap->len; i++, red++, blue++, green++) {
-		if (get_user(hred, red) ||
-		    get_user(hgreen, green) ||
-		    get_user(hblue, blue) ||
-		    (transp && get_user(htransp, transp)))
-			return -EFAULT;
-		if (info->fbops->fb_setcolreg(start++,
-					      hred, hgreen, hblue, htransp,
-					      info))
-			return 0;
-		if (transp)
-			transp++;
-	}
-	return 0;
+	umap.start = cmap->start;
+	rc = fb_set_cmap(&umap, info);
+	fb_dealloc_cmap(&umap);
+	return rc;
 }
 
 /**
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
