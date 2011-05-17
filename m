From: anish <anish198519851985@gmail.com>
Date: Tue, 17 May 2011 17:41:02 +0000
Subject: [PATCH 2/2] trivial: Changed the printk loglevel when not able to
Message-Id: <1305653342.2182.15.camel@anish-desktop>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-Pcngg4g4Wi+OELAs/4bI"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux@arm.linux.org.uk, lethal@linux-sh.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--=-Pcngg4g4Wi+OELAs/4bI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When not able to allocate memory we were using KERN_INFO as 
log level in printk so changed to KERN_ERR
 Signed-off-by: anish kumar<anish198519851985@gmail.com>

---
 drivers/video/amba-clcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index cb7ec86..e87d98b 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -551,7 +551,7 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 
 	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
 	if (!fb) {
-		printk(KERN_INFO "CLCD: could not allocate new clcd_fb struct\n");
+		printk(KERN_ERR "CLCD: could not allocate new clcd_fb struct\n");
 		ret = -ENOMEM;
 		goto free_region;
 	}
-- 
1.7.0.4



--=-Pcngg4g4Wi+OELAs/4bI
Content-Disposition: attachment; filename*0=0002-Changed-the-printk-loglevel-when-not-able-to-allocat.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-Changed-the-printk-loglevel-when-not-able-to-allocat.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 19bbb666a6067a6ba280e2cb984c924bcaf06f52 Mon Sep 17 00:00:00 2001
From: anish kumar <anish198519851985@gmail.com>
Date: Tue, 17 May 2011 22:50:59 +0530
Subject: [PATCH 2/2] Changed the printk loglevel when not able to allocate memory
 When not able to allocate memory we were using KERN_INFO so just
 changed to KERN_ERR
 Signed-off-by: anish kumar<anish198519851985@gmail.com>

---
 drivers/video/amba-clcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index cb7ec86..e87d98b 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -551,7 +551,7 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 
 	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
 	if (!fb) {
-		printk(KERN_INFO "CLCD: could not allocate new clcd_fb struct\n");
+		printk(KERN_ERR "CLCD: could not allocate new clcd_fb struct\n");
 		ret = -ENOMEM;
 		goto free_region;
 	}
-- 
1.7.0.4


--=-Pcngg4g4Wi+OELAs/4bI--

