From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 06 Jan 2015 12:57:02 +0000
Subject: [PATCH] fbdev: geocode: remove unneeded NULL check
Message-Id: <1420548302-11489-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

the check for info is not required as we are checking it immediately
after gxfb_init_fbinfo() and lxfb_init_fbinfo() and returnig -ENOMEM
if it is NULL.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
Hi Tomi,
This patch is similar to my last patch which you have already queued
for 3.20. if you can revert that then i can send you a single patch
with all these three changes together.

 drivers/video/fbdev/geode/gxfb_core.c | 6 ++----
 drivers/video/fbdev/geode/lxfb_core.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index 1790f14..124d7c7 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -444,10 +444,8 @@ static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		pci_release_region(pdev, 1);
 	}
 
-	if (info) {
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-	}
+	fb_dealloc_cmap(&info->cmap);
+	framebuffer_release(info);
 	return ret;
 }
 
diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/geode/lxfb_core.c
index 9e1d19d..138da6c 100644
--- a/drivers/video/fbdev/geode/lxfb_core.c
+++ b/drivers/video/fbdev/geode/lxfb_core.c
@@ -577,10 +577,8 @@ err:
 		pci_release_region(pdev, 3);
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

