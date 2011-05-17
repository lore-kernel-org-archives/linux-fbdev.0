From: anish <anish198519851985@gmail.com>
Date: Tue, 17 May 2011 17:40:06 +0000
Subject: [patch 1/2] trivial: preferred form for passing a size of struct
Message-Id: <1305653286.2182.14.camel@anish-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@arm.linux.org.uk, lethal@linux-sh.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The preferred form for passing a size of a struct is the following:
         p = kmalloc(sizeof(*p), ...);
  Please refer Documentation/Codingstyle chapter 14
 Signed-off-by: anish kumar<anish198519851985@gmail.com>

---
 drivers/video/amba-clcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 5fc983c..cb7ec86 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -549,7 +549,7 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
-	fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
+	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
 	if (!fb) {
 		printk(KERN_INFO "CLCD: could not allocate new clcd_fb struct\n");
 		ret = -ENOMEM;
-- 
1.7.0.4





