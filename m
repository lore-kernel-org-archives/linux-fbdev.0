From: Julien Grall <julien.grall@citrix.com>
Date: Fri, 07 Aug 2015 16:34:39 +0000
Subject: [PATCH v3 6/9] video/xen-fbfront: Further s/MFN/GFN clean-up
Message-Id: <1438965282-19103-7-git-send-email-julien.grall@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438965282-19103-1-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438965282-19103-1-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xen-devel@lists.xenproject.org
Cc: ian.campbell@citrix.com, stefano.stabellini@eu.citrix.com, linux-kernel@vger.kernel.org, Julien Grall <julien.grall@citrix.com>, David Vrabel <david.vrabel@citrix.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

The PV driver xen-fbfront is only dealing with GFN and not MFN. Rename
all the occurence of MFN to GFN.

Also take the opportunity to replace to usage of pfn_to_gfn by
xen_page_to_gfn.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>

---
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org

    Changes in v3:
        - Typoes in the commit message
        - Renamed page_to_gfn to xen_page_to_gfn

    Changes in v2:
        - Add David's reviewed-by
---
 drivers/video/fbdev/xen-fbfront.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 25e3cce..0567d51 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -46,7 +46,7 @@ struct xenfb_info {
 	int			nr_pages;
 	int			irq;
 	struct xenfb_page	*page;
-	unsigned long 		*mfns;
+	unsigned long 		*gfns;
 	int			update_wanted; /* XENFB_TYPE_UPDATE wanted */
 	int			feature_resize; /* XENFB_TYPE_RESIZE ok */
 	struct xenfb_resize	resize;		/* protected by resize_lock */
@@ -402,8 +402,8 @@ static int xenfb_probe(struct xenbus_device *dev,
 
 	info->nr_pages = (fb_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	info->mfns = vmalloc(sizeof(unsigned long) * info->nr_pages);
-	if (!info->mfns)
+	info->gfns = vmalloc(sizeof(unsigned long) * info->nr_pages);
+	if (!info->gfns)
 		goto error_nomem;
 
 	/* set up shared page */
@@ -530,29 +530,29 @@ static int xenfb_remove(struct xenbus_device *dev)
 		framebuffer_release(info->fb_info);
 	}
 	free_page((unsigned long)info->page);
-	vfree(info->mfns);
+	vfree(info->gfns);
 	vfree(info->fb);
 	kfree(info);
 
 	return 0;
 }
 
-static unsigned long vmalloc_to_mfn(void *address)
+static unsigned long vmalloc_to_gfn(void *address)
 {
-	return pfn_to_gfn(vmalloc_to_pfn(address));
+	return xen_page_to_gfn(vmalloc_to_page(address));
 }
 
 static void xenfb_init_shared_page(struct xenfb_info *info,
 				   struct fb_info *fb_info)
 {
 	int i;
-	int epd = PAGE_SIZE / sizeof(info->mfns[0]);
+	int epd = PAGE_SIZE / sizeof(info->gfns[0]);
 
 	for (i = 0; i < info->nr_pages; i++)
-		info->mfns[i] = vmalloc_to_mfn(info->fb + i * PAGE_SIZE);
+		info->gfns[i] = vmalloc_to_gfn(info->fb + i * PAGE_SIZE);
 
 	for (i = 0; i * epd < info->nr_pages; i++)
-		info->page->pd[i] = vmalloc_to_mfn(&info->mfns[i * epd]);
+		info->page->pd[i] = vmalloc_to_gfn(&info->gfns[i * epd]);
 
 	info->page->width = fb_info->var.xres;
 	info->page->height = fb_info->var.yres;
-- 
2.1.4

