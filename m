From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 10:40:42 +0000
Subject: [PATCH] video: s3c-fb: fix typo in comment
Message-Id: <001401cd9c9c$8b6a8ea0$a23fabe0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

"sturucture" should be "structure".

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 52b744f..b855867 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -189,7 +189,7 @@ struct s3c_fb_vsync {
 
 /**
  * struct s3c_fb - overall hardware state of the hardware
- * @slock: The spinlock protection for this data sturucture.
+ * @slock: The spinlock protection for this data structure.
  * @dev: The device that we bound to, for printing, etc.
  * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
  * @lcd_clk: The clk (sclk) feeding pixclk.
-- 
1.7.1


