From: Jun Nie <niej0001@gmail.com>
Date: Tue, 10 Nov 2009 08:12:25 +0000
Subject: [PATCH 5/8] pxa: frame buffer support both pxa168 and pxa910
Message-Id: <7c34ac520911100012l43680a5fn1ffa2f44d8c27801@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From ce9b930b389f6b2ecbdf0102a6055f737c56979a Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 09:43:57 +0800
Subject: [PATCH] pxa: frame buffer support both pxa168 and pxa910

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    6 ++++++
 include/video/pxa168fb.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 55c69a1..ca0a4d3 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -879,12 +879,18 @@ failed:
 	return ret;
 }

+ static const struct platform_device_id mmpfb_id_table[] = {
+	 {"pxa168-fb", PXA168_FB},
+	 {"pxa910-fb", PXA910_FB},
+ };
+
 static struct platform_driver pxa168fb_driver = {
 	.driver		= {
 		.name	= "pxa168-fb",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pxa168fb_probe,
+	.id_table	= mmpfb_id_table,
 };

 static int __devinit pxa168fb_init(void)
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index efbe469..41f21c5 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -86,6 +86,9 @@
 #define PIX_FMT_PSEUDOCOLOR	20
 #define PIX_FMT_UYVY422PACK	(0x1000|PIX_FMT_YUV422PACK)

+#define PXA168_FB 0x0168
+#define PXA910_FB 0x0910
+
 /*
  * PXA LCD controller private state.
  */
-- 
1.5.4.3
