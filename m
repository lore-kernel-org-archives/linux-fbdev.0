From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Dec 2012 11:55:07 +0000
Subject: [PATCH 3/5] OMAPFB: remove warning when trying to alloc at certain paddress
Message-Id: <1354881309-17625-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb gives a WARN_ONCE if a predefined physical address is given for
allocating the framebuffer memory, as this is not currently supported.

However, the same warning happens if omapfb fails to allocate memory
during runtime, as when the allocation has failed, omapfb tries to
re-allocate the old memory with the physical address of the old memory
area.

Remove the warning from omapfb_alloc_fbmem, as it serves no purpose on
the failure case above, and move it to omapfb_parse_vram_param, so that
we only warn if physical address is given via omapfb module parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 28b2a21..1df973e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1391,9 +1391,6 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 
 	size = PAGE_ALIGN(size);
 
-	WARN_ONCE(paddr,
-		"reserving memory at predefined address not supported\n");
-
 	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
 
 	if (ofbi->rotation_type = OMAP_DSS_ROT_VRFB)
@@ -1521,6 +1518,9 @@ static int omapfb_parse_vram_param(const char *param, int max_entries,
 
 		}
 
+		WARN_ONCE(paddr,
+			"reserving memory at predefined address not supported\n");
+
 		paddrs[fbnum] = paddr;
 		sizes[fbnum] = size;
 
-- 
1.7.10.4

