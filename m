From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Date: Sun, 17 Jul 2005 20:43:41 +0200
Message-ID: <200507172043.41473.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261337AbVGQSZo@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Resource freeing functions should generally be safe to call with NULL pointers.
Why?
 - there is some precedence in the kernel for this for deallocation functions.
 - removes the need for callers to check pointers for NULL.
 - space is saved overall by less code to test pointers for NULL all over the place.
 - removes possible NULL pointer dereferences when a caller forgot to check.

This patch makes  fb_dealloc_cmap()  safe to call with a NULL pointer argument.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/video/fbcmap.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.13-rc3-orig/drivers/video/fbcmap.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc3/drivers/video/fbcmap.c	2005-07-17 20:33:43.000000000 +0200
@@ -130,6 +130,9 @@ fail:
 
 void fb_dealloc_cmap(struct fb_cmap *cmap)
 {
+	if (unlikely(!cmap))
+		return;
+
 	kfree(cmap->red);
 	kfree(cmap->green);
 	kfree(cmap->blue);
