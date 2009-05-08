From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 02/15] ps3vram: Use proc_create_data() instead of proc_create()
Date: Fri,  8 May 2009 16:01:11 +0200
Message-ID: <1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761079AbZEHOC4@vger.kernel.org>
In-Reply-To: <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Jim Paris <jim@jtan.com>

Use proc_create_data() to avoid race conditions.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
---
 drivers/block/ps3vram.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 2e79d2c..6e73868 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -546,12 +546,10 @@ static void __devinit ps3vram_proc_init(struct ps3_system_bus_device *dev)
 	struct ps3vram_priv *priv = dev->core.driver_data;
 	struct proc_dir_entry *pde;
 
-	pde = proc_create(DEVICE_NAME, 0444, NULL, &ps3vram_proc_fops);
-	if (!pde) {
+	pde = proc_create_data(DEVICE_NAME, 0444, NULL, &ps3vram_proc_fops,
+			       priv);
+	if (!pde)
 		dev_warn(&dev->core, "failed to create /proc entry\n");
-		return;
-	}
-	pde->data = priv;
 }
 
 static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
-- 
1.6.2.4
