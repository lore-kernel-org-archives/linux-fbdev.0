From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 31 Dec 2014 06:55:51 +0000
Subject: [PATCH] fbdev: geocode: remove unneeded NULL check
Message-Id: <1420008938-18423-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

the check for info is not required as we are checking it immediately
after gx1fb_init_fbinfo() and returnig -ENOMEM if it is NULL.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/geode/gx1fb_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
index 2794ba1..9bee874 100644
--- a/drivers/video/fbdev/geode/gx1fb_core.c
+++ b/drivers/video/fbdev/geode/gx1fb_core.c
@@ -374,10 +374,8 @@ static int gx1fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 	}
 
-	if (info) {
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-	}
+	fb_dealloc_cmap(&info->cmap);
+	framebuffer_release(info);
 
 	return ret;
 }
-- 
1.8.1.2

