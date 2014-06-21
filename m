From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 21 Jun 2014 13:17:26 +0000
Subject: [PATCH] video: fbdev: skeletonfb.c:  Adding code to managing allocation error
Message-Id: <1403356646-29443-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Adding missing code for managing a memory allocation error that may occur.

This was partly found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/skeletonfb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index fefde7c..ee6dc7e 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -692,6 +692,7 @@ static int xxxfb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 
     if (!info) {
 	    /* goto error path */
+	    return -ENOMEM;
     }
 
     par = info->par;
@@ -746,6 +747,7 @@ static int xxxfb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
     info->pixmap.addr = kmalloc(PIXMAP_SIZE, GFP_KERNEL);
     if (!info->pixmap.addr) {
 	    /* goto error */
+	    return -ENOMEM;
     }
 
     info->pixmap.size = PIXMAP_SIZE;
-- 
1.7.10.4

